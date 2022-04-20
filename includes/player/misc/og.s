 Misc:
	@BlockPiece:	.db $FD,$FD,$62,$05, END
	@BlockPieceR:	.db $FD,$FD,$62,$25, END

 Daisy:
	@Standing:		.db $FA,$FF,$4E,$22, $FA,$F7,$49,$22
					.db $02,$FF,$50,$22, $02,$F7,$51,$22
					.db $F0,$00,$4F,$08, END

	@Moving:		.db $FA,$01,$48,$22, $FA,$F9,$49,$22
					.db $02,$01,$4A,$22, $02,$F9,$4B,$22
					.db $F0,$00,$4F,$08, END

	@Moving1R:		.db $FA,$01,$0D,$02
					.db $FA,$F9,$0C,$02
					.db $02,$01,$1D,$02
					.db $02,$F9,$1C,$02
					.db $F0,$00,$4F,$08, END

	@Moving2R:		.db $FA,$01,$2F,$02
					.db $FA,$F9,$2E,$02
					.db $02,$01,$3F,$02
					.db $02,$F9,$3E,$02
					.db $F0,$00,$4F,$08, END

	@Fly1:			.db $03,$00,$B0,$04
					.db $03,$08,$B1,$04
					.db $FB,$00,$A0,$04
					.db $FB,$08,$A1,$04, END
	@Fly2:			.db $03,$00,$B2,$04
					.db $03,$08,$B3,$04
					.db $FB,$00,$A2,$04
					.db $FB,$08,$A3,$04, END
	
	@Fake1:			.db $03,$00,$B0,$04
					.db $03,$08,$B1,$04
					.db $FB,$00,$A0,$04
					.db $FB,$08,$A1,$04
					.db $FB,$04,$4B,$0F, END
	@Fake2:			.db $03,$00,$B2,$04
					.db $03,$08,$B3,$04
					.db $FB,$00,$A2,$04
					.db $FB,$08,$A3,$04
					.db $FC,$04,$4B,$0F, END
	
Ending:
	@Ship:
					.db $00,$08,$3C,$06
					.db $00,$10,$3D,$06
					.db $00,$18,$4D,$06
					.db $F8,$08,$4F,$06
					.db $F8,$10,$2D,$06
					.db $F8,$18,$4C,$06
					.db $F0,$00,$FE,$05, END

	@Ship1:			.db $F8,$00,$26,$01
					.db $00,$00,$27,$01
					.db $FD,$FF,$46,$0C
					.db $00,$08,$3C,$06
					.db $00,$10,$3D,$06
					.db $00,$18,$4D,$06
					.db $F8,$08,$4F,$06
					.db $F8,$10,$2D,$06
					.db $F8,$18,$4C,$06
					.db $F0,$00,$FE,$05, END

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
