 Misc:
	@BlockPiece:	.db $FD,$FD,$62,$05, END
	@BlockPieceR:	.db $FD,$FD,$62,$25, END

 Daisy:
	@Standing:		.db $FA,$F9,$0E,$0D, $FA,$01,$0F,$0D
					.db $02,$F9,$1E,$0D, $02,$01,$1F,$0D
					.db $F2,$FD,$20,$0D, $FC,$FC,$21,$0F
					.db $02,$FC,$22,$0F, END

	@Moving:		.db $FA,$F9,$0E,$0D, $FA,$01,$0F,$0D
					.db $02,$F9,$1C,$0D, $02,$01,$1D,$0D
					.db $F2,$FD,$20,$0D, $FC,$FC,$21,$0F
					.db $02,$FC,$22,$0F, END

	@Moving1R:		.db $FA,$F9,$0F,$2D
					.db $FA,$01,$0E,$2D
					.db $02,$F9,$1D,$2D
					.db $02,$01,$1C,$2D

					.db $F2,$FD,$20,$2D
					.db $FC,$FE,$21,$2F
					.db $02,$FF,$22,$2F, END

	@Moving2R:		.db $FA,$F9,$0F,$2D
					.db $FA,$01,$0E,$2D
					.db $02,$F9,$1B,$2D
					.db $02,$01,$1A,$2D

					.db $F2,$FD,$20,$2D
					.db $FC,$FE,$21,$2F
					.db $02,$FF,$22,$2F, END

	@Moving1RL:		.db $FA,$F9,$0F,$2D
					.db $FA,$01,$0E,$2D
					.db $02,$F9,$1D,$2D
					.db $02,$01,$1C,$2D

					.db $F2,$FE,$20,$2D
					.db $FC,$FF,$21,$2F
					.db $02,$FF,$22,$2F, END

	@Moving2RL:		.db $FA,$F9,$0F,$2D
					.db $FA,$01,$0E,$2D
					.db $02,$F9,$1B,$2D
					.db $02,$01,$1A,$2D

					.db $F2,$FE,$20,$2D
					.db $FC,$FF,$21,$2F
					.db $02,$FF,$22,$2F, END

	@Fly1:			.db $03,$00,$B0,$04
					.db $03,$08,$B1,$04
					.db $FB,$00,$A0,$04
					.db $FB,$08,$A1,$04
					.db $02,$04,$2D,$0E,END
	@Fly2:			.db $03,$00,$B2,$04
					.db $03,$08,$B3,$04
					.db $FB,$00,$A2,$04
					.db $FB,$08,$A3,$04
					.db $02,$04,$2D,$0E,END

	@Fake1:			.db $02,$00,$B0,$04
					.db $02,$08,$B1,$04
					.db $FA,$00,$A0,$04
					.db $FA,$08,$A1,$04
					.db $02,$04,$4C,$0F
					.db $FA,$04,$4B,$0F
					.db $00,$00,$4F,$0F,END
	@Fake2:			.db $02,$00,$B2,$04
					.db $02,$08,$B3,$04
					.db $FA,$00,$A2,$04
					.db $FA,$08,$A3,$04
					.db $02,$04,$4C,$0F
					.db $FA,$04,$4B,$0F
					.db $00,$00,$4F,$0F,END

 Ending:
	@Ship:
					.db $00,$08,$3C,$06
					.db $00,$10,$3D,$06
					.db $00,$18,$4D,$06
					
					.db $F0,$00,$FE,$05,

					.db $F8,$18,$4C,$06
					.db $F8,$08,$4F,$06
					.db $F8,$10,$2D,$06
					.db $F0,$00,$FE,$05, END

	@Ship1:			.db $F8,$00,$26,$01
					.db $00,$00,$27,$01
					.db $FD,$FF,$46,$0C
					.db $00,$08,$3C,$06
					.db $00,$10,$3D,$06
					.db $00,$18,$4D,$06
					.db $F8,$08,$4F,$06
					.db $F8,$10,$2D,$06
					.db $F8,$18,$4C,$06, END

	@Ship2:			.db $F8,$00,$0E,$01
					.db $00,$00,$1E,$01
					.db $00,$08,$3C,$06
					.db $00,$10,$3D,$06
					.db $00,$18,$4D,$06
					.db $F8,$08,$4F,$06
					.db $F8,$10,$2D,$06
					.db $F8,$18,$4C,$06
					.db $F0,$00,$FE,$05, END

	@Cloud:			.db $00,$08,$7D,$03
					.db $00,$10,$7E,$03
					.db $00,$18,$7F,$03
					.db $F8,$08,$61,$03
					.db $F8,$10,$6F,$03
					.db $F8,$18,$7B,$03
					.db $00,$00,$7C,$03, END

	@BigCloud:		.db $00,$F8,$61,$23
					.db $00,$F0,$6F,$23	
					.db $00,$E8,$61,$23
					.db $00,$E0,$6F,$23
					.db $00,$D8,$7B,$23
					.db $08,$00,$7C,$23
					.db $08,$F8,$7D,$23
					.db $08,$F0,$7E,$23
					.db $08,$E8,$7D,$23
					.db $08,$E0,$7E,$23
					.db $08,$D8,$7F,$23, END
