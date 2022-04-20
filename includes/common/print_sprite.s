 PlayerSprite:
	; Original code:
 	ld a,<OAM_Player			; Mario Sprite OAM Init Position
	ldh (<OAMTableLowNib),a
	ld hl,OAMAuxData		; $C200: Contains $2114-$216x
	ld a,>OAM_Player			; OAM buffer high nibble
	ldh (<OAMTableHighNib),a
 	ld a,$05				; Loop cycles. Original value: $05. Game will read this many lines of OAMAuxData
	ldh (<Cycles),a			; 

  @Loop:	; Original offset: RO03:4823
	; I rewrote the whole routine so it's more flexible. It's not properly documented, sorry.
	ld a,h					; $C2xx
	ldh (<OAMAuxDataP1),a
	ld a,l					; $xx00
	ldh (<OAMAuxDataP2),a
	ld a,(hl)
	and a
	jr z,@UpdateSprite
	cp $80
	jr z,@HideSprite
	cp STAR_STATE
	jp z,@SuperStar

	@StopSprite:
	ldh a,(<OAMAuxDataP1)
	ld h,a
	ldh a,(<OAMAuxDataP2)
	ld l,a
	ld de,$0010
	add hl,de
	ldh a,(<Cycles)
	dec a
	ldh (<Cycles),a				; Decrement cycles
	ret z
	jr @Loop

	@LoopSprite:
	xor a
	ldh (<PlayerOAMStat),a
	jr @StopSprite

	@HideSprite:
	ldh (<PlayerOAMStat),a
	@UpdateSprite:
	ld b,$07
	ld de,SprUpdateFlag
	@@CopyBlock:
	ldi a,(hl)
	ld (de),a
	inc de
	dec b
	jr nz,@@CopyBlock
	ldh a,(<SpritePointer)

	dec hl
	dec hl
	ld b,(hl)
	ld hl,MarioPointers
	rlca					; *2
	ld e,a
	ld d,$00
	add hl,de				; HL: Sprite pointer

	ld a,b
	cp $20
	jr nz,@NotReversed
	ld a,MarioPointers@Reversed-MarioPointers@Default
	add l
	ld l,a
	jr nc,@NoOverflow
	inc h
	@NoOverflow:

	@NotReversed:
	ld e,(hl)
	inc hl
	ld d,(hl)

	ldh a,(<OAMTableHighNib)
	ld h,a
	ldh a,(<OAMTableLowNib)
	ld l,a

	ldh a,(<PlayerOAMStat)
	and a
	jr z,@NotHidden

	ld a,$FF
	ldh (<SpriteRelY),a

	@NotHidden:

	@@LoopSprite:
	ld a,(de)			; Relative PosY
	cp $80
	jr z,@SpriteEnded
	ld b,a
	ldh a,(<SpriteRelY)	; Sprite PosY
	add b
	ldi (hl),a			; Sets PosY
	inc de

	ld a,(de)			; Relative PosX
	ld b,a
	ldh a,(<SpriteRelX)	; Sprite PosX
	add b
	ldi (hl),a			; Sets PosX
	inc de

	ld a,(de)
	ldi (hl),a			; Sets Tile No.
	inc de

	ld a,(de)
	ldi (hl),a			; Sets Attributes (needs the relative one)
	inc de
	jr @@LoopSprite


	@SpriteEnded:
	ld a,l
	cp $2C
	jr nz,@@StillFits

	ld a,$98
	;ld a,$A0

	@@StillFits:
	ldh (<OAMTableLowNib),a
	ld a,h
	ldh (<OAMTableHighNib),a
	@@Loop:
	ld a,l
	cp $2C					; Max tiles*4 + $0C
	jp nc,@LoopSprite
	cp $A0
	jp z,@LoopSprite
	xor a
	ldi (hl),a
	jr @@Loop

	@SuperStar:
	ld b,$07
	ld de,SprUpdateFlag
	@@CopyBlock:
	ldi a,(hl)
	ld (de),a
	inc de
	dec b
	jr nz,@@CopyBlock
	ldh a,(<SpritePointer)

	ld hl,MarioPointers
	rlca					; *2
	ld e,a
	ld d,$00
	add hl,de				; HL: Sprite pointer

	ld a,($C205)
	cp $20
	jr nz,@@NotReversed
	ld a,MarioPointers@Reversed-MarioPointers@Default
	add l
	ld l,a
	jr nc,@@NoOverflow
	inc h
	@@NoOverflow:

	@@NotReversed:
	ld e,(hl)
	inc hl
	ld d,(hl)

	ldh a,(<OAMTableHighNib)
	ld h,a
	ldh a,(<OAMTableLowNib)
	ld l,a

	@@LoopSprite:
	ld a,(de)			; Relative PosY
	cp $80
	jp z,@SpriteEnded
	ld b,a
	ldh a,(<SpriteRelY)	; Sprite PosY
	add b
	ldi (hl),a			; Sets PosY
	inc de

	ld a,(de)			; Relative PosX
	ld b,a
	ldh a,(<SpriteRelX)	; Sprite PosX
	add b
	ldi (hl),a			; Sets PosX
	inc de

	ld a,(de)
	ldi (hl),a			; Sets Tile No.
	inc de

	ld a,(de)
	and $28
	ld b,a
	ldh a,(<Counter)
	rrc a
	rrc a
	and $07
	add b

	ldi (hl),a			; Sets Attributes (needs the relative one)
	inc de
	jr @@LoopSprite
	