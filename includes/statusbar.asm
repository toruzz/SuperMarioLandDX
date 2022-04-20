SETREV1 23
.BANK 0 SLOT 0
.ORG $05F8+REVOFFSET
.SECTION "Statusbar Tiles Copy Routine Hook" OVERWRITE
	FARCALL StatusbarSetRoutine
.ENDS
.BANK BANK_ROUTINES SLOT 1
.SECTION "Statusbar Tiles Copy Routine" FREE
 StatusbarSetRoutine:
	ld a,(PlayerFlag)
	cp $00
	jr z,@Mario
	ld hl,StatusbarTilesLuigi
	jr @PlayerSet
	@Mario:
	ld hl,StatusbarTilesMario
	@PlayerSet:
	ld de,BGMAP
	ld b,$02
  @Loop:
	ldi a,(hl)
	ld (de),a
	inc e
	ld a,e
	and $1F
	cp $14
	jr nz,@Loop
	ld e,$20
	dec b
	jr nz,@Loop
	ret

	StatusbarTilesMario:	.INCBIN "data\\attributes\\StatusbarTilesMario.bin"
	StatusbarTilesLuigi:	.INCBIN "data\\attributes\\StatusbarTilesLuigi.bin"
.ENDS

SETREV1 21
.BANK 0 SLOT 0
.ORG $3F4C+REVOFFSET
.SECTION "Statusbar Tiles 1" OVERWRITE
	ld a,$27
.ENDS
.ORG $3F62+REVOFFSET
.SECTION "Statusbar Tiles 2" OVERWRITE
	ld a,$27
.ENDS

SETREV1 23
.ORG $071B+REVOFFSET
.SECTION "Statusbar Tiles 3" OVERWRITE
	.db $27
.ENDS

SETREV1 21
.ORG $03E8
.SECTION "Split Statusbar and Intro tiles Hook" OVERWRITE
	call SplitStatusIntro
.ENDS
.SECTION "Split Statusbar and Intro tiles" FREE
	SplitStatusIntro:
	xor a			; Original code at $3F38
	ldh ($b1),a		;
	ld c,$03		;
	@Loop:
	ld a,(de)		;
	ld b,a			;
	swap a			;
	and $0F			;
	jp nz,$3F6D+REVOFFSET
	ldh a,($b1)		;
	and a			;
	ld a,$00		;
	jr nz,@Skip		;
	ld a,$2C		;
	@Skip:
	ldi (hl),a		;
	ld a,b			;
	and $0f			;
	jp nz,$3F75+REVOFFSET
	ldh a,($b1)		;
	and a			;
	ld a,$00		;
	jr nz,@Skip2	;
	ld a,$01		;
	cp c			;
	ld a,$00		;
	jr z,@Skip2		;
	ld a,$2c		;
	@Skip2:
	ldi (hl),a		;
	dec e			;
	dec c			;
	jr nz,@Loop		;
	xor a			;
	ldh ($B1),a		;
	ret				;
.ENDS

SETREV1 23
.ORG $0588+REVOFFSET
.SECTION "Statusbar LYC line fix" OVERWRITE
	ld a,$0F
.ENDS
