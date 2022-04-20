	ld a,(GraphicsFlag)
	swap a
	ld b,a
	
	ld a,(PlayerFlag)
	add b
	cp $11
	jr z,@OldLuigi
	cp $10
	jr z,@OldMario
	cp $01
	jr z,@NewLuigi

  @NewMario:
	ld hl,@MarioData@Palette
	call @SetPlayersColors
	ld a,$31
	ld ($C076),a
	ld a,$41
	ld ($C07A),a
	ld a,$40
	ld ($C07E),a

	WAITBLANK
	ld hl,@MarioData@Sprite
	jr @Exit

  @NewLuigi:
	ld hl,@LuigiData@Palette
	call @SetPlayersColors
	ld a,$5B
	ld ($C08E),a
	ld a,$5C
	ld ($C092),a

	WAITBLANK
	ld hl,@LuigiData@Sprite
	jr @Exit

  @OldMario:
	ld hl,@MarioOGData@Palette
	call @SetPlayersColors
	ld a,$3C
	ld ($C076),a
	ld a,$4C
	ld ($C07A),a
	ld a,$4B
	ld ($C07E),a

	WAITBLANK
	ld hl,@MarioOGData@Sprite
	jr @Exit

  @OldLuigi:
	ld hl,@LuigiOGData@Palette
	call @SetPlayersColors
	ld a,$55
	ld ($C08E),a
	ld a,$56
	ld ($C092),a

	WAITBLANK
	ld hl,@LuigiOGData@Sprite

   @Exit:
	call pickSpriteBasedOnDifficulty
	call @SetPlayersSprite
	
	ld a,(PlayerFlag)		;
	rlc a					; *2
	ld b,a					;
	ld a,(GraphicsFlag)		;
	add b					;
	add BANK_MARIO			; a: Bank for the current player ($08-$0B)
	ldh (<CurPlayerBank),a
	ret



  @SetPlayersColors:
	ld a,$B2
	ldh (<OCPS),a

	ld b,$0E
	@Loop:
	WAITBLANK
	ldi a,(hl)
	ldh (<OCPD),a
	dec b
	jr nz,@Loop
	ret




  @SetPlayersSprite:
  
	ld a,(ModeFlag)
	swap a
	ld b,a
	ld a,(PlayerFlag)
	add b
	cp $11
	jr z,@HardLuigi
	cp $10
	jr z,@HardMario
	cp $01
	jr z,@NormalLuigi
	@NormalMario:
	ld a,$43
	ld ($C05E),a
	ld a,$30
	ld ($C072),a
	;ld a,$31
	;ld ($C076),a
	jr @SetSprite

	@HardMario:
	ld a,$32
	ld ($C05E),a
	ld a,$3D
	ld ($C072),a
	;ld a,$4D
	;ld ($C076),a
	jr @SetSprite
	
	@NormalLuigi:
	ld a,$48
	ld ($C06A),a
	ld a,$35
	ld ($C07E),a
	ld a,$46
	ld ($C08A),a
	ld a,$49
	ld ($C06E),a

	jr @SetSprite

	@HardLuigi:
	ld a,$51
	ld ($C06A),a
	ld a,$5D
	ld ($C07E),a
	ld a,$6A
	ld ($C08A),a
	ld a,$3E
	ld ($C06E),a

  @SetSprite:
	ld de,OAM_Table.3.posY
	ld b,$1C
	@@Loop:
	ldi a,(hl)
	ld (de),a
	inc de
	dec b
	jr nz,@@Loop
	ret



  @MarioData:
	@@Palette:
	.INCBIN "data\\palettes\\partials\\Titlescreen\\Mario.pal"
	@@PaletteHardMode:
	.INCBIN "data\\palettes\\partials\\Titlescreen\\Mario2.pal"
	@@Sprite:
	.db $64,$16,$60,$06
	.db $64,$1E,$61,$06
	.db $6C,$16,$70,$06
	.db $6C,$1E,$71,$06
	.db $66,$19,$68,$00
	.db $6E,$19,$78,$00
	.db $6E,$21,$79,$00
	@@Sprite2:
	.db $64,$16,$64,$06
	.db $64,$1E,$65,$06
	.db $6C,$16,$74,$06
	.db $6C,$1E,$75,$06
	.db $68,$19,$68,$00
	.db $6D,$19,$4D,$00
	.db $00,$00,$00,$00

  @MarioOGData:
	@@Palette:
	.db         $BF,$3A,$5A,$08,$ED,$00
	.db $BF,$62,$1D,$10,$84,$61,$35,$05

	@@Sprite:
	.db $64,$16,$6E,$06
	.db $64,$1E,$6F,$06
	.db $6C,$16,$7E,$06
	.db $6C,$1E,$7F,$06
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00
	@@Sprite2:
	.db $64,$16,$6C,$06
	.db $64,$1E,$6D,$06
	.db $6C,$16,$7C,$06
	.db $6C,$1E,$7D,$06
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00

  @LuigiData:
	@@Palette:
	.INCBIN "data\\palettes\\partials\\Titlescreen\\Luigi.pal"
	@@Sprite:
	.db $64,$16,$62,$06
	.db $64,$1E,$63,$06
	.db $6C,$16,$72,$06
	.db $6C,$1E,$73,$06
	.db $65,$19,$68,$00
	.db $6E,$19,$7A,$00
	.db $61,$1D,$69,$00
	@@Sprite2:
	.db $64,$16,$66,$06
	.db $64,$1E,$67,$06
	.db $6C,$16,$76,$06
	.db $6C,$1E,$77,$06
	.db $67,$19,$68,$00
	.db $6D,$19,$4D,$00
	.db $00,$00,$00,$00
  
  @LuigiOGData:
	@@Palette:
	.db         $7C,$32,$80,$02,$2A,$01
	.db $BF,$62,$A2,$26,$45,$49,$35,$09

	@@Sprite:
	.db $64,$16,$4E,$06
	.db $64,$1E,$4F,$06
	.db $6C,$16,$5E,$06
	.db $6C,$1E,$5F,$06
	.db $5C,$1B,$3F,$06
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00
	@@Sprite2:
	.db $64,$16,$40,$0E
	.db $64,$1E,$41,$0E
	.db $6C,$16,$42,$0E
	.db $6C,$1E,$43,$0E
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00





	MarioSpriteData:
		.db $18,$78,$A8,$03	; Cloud1
		.db $18,$80,$A9,$03	; Cloud2
		.db $18,$88,$AA,$03	; Cloud3

		.db $17,$18,$42,$00	; Mario 1
		.db $17,$20,$43,$00	; Mario 2
		.db $17,$28,$44,$00	; Mario 3
		.db $1F,$18,$52,$00	; Mario 4
		.db $1F,$20,$53,$00	; Mario 5
		.db $1F,$28,$54,$00	; Mario 6
		.db $18,$1B,$30,$07	; Mario 7
		.db $18,$23,$4D,$07	; Mario 8
		.db $20,$24,$41,$07	; Mario 9
		.db $20,$1C,$40,$07	; Mario 10
		.db $0F,$28,$34,$00	; Mario 11
		.db $27,$18,$33,$00	; Mario 12
		.db $00,$00,$00,$00	; 
		.db $00,$00,$00,$00	; 
		.db $00,$00,$00,$00	; 

	LuigiSpriteData:
		.db $18,$20,$A8,$03	; Cloud1
		.db $18,$28,$A9,$03	; Cloud2
		.db $18,$30,$AA,$03	; Cloud3

		.db $12,$78,$37,$00	; Luigi 1
		.db $12,$80,$38,$00	; Luigi 2
		.db $12,$88,$39,$00	; Luigi 3
		.db $1A,$78,$47,$00	; Luigi 4
		.db $18,$80,$48,$00	; Luigi 5
		.db $1A,$88,$49,$00	; Luigi 6
		.db $22,$78,$57,$00	; Luigi 7
		.db $20,$80,$58,$00	; Luigi 8
		.db $22,$88,$59,$00	; Luigi 9

		.db $14,$7E,$35,$07	; Luigi 10
		.db $14,$85,$36,$07	; Luigi 11
		.db $22,$80,$45,$01	; Luigi 12
		.db $1A,$85,$46,$07	; Luigi 13
		.db $20,$7D,$5B,$07	; Luigi 14
		.db $20,$85,$5C,$07	; Luigi 15

	/* 	; DSTRUCT can't be used as the code is used twice.
		; It used to look like this and it was less hardcoded. Oh well.

	.DSTRUCT MarioSpriteData INSTANCEOF PortraitBlocks VALUES
		Block.1:	.db $18,$78,$A8,$03	; Cloud1
		Block.2:	.db $18,$80,$A9,$03	; Cloud2
		Block.3:	.db $18,$88,$AA,$03	; Cloud3

		Block.4:	.db $17,$18,$42,$00	; Mario 1
		Block.5:	.db $17,$20,$43,$00	; Mario 2
		Block.6:	.db $17,$28,$44,$00	; Mario 3
		Block.7:	.db $1F,$18,$52,$00	; Mario 4
		Block.8:	.db $1F,$20,$53,$00	; Mario 5
		Block.9:	.db $1F,$28,$54,$00	; Mario 6
		Block.10:	.db $18,$1B,$30,$07	; Mario 7
		Block.11:	.db $18,$23,$31,$07	; Mario 8
		Block.12:	.db $20,$24,$41,$07	; Mario 9
		Block.13:	.db $20,$1C,$40,$07	; Mario 10
		Block.14:	.db $0F,$28,$34,$00	; Mario 11
	.ENDST

	.DSTRUCT LuigiSpriteData INSTANCEOF PortraitBlocks VALUES
		Block.1:	.db $18,$20,$A8,$03	; Cloud1
		Block.2:	.db $18,$28,$A9,$03	; Cloud2
		Block.3:	.db $18,$30,$AA,$03	; Cloud3

		Block.4:	.db $12,$78,$37,$00	; Luigi 1
		Block.5:	.db $12,$80,$38,$00	; Luigi 2
		Block.6:	.db $12,$88,$39,$00	; Luigi 3
		Block.7:	.db $1A,$78,$47,$00	; Luigi 4
		Block.8:	.db $1A,$80,$48,$00	; Luigi 5
		Block.9:	.db $1A,$88,$49,$00	; Luigi 6
		Block.10:	.db $22,$78,$57,$00	; Luigi 7
		Block.11:	.db $22,$80,$58,$00	; Luigi 8
		Block.12:	.db $22,$88,$59,$00	; Luigi 9

		Block.13:	.db $12,$7D,$35,$07	; Luigi 10
		Block.14:	.db $12,$85,$36,$07	; Luigi 11
		Block.15:	.db $22,$80,$45,$01	; Luigi 12
		Block.16:	.db $1A,$85,$46,$07	; Luigi 13
		Block.17:	.db $20,$7D,$5B,$07	; Luigi 14
		Block.18:	.db $20,$85,$5C,$07	; Luigi 15
	.ENDST
	*/


 pickSpriteBasedOnDifficulty:
	ld a,(ModeFlag)
	cp $00
	ret z
	ld de,$001C		; @MarioData@Sprite2-@MarioData@Sprite
	add hl,de
	ret
	