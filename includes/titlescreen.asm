
.BANK 0 SLOT 0
.ORG $0371
.SECTION "TitleScreen Hook" OVERWRITE;SIZE $4E OVERWRITE
	.IF REV == 0
		call $05B8		; Replaced code
	.ELSE
		call $05CF		; Replaced code
	.ENDIF
	xor a			; $038c: $af
	ldh ($e5),a	; $038d: $e0 $e5
	ldh a,($e4)	; $038f: $f0 $e4
	push af			; $0391: $f5
	ld a,$0c		; $0392: $3e $0c
	ldh ($e4),a	; $0394: $e0 $e4
	.IF REV == 0
		call $07F0		; Replaced code
	.ELSE
		call $0807		; Replaced code
	.ENDIF
	pop af			; $0399: $f1
	ldh ($e4),a	; $039a: $e0 $e4
	FARCALL TitleScreen
	jp $03BF			; This is where code continues for both revisions. Not sure how to not hardcode it
.ENDS

.UNBACKGROUND $039C $03BD	; This is hardcoded. $0371+bytes from section

.BANK BANK_INIT SLOT 1
.SECTION "TitleScreen" FREE
	TitleScreen:
	WRITEDATA Titlescreen8000 VRAMTABLE0+_sizeof_InvertedAlphabet
	WRITEDATA InvertedAlphabet VRAMTABLE2
	WRITEDATA InvertedAlphabet VRAMTABLE0

	ld a,$3c		; $039c: $3e $3c
	ld hl,BGMAP		; $039e: $21 $00 $98
	.IF REV == 0
		call $0558		; Replaced code
	.ELSE
		call $056F		; Replaced code
	.ENDIF
	ld hl,$9804		; $03a4: $21 $04 $98
	ld (hl),$94		; $03a7: $36 $94
	ld hl,$9822		; $03a9: $21 $22 $98
	ld (hl),$95		; $03ac: $36 $95
	inc l			; $03ae: $2c
	ld (hl),$96		; $03af: $36 $96
	inc l			; $03b1: $2c
	ld (hl),$8c		; $03b2: $36 $8c
	ld hl,$982f		; $03b4: $21 $2f $98
	ld (hl),$3f		; $03b7: $36 $3f
	inc l			; $03b9: $2c
	ld (hl),$4c		; $03ba: $36 $4c
	inc l			; $03bc: $2c
	ld (hl),$4d		; $03bd: $36 $4d


	@GFX:
	ld a,(PlayerFlag)
	cp $01
	jr z,@Luigi
	WRITEPALS TitleScreenMarioPAL
	BUFFERPAL TitleScreenMarioPAL
	jr @PALset

	@Luigi:
	WRITEPALS TitleScreenLuigiPAL
	BUFFERPAL TitleScreenLuigiPAL
	@PALset:
	WRITEDATA TitleScreenTiles BGMAP

	SETVRAM 1
	WRITEDATA TitleScreenAttrs BGMAP
	SETVRAM 0

	; Size manually set to avoid overflow and erasing top score
	WRITEDATA IntroSpriteData $007B OAM_Player2
	ret

	.STRUCT IntroBlocks
		Block: instanceof OAM_Block 32
	.ENDST

	.DSTRUCT IntroSpriteData INSTANCEOF IntroBlocks VALUES
		Block.1:	.db $2C,$35,$B0,$02	; SignText1
		Block.2:	.db $2C,$3D,$B1,$02	; SignText2
		Block.3:	.db $2C,$45,$B2,$02	; SignText3
		Block.4:	.db $2C,$4D,$B3,$02	; SignText4
		Block.5:	.db $2C,$55,$B4,$02	; SignText5
		Block.6:	.db $2C,$5D,$B5,$02	; SignText6
		Block.7:	.db $2C,$65,$B6,$02	; SignText7
		Block.8:	.db $2C,$6D,$B7,$02	; SignText8
		Block.9:	.db $56,$7F,$B8,$05	; DX1
		Block.10:	.db $56,$87,$B9,$05	; DX2
		;Block.11:	.db $10,$28,$9A,$00	; Mario1
		;Block.12:	.db $18,$20,$9B,$00	; Mario2
		;Block.13:	.db $1F,$22,$9C,$00	; Mario3
		;Block.14:	.db $18,$28,$9D,$00	; Mario4
		;Block.15:	.db $24,$1A,$9E,$00	; Mario5
		Block.16:	.db $18,$78,$A8,$03	; Cloud1
		Block.17:	.db $18,$80,$A9,$03	; Cloud2
		Block.18:	.db $18,$88,$AA,$03	; Cloud3

		Block.19:	.db $17,$18,$42,$00	; Mario 1
		Block.20:	.db $17,$20,$43,$00	; Mario 2
		Block.21:	.db $17,$28,$44,$00	; Mario 3
		Block.22:	.db $1F,$18,$52,$00	; Mario 4
		Block.23:	.db $1F,$20,$53,$00	; Mario 5
		Block.24:	.db $1F,$28,$54,$00	; Mario 6

		Block.25:	.db $18,$1B,$30,$07	; Mario 7
		Block.26:	.db $18,$23,$31,$07	; Mario 8
		Block.27:	.db $20,$24,$41,$07	; Mario 9
		Block.28:	.db $20,$1C,$40,$07	; Mario 10
		;Block.29:	.db $0F,$28,$34,$00	; Mario 11
	.ENDST

	TitleScreenTiles:
	.INCBIN "data\\attributes\\titlescreen\\TitleScreen.tilemap"
	TitleScreenAttrs:
	.INCBIN "data\\attributes\\titlescreen\\TitleScreen.bin"
	InvertedAlphabet:
	.INCBIN "data\\graphics\\InvertedAlphabet.2bpp"

	TitleScreenMarioPAL:
	.INCBIN "data\\palettes\\TitleScreen.pal" READ PALSIZE*2-14
	.INCBIN "data\\palettes\\partials\\Titlescreen\\Mario.pal"
	TitleScreenLuigiPAL:
	.INCBIN "data\\palettes\\TitleScreen.pal" READ PALSIZE*2-14
	.INCBIN "data\\palettes\\partials\\Titlescreen\\Luigi.pal"

.ENDS

.BANK BANK_INIT SLOT 1
.SECTION "Congrats" FREE
	.ASC "Here's to another 30 years, my beloved friend. I hope you liked it. -toruzz"
.ENDS
