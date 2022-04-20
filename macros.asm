; **************
; *** MACROS ***
; **************

; Uses the game's CopyData routine to copy BC bytes from HL to DE.
; If only two args are used, BC is obtained through HL's label.
.MACRO WRITEDATA
	.IF NARGS < 2
		.FAIL
	.ENDIF
	.IF NARGS > 3
		.FAIL
	.ENDIF
	.IF NARGS == 2
		ld hl,\1
		ld bc,_sizeof_\1
		ld de,\2
	.ENDIF
	.IF NARGS == 3
		ld hl,\1
		ld bc,\2
		ld de,\3
	.ENDIF
	call CopyData
.ENDM


.MACRO WRITEDATASAFE
	ld hl,\1
	ld de,\2
	ld b,_sizeof_\1
	call CopyDataSafe
.ENDM

; Set VRAM0 or VRAM1 depending on the argument. Keeps A, writes over HL.
.MACRO SETVRAM
	.IF NARGS != 1
		.FAIL
	.ENDIF
	.IF \1 == 0
		ld hl,VBK
		res 0,(hl)
	.ELSE
		ld hl,VBK
		set 0,(HL)
	.ENDIF
.ENDM

; Switches to an offset's bank and jumps to it
.MACRO GOTO
	.IF NARGS == 0
		.FAIL
	.ENDIF
	.IF NARGS > 2
		.FAIL
	.ENDIF
	.IF NARGS == 1
		ld a,:\1
		ld hl,\1
		jp SWITCHBANK_JUMPHL
	.ENDIF
	.IF NARGS == 2
		ld a,\1
		ld hl,\2
		jp SWITCHBANK_JUMPHL
	.ENDIF
.ENDM

.BANK 0 SLOT 0
.SECTION "GotoRoutines" FREE
	; Switches to Bank A and jumps to HL.
	SWITCHBANK_JUMPHL:
		ldh (<BANK_CURRENT),a
	SWITCHBANK_JUMPHL_unsafe:
		ld (SWITCH_BANK),a
		jp hl
.ENDS

; Adds spaces
.MACRO PADDING
	.IF NARGS == 0
		.FAIL
	.ENDIF
	
	.REPEAT \1
		nop
	.ENDR
.ENDM

; This writes BG & OBJ palettes at any point in the code, no buffer.
; If you provide an argument, it's used as the palette's offset (BG+OBJ).
; If none is used, it's assumed that the palette's offset is stored in HL.
.MACRO WRITEPALS ARGS PALETTE
	; *BG PAL*
	.IF NARGS == 0
		push hl
	.ELSE
		ld hl,PALETTE
	.ENDIF
	ld a,PALINIT
	ldh (<BCPS),a
	ld b,PALSIZE
	
	; Checks if $FF69 is accessible:
	@LoopBGPALForce\@:
	WAITBLANK
	
	; Sets BG Palettes:
	ldi a,(hl)
	ldh (<BCPD),a
	dec b
	jr nz,@LoopBGPALForce\@
	
	; *OBJ PAL*
	.IF NARGS == 0
		pop hl
		ld de,PALSIZE
		add hl,de
	.ELSE
		ld hl,PALETTE+PALSIZE
	.ENDIF
	ld a,PALINIT
	ldh (<OCPS),a	; 
	ld b,PALSIZE
	
	; Checks if $FF69 is accessible:
	@LoopOBJPALForce\@:
	WAITBLANK
	
	; Sets OBJ Palettes:
	ldi a,(hl)
	ldh (<OCPD),a
	dec b
	jr nz,@LoopOBJPALForce\@
.ENDM


; This is the same as WRITEPALS but avoids overwritting anything character-specific
.MACRO WRITEPARTIALPALS ARGS PALETTE SKIP
	.IF NARGS < 1
		.FAIL
	.ENDIF
	.IF NARGS > 2
		.FAIL
	.ENDIF
	; *BG PAL*
	ld hl,PALETTE
	ld a,PALINIT
	ldh (<BCPS),a
	ld b,PALSIZE
	
	; Checks if $FF69 is accessible:
	@LoopBGPALForce\@:
	WAITBLANK
	
	; Sets BG Palettes:
	ldi a,(hl)
	ldh (<BCPD),a
	dec b
	jr nz,@LoopBGPALForce\@
	
	; *OBJ PAL*
	.IF NARGS == 1
		ld hl,PALETTE+PALSIZE+PALUNIT*4
		ld a,$A0
		ldh (<OCPS),a	; 
		ld b,PALUNIT*4
	.ENDIF
	.IF NARGS == 2
		ld hl,PALETTE+PALSIZE+PALUNIT*SKIP
		ld a,PALUNIT*SKIP+128		; 128 = $80: Autoincrement
		ldh (<OCPS),a	; 
		ld b,PALUNIT*(8-SKIP)
	.ENDIF
	
	; Checks if $FF69 is accessible:
	@LoopOBJPALForce\@:
	WAITBLANK
	
	; Sets OBJ Palettes:
	ldi a,(hl)
	ldh (<OCPD),a
	dec b
	jr nz,@LoopOBJPALForce\@
.ENDM


; This waits for V-Blank or H-Blank so both OAM and display RAM are accessible
.MACRO WAITBLANK
	@@wait\@:
	ldh a,(<STAT)
	bit  1,a			; Wait until Mode is 0 or 1
	jr nz,@@wait\@
.ENDM
.MACRO WAITBLANK_DMG
	.IF DOUBLESPEED == 0
		WAITBLANK
	.ENDIF
.ENDM


.MACRO WAITVBLANK
	@wait\@:
	ldh a,(<STAT)
	and $03				; Wait until Mode is 0 or 1
	cp $01
	jr nz,@wait\@
.ENDM

; Stores the current Bank, switches to the bank in which the routine is located and calls it.
; Then it goes backs to the current bank. It takes 21/h15 bytes.
.MACRO FARCALL
	ldh a,(<BANK_CURRENT)
	ldh (<BANK_BUFFER),a

	ld a,:\1
	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	call \1

	ldh a,(<BANK_BUFFER)
	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
.ENDM

.MACRO BUFFERPAL
	.IF NARGS != 1
		.FAIL
	.ENDIF
	WRITEDATA \1 PALSIZE PAL_BUFFER@BG
	WRITEDATA \1+PALSIZE PALSIZE PAL_BUFFER@OBJ
.ENDM

.MACRO BUFFERPALINIT
	.IF NARGS != 1
		.FAIL
	.ENDIF
	WRITEDATA \1 PALSIZE PAL_BUFFER@BG
	WRITEDATA \1+PALSIZE PALSIZE PAL_BUFFER@OBJ
	
	WRITEDATA \1+PALSIZE PALUNIT PAL_CHARBUFFER
	WRITEDATA \1+PALSIZE PALUNIT PAL_CHARBUFFER_UG
.ENDM

.MACRO BUFFERPARTIALPAL
	.IF NARGS < 1
		.FAIL
	.ENDIF
	.IF NARGS >2
		.FAIL
	.ENDIF
	WRITEDATA \1 PALSIZE PAL_BUFFER@BG
	.IF NARGS == 1
		WRITEDATA \1+PALSIZE+PALUNIT*4 PALUNIT*4 PAL_BUFFER@OBJ+PALUNIT*4
	.ENDIF
	.IF NARGS == 2
		WRITEDATA \1+PALSIZE+PALUNIT*\2 PALUNIT*(8-\2) PAL_BUFFER@OBJ+PALUNIT*\2
	.ENDIF
.ENDM


.MACRO POINTER
	.IF NARGS != 1
		.FAIL
	.ENDIF
	.db <\1,>\1
.ENDM

.MACRO SETREV1
	.IF REV == 1
		.REDEFINE REVOFFSET \1
	.ENDIF
.ENDM

.MACRO INCLEVEL
 Level\1PAL:
	@BG:
		.INCBIN "data\\palettes\\partials\\HUD.pal" READ PALUNIT
		.INCBIN "data\\palettes\\levels\\\2\\\1.pal" SKIP PALUNIT READ PALSIZE-PALUNIT
	@OBJ:
	.IF NARGS < 3
		.FAIL
	.ENDIF
	.IF NARGS == 3
		.INCBIN "data\\palettes\\partials\\Player\\\3.pal" READ PALUNIT+4
	.ELSE
		.INCBIN "data\\palettes\\partials\\Player\\\3\4.pal" READ PALUNIT+4
	.ENDIF
	.IF NARGS == 5
		.INCBIN "data\\palettes\\levels\\\2\\\1\5.pal" SKIP PALSIZE+PALUNIT+4 READ PALUNIT*7-4
	.ELSE
		.INCBIN "data\\palettes\\levels\\\2\\\1.pal" SKIP PALSIZE+PALUNIT+4 READ PALUNIT*7-4
	.ENDIF
 Level\1Attrs:
	.INCBIN "data\\attributes\\levels\\\2\\\1.bin"
.ENDM

.MACRO INCMIDLEVEL
	; Every time this is called, it generates a label called "<ARG0>PAL<ARG1>:"
	; followed by the BG and OBJ palettes located at <ARG0>*$80
 	.REDEFINE PALBLOCK \3*PALSIZE*2
	Level\1PAL\3:
	@BG:
		.INCBIN "data\\palettes\\partials\\HUD.pal" READ PALUNIT
		.INCBIN "data\\palettes\\levels\\\2\\\1.pal" SKIP PALBLOCK+PALUNIT READ PALUNIT*7
	@OBJ:
		.INCBIN "data\\palettes\\partials\\Player\\Mario.pal" READ PALUNIT
		.INCBIN "data\\palettes\\partials\\Misc.pal"
		.INCBIN "data\\palettes\\partials\\Mushroom.pal"
		.INCBIN "data\\palettes\\partials\\Coins.pal"
		.INCBIN "data\\palettes\\levels\\\2\\\1.pal" SKIP PALBLOCK+PALSIZE+PALUNIT*4 READ PALUNIT*4
.ENDM

.MACRO MIDLEVEL
	.IF NARGS == 0
		.FAIL
	.ENDIF
	.IF NARGS > 2
		.FAIL
	.ENDIF

	.IF NARGS == 1
		BUFFERPARTIALPAL \1
		WRITEPARTIALPALS PAL_BUFFER
	.ENDIF
	.IF NARGS == 2
		BUFFERPARTIALPAL \1 \2
		WRITEPARTIALPALS PAL_BUFFER \2
	.ENDIF
	jp @Exit
.ENDM