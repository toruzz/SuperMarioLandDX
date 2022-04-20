.BANK $01 SLOT 1
.ORGA GFXOffset
.SECTION "Bank1GFX" OVERWRITE
	.INCBIN "data\\graphics\\original\\Bank1.2bpp"
.ENDS

; A bit overkill, but I want the new Mushroom in the original offset:
.BANK $02 SLOT 1
.ORGA GFXOffset
.SECTION "Bank2GFX - Original" OVERWRITE
	.INCBIN "data\\graphics\\new\\Mario.2bpp"
	.INCBIN "data\\graphics\\new\\Bank2.2bpp"
.ENDS


.BANK BANK_MARIO SLOT 1
.ORGA $5000
.SECTION "Bank1GFX M" OVERWRITE
	Bank1GFX:
	.INCBIN "data\\graphics\\new\\Bank1.2bpp"
.ENDS
.ORGA $6000
.SECTION "Bank2GFX M" OVERWRITE
	Bank2GFX:
	.INCBIN "data\\graphics\\new\\Mario.2bpp"
	.INCBIN "data\\graphics\\new\\Bank2.2bpp"
.ENDS
.ORGA $4820
.SECTION "Bank3GFX M" OVERWRITE
	Bank3GFX:
	.INCBIN "data\\graphics\\new\\Bank3.2bpp"
.ENDS

.BANK BANK_MARIO_OG SLOT 1
.ORGA $5000
.SECTION "Bank1GFX MO" OVERWRITE
	.INCBIN "data\\graphics\\original\\Bank1.2bpp"
.ENDS
.ORGA $6000
.SECTION "Bank2GFX MO" OVERWRITE
	.INCBIN "data\\graphics\\original\\Mario.2bpp"
	.INCBIN "data\\graphics\\original\\Bank2.2bpp"
.ENDS
.ORGA $4820
.SECTION "Bank3GFX MO" OVERWRITE
	.INCBIN "data\\graphics\\original\\Bank3.2bpp"
.ENDS


.BANK BANK_LUIGI SLOT 1
.ORGA $5000
.SECTION "Bank1GFX L" OVERWRITE
	.INCBIN "data\\graphics\\new\\Bank1.2bpp"
.ENDS
.ORGA $6000
.SECTION "Bank2GFX L" OVERWRITE
	.INCBIN "data\\graphics\\new\\Luigi.2bpp"
	.INCBIN "data\\graphics\\new\\Bank2.2bpp"
.ENDS
.ORGA $4820
.SECTION "Bank3GFX L" OVERWRITE
	.INCBIN "data\\graphics\\new\\Bank3.2bpp"
.ENDS

.BANK BANK_LUIGI_OG SLOT 1
.ORGA $5000
.SECTION "Bank1GFX LO" OVERWRITE
	.INCBIN "data\\graphics\\original\\Bank1.2bpp"
.ENDS
.ORGA $6000
.SECTION "Bank2GFX LO" OVERWRITE
	.INCBIN "data\\graphics\\original\\Luigi.2bpp"
	.INCBIN "data\\graphics\\original\\Bank2.2bpp"
.ENDS
.ORGA $4820
.SECTION "Bank3GFX LO" OVERWRITE
	.INCBIN "data\\graphics\\original\\Bank3.2bpp"
.ENDS



.BANK BANK_INIT SLOT 1
.SECTION "IntroGFX0" FREE
	Titlescreen8000:	.INCBIN "data\\graphics\\titlescreen\\8000.2bpp"
.ENDS
.BANK BANK_ROUTINES SLOT 1
.SECTION "IntroGFX" FREE
	Titlescreen9000:	.INCBIN "data\\graphics\\titlescreen\\9000.2bpp"
	Titlescreen8800:	.INCBIN "data\\graphics\\titlescreen\\8800.2bpp"
.ENDS

.BANK BANK_ROUTINES SLOT 1
.SECTION "VRAM1GFX" FREE
	VRAM1_80:	.INCBIN "data\\graphics\\vram1\\8000.2bpp"
	VRAM1_88:	.INCBIN "data\\graphics\\vram1\\8800.2bpp"
	VRAM1_90:	.INCBIN "data\\graphics\\vram1\\9000.2bpp"
.ENDS



SETREV1 23
.BANK 0 SLOT 0
.ORGA $05D0+REVOFFSET
.SECTION "Fix player's gfx offsets" OVERWRITE
 GFXWrites:
	WRITEDATA Bank2GFX+$1000 $0800 VRAMTABLE2
	WRITEDATA Bank2GFX $1000 VRAMTABLE0
.ENDS



.BANK 0 SLOT 0
.ORGA $0563+REVOFFSET
.SECTION "Make graphics bank relative to the selected player" OVERWRITE SIZE 20
	ldh a,(<IsDemo)
	and a
	ldh a,(<CurPlayerBank)
	ld (SWITCH_BANK),a
	jr nz,@IsDemo
	call Mario.GraphicsPlayer
	jr @GraphicsSet
	@IsDemo:
	call Mario.GraphicsPlayerDemo
	@GraphicsSet:
.ENDS

SETREV1 9
.ORGA $0D3A+REVOFFSET
.SECTION "Fix second data write" OVERWRITE		; [!] Check if this doesn't break anything
	PADDING 3
.ENDS

SETREV1 9
.ORG $1BA6+REVOFFSET
.SECTION "Change Block Color Hook" OVERWRITE
	jr z,CallBlockColor
	cp $81
	call z,$1BF6+REVOFFSET
	CallBlockColor:
	call BlockColor
.ENDS
.SECTION "Change Block Color" FREE
	BlockColor:
	cp $82
	jr z,@RestoringBlock
	ld a,$7F
	@RestoringBlock:
	ld (de),a
	SETVRAM 1
	;ld a,$85
	;ld a,(ATTRIBUTES_MAP+$7F)
	ld l,a
	ld h,>ATTRIBUTES_MAP
	ld a,(hl)
	ld (de),a
	SETVRAM 0
	ret
.ENDS


.ORG $1902+REVOFFSET
.SECTION "Change Sprite Block Color" OVERWRITE
	.db $0B			; Breakable Block
.ENDS
.ORG $1957+REVOFFSET
.SECTION "Change Sprite Block Color 2 Hook" OVERWRITE
	;.db $03			; ? Block
	call BlockColor2
	ret
.ENDS
.SECTION "Change Sprite Block Color 2" FREE
	BlockColor2:
	ldh ($EB),a
	ldi a,(hl)
	cp $82
	jr z,@BouncyBlock
	cp $80
	jr z,@HiddenBlock
	@QuestionBlock:
	ld (hl),$03
	ret
	@BouncyBlock:
	ld (hl),$0D
	ret
	@HiddenBlock:
	ld (hl),$05
	ret
.ENDS

.BANK 2 SLOT 1
.ORGA $5952
.SECTION "Change Sprite Coin Color Hook" OVERWRITE
	call CoinColor
.ENDS
.SECTION "Change Sprite Coin Color" FREE
	CoinColor:
	cp $F5
	jr c,@NotACoin
	ld a,$03
	@SetPal:
	ldi (hl),a
	ldh a,($EC)
	ret
	@NotACoin:
	cp $57
	jr z,@Points
	and $F8
	cp $58
	jr z,@Points
	inc hl
	ldh a,($EC)
	ret
	@Points:
	xor a
	jr @SetPal
.ENDS

SETREV1 9
.BANK 0 SLOT 0
.ORG $0D7E+REVOFFSET
.SECTION "Select the correct gfx bank Hook" OVERWRITE
	call GFXBankFix
	ld a,c
.ENDS
.SECTION "Select the correct gfx bank" FREE
	GFXBankFix:
	ld a,(GraphicsFlag)
	add BANK_MARIO
	ld (SWITCH_BANK),a
	ret
.ENDS

.BANK 0 SLOT 0
.ORG $0DE4+REVOFFSET
.SECTION "Graphics pointers fix" OVERWRITE
	POINTER Bank1GFX		; World 2 sprites
	POINTER Bank3GFX		; World 3 sprites
	POINTER Bank1GFX+$07C0	; World 4 sprites
	POINTER Bank1GFX+$03D0	; World 2 BG
	POINTER Bank3GFX+$03D0	; World 3 BG
	POINTER Bank1GFX+$0B90	; World 4 BG
.ENDS

