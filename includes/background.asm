SETREV1 9
.BANK 0 SLOT 0
.ORG $224F+REVOFFSET
.SECTION "DrawBGTiles" OVERWRITE SIZE $51
 DrawBGTiles:
	; Original code except for ApplyAttr:
	ldh a,(<DrawStatus)	;
	cp $01				; DrawStatus=01 if a column needs to be drawn
	ret nz				;

	ldh a,(<CurDrawTile); Lower byte for the BGMAP offset to draw
	ld l,a				;
	inc a				;
	cp $60				;
	jr nz,@NotWinOverflow
	ld a,$40			;
  @NotWinOverflow:
	ldh (<CurDrawTile),a
	ld h,>BGMAP			;
	ld de,CurTileCol	; Column tile data buffer
	ld b,$10			;

  @CopyColumnLoop:
	push hl			; 
	ld a,h			; $98-$9A
	add $30			; 
	ld h,a			; 
	ld (hl),$00		; Clears positional flags
	;pop hl			; 
	;ld a,(de)		; 
	;ld (hl),a		; 
	jp ApplyAttr
	@ApplyAttrEnded:
	cp $70			; 
	jr nz,@NotPipe
	call $22F4+REVOFFSET		; Sets the corresponding positional flags
	jr @Exit

  @NotPipe:
	cp $80
	jr nz,@NotBlock
	call $235A+REVOFFSET		; Sets the corresponding positional flags
	jr @Exit

  @NotBlock:
	cp $5F
	jr nz,@NotHiddenBlock
	call $235A+REVOFFSET		; Sets the corresponding positional flags
	jr @Exit

  @NotHiddenBlock:
	cp $81						; Coin
	call z,$235A+REVOFFSET		; Sets the corresponding positional flags

  @Exit:
	inc e			; 
	push de			; 
	ld de,$0020		; 
	add hl,de		; 
	pop de			; 
	dec b			; 
	jr nz,@CopyColumnLoop
	
	ld a,$02
	ldh (<DrawStatus),a
	ret
.ENDS


.BANK 0 SLOT 0
.SECTION "ApplyAttr" FREE
 ApplyAttr:
	SETVRAM 1
	pop hl
	push hl
	push de
	
	WAITBLANK

	ld a,(de)
	ld e,a
	ld d,>ATTRIBUTES_MAP
	ld a,(de)
	ld (hl),a
	SETVRAM 0
	pop de
	@Exit:
		pop hl
		ld a,(de)		; $226f: $1a
		ld (hl),a		; $2270: $77	[!]

	jp DrawBGTiles@ApplyAttrEnded
.ENDS