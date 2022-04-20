;*****************************************
;****       SUPER MARIO LAND DX       ****
;****  v2.0  — Iván Delgado (toruzz)  ****
;*****************************************

; ***************************
; ***  HEADER & INCLUDES  ***
; ***************************

.MEMORYMAP
	DEFAULTSLOT 1
	SLOTSIZE $4000
	SLOT 0 $0000
	SLOT 1 $4000
	SLOT 2 $A000
.ENDME

.ROMBANKSIZE $4000
.ROMBANKS 16					; ROM expanded to 4x the original size
.RAMSIZE 2						; RAM expanded to 8kB (1 bank)
.ROMGBCONLY
.COMPUTEGBCOMPLEMENTCHECK
.COMPUTEGBCHECKSUM
.CARTRIDGETYPE $1B				; Ported it to MBC3 and added battery. This game doesn't need specific fixes for it.

.BACKGROUND "sml.gb"			; Backgrounded ROM is 4 banks

.DEFINE DEBUG 0					; DEBUG Mode
.DEFINE OPTIONS 1				; OPTIONS=	1 Options menu, OPTIONS!=1 DX sprites only
.DEFINE DOUBLESPEED 1			; DOUBLESPEED=1 enables GBC's double speed mode

.UNBACKGROUND $0143 $0143		; CGB Flag
.UNBACKGROUND $0147 $014A		; Cart type, ROM Size, RAM Size
.UNBACKGROUND $014D $014F		; Checksum

.INCLUDE "macros.asm"			; Macros
.INCLUDE "definitions.asm"		; Definitions & hooks

.IF OPTIONS == 1
	.INCLUDE "includes/options.asm"		; Options menu
.ENDIF

.INCLUDE "includes/bonus.asm"			; Bonus fixes
.INCLUDE "includes/player.asm"
.INCLUDE "includes/graphics.asm"
.INCLUDE "includes/sprites.asm"
.INCLUDE "includes/background.asm"
.INCLUDE "includes/palettes.asm"
.INCLUDE "includes/statusbar.asm"
.INCLUDE "includes/fixes.asm"
.INCLUDE "includes/titlescreen.asm"
.INCLUDE "includes/text.asm"
.INCLUDE "includes/RAM.asm"				; Routines copied to RAM during initialization
.INCLUDE "includes/physics.asm"

; ***************
; ***  DEBUG  ***
; ***************

SETREV1 9
.IF DEBUG == 1
	.BANK 0 SLOT 0
	.ORG $0215
	.SECTION "Stage select" OVERWRITE
		ld a,$02
	.ENDS
	.BANK 0 SLOT 0
	.ORG $1F03+REVOFFSET
	.SECTION "Invincibility" OVERWRITE
		nop
	.ENDS
	.ORG $3D3F+REVOFFSET
	.SECTION "99lives" OVERWRITE
		ld a,$90		; Breaks bonus ladder
	.ENDS
.ENDIF


; *******************
; ***  MAIN CODE  ***
; *******************

.BANK 0 SLOT 0
.ORG $0048
.SECTION "LCDCStatus Interrupt" OVERWRITE
	jp LCDCStatus
.ENDS

SETREV1 9
.BANK 0 SLOT 0
.ORG $0060
.SECTION "VBlank" OVERWRITE SIZE $A0
  VBlank:
	push af
	push bc
	push de
	push hl

	xor a					; / This code sets the scroll position to show the statusbar. It was originally placed
	ldh (<SCX),a			; | after @InGame,but I moved it here to prioritize it and remove its flickering.
	ldh (<SCY),a			; \ This was needed as the black background made it more noticeable.

	call DrawBGTiles
	call VBlankRoutine1		; Collisions routine?
	call VBlankRoutine2		; Scripted movements?
	call VBlankRoutine3		; OAM DMAimpy
	call VBlankRoutine4		; Updates score?
	call VBlankRoutine5		; No idea
	call $23F8+REVOFFSET	; Tile animations
	call RAMCode@DXEvents
	call $0153				; Updates Mario's X & Y coords, which also fixes stutter in doublespeed mode

	ld hl,Counter
	inc (hl)

	ldh a,(<GameStatus)
	cp $3A
	jr nz,@InGame
	ld hl,LCDC
	set 5,(hl)
	@InGame:

	inc a
	ldh (<VBlankFinished),a
	pop hl
	pop de
	pop bc
	pop af
	reti

 LCDCStatus:
	push af
	push hl

  @Loop:
	ldh a,(<STAT)			; Waits for H-Blank. Not sure if this causes "framerate" issues
	and $03					;
	jr nz,@Loop				;
	;PADDING 6

	ld a,(PreventBGScroll)
	and a
	jr nz,@Exit

	ldh a,(<cSCX)
	ldh (<SCX),a
	ld a,(IsPosYLocked)
	and a
	jr z,@NormalY			;
	ld a,(PosYOffset)		; Pixels to move the screen up
	ldh (<SCY),a
  @NormalY:
	ldh a,(<GameStatus)
	cp $3A					; If $3A, it's scrolling Y (e.g. Game Over)
	jr nz,@NotScrollingY
	ld hl,WY
	ld a,(hl)
	cp $40					; Scanline 64? Probably also related to the GameOver banner
	jr z,@GameOverBannerEnded
	dec (hl)
	cp $87
	jr nc,@NotScrollingY
  @ScrollingY:
	add $07					;
	ldh (<LYC),a			; End of Game over box
	ld (PreventBGScroll),a	;
  @NotScrollingY:
	pop hl					;
	pop af					;
	reti					;
  @Exit:
	ld hl,LCDC
	res 5,(hl)				;
	ld a,$0F				;
	ldh (<LYC),a			; Start of the Game over box
	xor a					;
	ld (PreventBGScroll),a	;
	jr @NotScrollingY		;
  @GameOverBannerEnded:

	push af
	ldh a,(<GameOverCounter)
	and a
	jr z,@StartScreen
	dec a
	ldh (<GameOverCounter),a
  @SubScroll:
	pop af
	jr @ScrollingY
  @StartScreen:
	ld a,$FF
	ld (GameOverFinished),a
	jr @SubScroll

.ENDS


.BANK 0 SLOT 0
.ORG $0344
.SECTION "InitHook" SIZE $18 OVERWRITE
	FARCALL Init
.ENDS

.BANK BANK_ROUTINES SLOT 1
.SECTION "Init" FREE
	Init:
	GOTO DMGSplash

	InitGBC:

	.IF DOUBLESPEED == 1
		ldh a,($02)
		set 1,a
		ldh ($02),a

		@DoubleSpeedMode:
		ldh a,($4D)
		rlca            			; Is GBC already in double speed mode?
		jr c,@AlreadyDoubleSpeed
		di
		ld hl,$FFFF
		ld a,(hl)
		push af
		xor a
		ld (hl),a
		ldh ($0F), a
		ld a,$30
		ldh ($00),a
		ld a,$01
		ldh ($4D),a
		stop
		nop
		pop af
		ld (hl),a
		ei
		@AlreadyDoubleSpeed:
	.ENDIF

	; Inits the VRAM bank 1 graphics
	SETVRAM 1
	WRITEDATA VRAM1_80 VRAMTABLE0
	WRITEDATA VRAM1_88 VRAMTABLE1
	WRITEDATA VRAM1_90 VRAMTABLE2
	SETVRAM 0

	; Inits the enemies' sprite table:
	ld a,<SprTable
	ld (CurSprTable),a
	ld a,>SprTable
	ld (CurSprTable+1),a

	; Inits external RAM:
	ld a,$0A
	ld ($0000),a
	xor a
	ld ($5000),a
	ld (SVBK),a

	WRITEDATA RAMCodeSource $A000

	ld a,(MemoryInitialized)	; Flag
	cp $77
	jr z,@MemoryInitialized

	; Sets the default options in case the RAM isn't initialized
	; Graphics: New, Player: Mario, Mode: Normal (all 00s)
	xor a
	ld (GraphicsFlag),a
	ld (PlayerFlag),a
	ld (ModeFlag),a

	ld (SavedScore),a
	ld (SavedScore+1),a
	ld (SavedScore+2),a
	ld (SaveTimesCompleted),a

	WRITEDATA VTableMarioBin VTableMario
	WRITEDATA VTableLuigiBin VTableLuigi
	WRITEDATA XTableMarioBin XTableMario
	WRITEDATA XTableLuigiBin XTableLuigi

	ld a,$77
	ld (MemoryInitialized),a
	@MemoryInitialized:

	; Inits the current player's bank:
	ld a,(PlayerFlag)		;
	rlc a					; *2
	ld b,a					;
	ld a,(GraphicsFlag)		;
	add b					;
	add BANK_MARIO			; a: Bank for the current player ($08-$0B)
	ldh (<CurPlayerBank),a

	; Start screen's mushroom/Mario attribute. Sorry it's this lazy.
	ldh a,(<HardMode)
	cp $00
	jr nz,@HardMode
	ld a,$01
	jr @ModeSelected
	@HardMode:
	ld a,$04
	@ModeSelected:
	ld (OAM_Table.2.attrs),a		; This is the buffer location for this object's attribute

	xor a
	ld (OptionsFlag),a				; Set the options menu as closed
	ld (ShooterCounter),a			; And cleans the shooter counter
	ldh (<FireFlower),a				; Inits the Fire Flower flag

.IF DEBUG == 0
	ld a,(SaveTimesCompleted)
	ld (TimesCompleted),a
	ld (HardMode),a
.ENDIF


	; Original replaced code at InitHook
	WRITEDATA Titlescreen9000 VRAMTABLE2+_sizeof_InvertedAlphabet
	WRITEDATA Titlescreen8800 VRAMTABLE1
	ret

	VTableMarioBin: .INCBIN "data\\VTableMario.bin"
	VTableLuigiBin: .INCBIN "data\\VTableLuigi.bin"
	XTableMarioBin: .INCBIN "data\\XTableMario.bin"
	XTableLuigiBin: .INCBIN "data\\XTableLuigi.bin"
.ENDS


.BANK BANK_INIT SLOT 1
.SECTION "DMGSplash" FREE
	DMGSplash:

	; This checks $FF4D's bit 7 to decide if the hardware is GBC. Not the best way, but it works ($00 = GBC):
	ldh a,($4D)
	and $7F
	cp $7F
	jr z,@IsDMG

	GOTO InitGBC

	@IsDMG:
	ld a,$E4						; DMG regular BG Palette
	ldh ($47),a						; Sets the palette

	WRITEDATA DMGGFX VRAMTABLE0		; Copies tiles to VRAM
	WRITEDATA DMGTileAttrs BGMAP	; Copies BG tile arrangement data

	ld a,$91						;
	ldh ($40),a						; LCD on, display BG, upper tile data

	InfiniteLoop:
	jr InfiniteLoop

	DMGGFX:			.INCBIN "data\\graphics\\titlescreen\\DMG.2bpp"
	DMGTileAttrs:	.INCBIN "data\\attributes\\titlescreen\\DMG.tilemap"
.ENDS


.IF DOUBLESPEED == 1
	; *** Music fix for double speed mode ***
	.BANK 0 SLOT 0
	.ORG $0050
	.SECTION "TimerInt" OVERWRITE
		push af
		ld a,$03
		ld (SWITCH_BANK),a
		call MusicDiv
		call ClearTimerInt
		pop af
		reti
	.ENDS
	.ORG $0034
	.SECTION "ClearTimerInt" OVERWRITE
	ClearTimerInt:
		ldh a,(<BANK_CURRENT)
		ld (SWITCH_BANK),a
		ret
	.ENDS
	.BANK $03 SLOT 1
	.ORGA $7FF6
	.SECTION "MusicDiv" FREE
		MusicDiv:
		ldh a,(<Counter)
		bit 0,a			; Is it an even number?
		; If it is, execute the music routine as usual
		.IF REV == 0
			jp z,$6762
		.ELSE
			jp z,$6662
		.ENDIF
		ret				; If it isn't, go back
	.ENDS
.ENDIF

SETREV1 9
.BANK 0 SLOT 0
.ORG $1F0F+REVOFFSET
.SECTION "SuperStar Custom State" OVERWRITE
	xor STAR_STATE
.ENDS


.BANK 0 SLOT 0
.ORG $03C2
.SECTION "Save score to cart" OVERWRITE
	ld de,SavedScore+2
.ENDS
.ORG $03D7
.SECTION "Save score to cart 2" OVERWRITE
	ld de,SavedScore+2
.ENDS
.ORG $03E2
.SECTION "Save score to cart 3" OVERWRITE
	ld de,SavedScore+2
.ENDS

SETREV1 9
.BANK 0 SLOT 0
.ORG $1C73+REVOFFSET
.SECTION "GameOver Tiles Routine" OVERWRITE
	call RAMCode@GameOverFix
	ld hl,BGMAP2
	ld b,$34
.ENDS

; Old values can be freed now:
.IF REV == 0
	.UNBACKGROUND $1CCE $1CDE		; Not sure how to not hardcode this
.ELSE
	.UNBACKGROUND $1CD7 $1CE7		; ""
.ENDIF


; Updates the BG animations from 2 frames to 4 frames
SETREV1 9
.BANK 0 SLOT 0
.ORG $2402+REVOFFSET
.SECTION "Tile animation" SIZE $2B OVERWRITE
	ldh a,(<Counter)
	and $07					; $2404: $e6 $07
	ret nz					; $2406: $c0
	ld hl,AnimatedTilesBuffer
	ld de,$0010
	ldh a,(<Counter)
	and $18
	cp $00
	jr z,@Tock
	add hl,de
	cp $08
	jr z,@Tock
	add hl,de
	cp $10
	jr z,@Tock
	add hl,de
	@Tick:

	@Tock:
	ld de,$95D0 ;$95D1
	ld b,$10	;$08
	@Loop:
	ldi a,(hl)
	ld (de),a
	inc de
	;inc de
	dec b
	jr nz,@Loop
	ret
.ENDS


SETREV1 9
.BANK 0 SLOT 0
.ORG $10F9+REVOFFSET
.SECTION "Ending Fadeout Hook" OVERWRITE
	call FadeOutB0
	ret
.ENDS
.SECTION "Ending Fadeout B0" FREE
 FadeOutB0:
	FARCALL FadeOut
	ret
.ENDS
.BANK BANK_INIT SLOT 1
.SECTION "Ending Fadeout" FREE
	FadeOut:
	ld a,$3F
	ldh ($A6),a
	ld a,d
	cp $BF
	call z,@White1
	cp $EC
	call z,@White2
	cp $A1
	call z,@White3
	ret

	@White1:
	ld b,$88
	call @Apply1
	ld b,$B0
	call @Apply1
	ld b,$B8
	call @Apply1
	ret
	@White2:
	ld b,$88
	call @Apply2
	ld b,$B0
	call @Apply2
	ld b,$B8
	call @Apply2
	ret
	@White3:
	ld b,$88
	call @Apply3
	ld b,$B0
	call @Apply3
	ld b,$B8
	call @Apply3
	ret


	@Apply1:
	WAITBLANK
	ld a,b
	ldh (<BCPS),a
	ld a,$54
	ldh (<BCPD),a
	ld a,$7B
	ldh (<BCPD),a
	ret
	@Apply2:
	WAITBLANK
	ld a,b
	ldh (<BCPS),a
	ld a,$BA
	ldh (<BCPD),a
	ld a,$7F
	ldh (<BCPD),a
	ret
	@Apply3:
	WAITBLANK
	ld a,b
	ldh (<BCPS),a
	ld a,$FF
	ldh (<BCPD),a
	ld a,$7F
	ldh (<BCPD),a
	ret
.ENDS






