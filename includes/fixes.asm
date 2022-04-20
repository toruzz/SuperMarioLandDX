SETREV1 23
.BANK 0 SLOT 0
.ORG $072A+REVOFFSET
.SECTION "PauseTilesHook" SIZE 24 OVERWRITE
	FARCALL PauseTiles
.ENDS

.BANK BANK_ROUTINES SLOT 1
.SECTION "PauseTiles" FREE
	PauseTiles:
	ld hl,BGMAP2
	ld b,$09
	xor a
	@Loop1stRow:
	ldi (hl),a
	;inc de
	inc a
	dec b
	jr nz,@Loop1stRow

	ld hl,BGMAP2+32
	ld b,$09
	ld a,$0A
	@Loop2ndRow:
	ldi (hl),a
	;inc de
	inc a
	dec b
	jr nz,@Loop2ndRow

	SETVRAM 1
	ld hl,BGMAP2
	ld b,$34
	ld a,$88
	@Loop3:
	ldi (hl),a
	;inc de
	dec b
	jr nz,@Loop3
	SETVRAM 0

	xor a
	ldh (<GameStatus),a
	ld (SuperstarTimer),a
	ld a,$C3
	ldh (<LCDC),a
	ret
.ENDS

SETREV1 9
.BANK 0 SLOT 0
.ORG $1CE7+REVOFFSET
.SECTION "Time up Hook" OVERWRITE SIZE 22
	FARCALL TimeUp
.ENDS
.BANK $03 SLOT 1
.SECTION "Time up" FREE
 TimeUp:
	ld hl,BGMAP2
	ld de,@Tiles
	ld c,$09		; Tiles' size

   @Loop:
	ld a,(de)
	ld b,a

   @WaitBlank:
	ldh a,(<STAT)
	and $03
	jr nz,@WaitBlank

	ld (hl),b
	inc l
	inc de
	dec c
	jr nz,@Loop

	ld a,$10
	ld ($9C21),a
	ld ($9C27),a
	ret
 
 	@Tiles: .db $0F,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$0F
.ENDS

SETREV1 9
.BANK 0 SLOT 0
.ORG $1AE6+REVOFFSET
.SECTION "Alternative coin lateral behaviour Hook" OVERWRITE
	jp AltCoinLateralBehaviour
	nop
	AltCoinLateralBehaviourEnded:
.ENDS
.SECTION "Alternative coin lateral behaviour" FREE
	AltCoinLateralBehaviour:
	cp $F4							; Coin
	jp z,$1B05+REVOFFSET			; Coin Behaviour routine
	cp $F5							; Alternative coin candidate
	jp z,$1B05+REVOFFSET			; Coin Behaviour routine
	jp AltCoinLateralBehaviourEnded
.ENDS

SETREV1 9
.ORG $19C1+REVOFFSET
.SECTION "Alternative coin bottom behaviour Hook" OVERWRITE
	jp AltCoinBottomBehaviour
	AltCoinBottomBehaviourEnded:
.ENDS
.SECTION "Alternative coin bottom behaviour" FREE
	AltCoinBottomBehaviour:
	jp z,$1A4E+REVOFFSET			; Coin Behaviour routine
	cp $F5							; Alternative coin candidate
	jp z,$1A4E+REVOFFSET			; Coin Behaviour routine
	jp AltCoinBottomBehaviourEnded
.ENDS

SETREV1 9
.ORG $183A+REVOFFSET
.SECTION "Alternative coin top behaviour Hook" OVERWRITE
	jp AltCoinTopBehaviour
	nop
	AltCoinTopBehaviourEnded:
.ENDS
.SECTION "Alternative coin top behaviour" FREE
	AltCoinTopBehaviour:
	and $FE
	cp $F4
	;jp nz,$1854				; Coin Behaviour routine
	;cp $F5						; Alternative coin candidate
	jp nz,$1854+REVOFFSET		; Coin Behaviour routine
	jp AltCoinTopBehaviourEnded
.ENDS

SETREV1 9
.ORG $1FD1+REVOFFSET
.SECTION "Alternative coin super ball behaviour Hook" OVERWRITE
	jp AltCoinBallBehaviour
	AltCoinBallBehaviourEnded:
.ENDS
.SECTION "Alternative coin super ball behaviour" FREE
	AltCoinBallBehaviour:
	call $0153
	cp $F5
	jp z,AltCoinBallBehaviourEnded+4	; If $F5 (alt behaviour), it skips the next check
	jp AltCoinBallBehaviourEnded
.ENDS

SETREV1 9
.ORG $1815+REVOFFSET
.SECTION "Alternative spike top behaviour Hook" OVERWRITE
	jp AltSpikeTopBehaviour
	PADDING 2
	SpikeBehaviour:
.ENDS
.SECTION "Alternative spike top behaviour" FREE
	AltSpikeTopBehaviour:
	cp $F9
	push af
	jp z,SpikeBehaviour
	cp $FA
	jp z,SpikeBehaviour
	cp $FB
	jp z,SpikeBehaviour
	cp $ED
	.IF REV == 0
		jp nz,$1839
	.ELSE
		jp nz,$1842
	.ENDIF
	jp SpikeBehaviour
.ENDS


; Expanding behaviour table for tiles in World 2:
SETREV1 9
.ORG $1A8E+REVOFFSET
.SECTION "Pointer for W3 equals W4" OVERWRITE
	.IF REV == 0
		.db $A0,$1A
	.ELSE
		.db $A9,$1A
	.ENDIF
.ENDS
.ORG $1A9D+REVOFFSET
.SECTION "New bytes in tile behaviour table" OVERWRITE
	.db $65,$66
.ENDS


SETREV1 9
.BANK 0 SLOT 0
.ORG $1001+REVOFFSET
.SECTION "Fake Daisy Smoke Hook" OVERWRITE
	ld hl,FakeDaisySmokeData0 ;$102C
	jr nz,@Skip
	ld hl,FakeDaisySmokeData1 ;$103C
	ld a,$03
	ld ($DFF8),a
	@Skip:
	call FakeDaisySmoke

	ld a,$08			;
	ldh ($A6),a			;
	ret					;

	ld hl,$C210			;
	ld (hl),$00			;
	ld hl,$FFB3			;
	inc (hl)			;
	ret					;

	FakeDaisySmoke:
	ld de,$C024			; $C01C
	ld b,$1C			; $10

	@Loop:
	ldi a,(hl)			;
	ld (de),a			;
	inc e				;
	dec b				;
	jr nz,@Loop			;
	ret					;
	FakeDaisySmokeData0:	; Small
	.db $7B,$5A,$33,$0B
	.db $7B,$62,$34,$0B
	.db $83,$5E,$3D,$0B
	.db $00,$00,$7F,$08

	.db $00,$00,$7F,$08
	.db $00,$00,$7F,$08
	.db $00,$00,$7F,$08
	.db $00,$00,$7F,$08
.ENDS

.BANK $03 SLOT 1
.SECTION "Fake Daisy Smoke Data 1" FREE
	FakeDaisySmokeData1:
	.db $78,$58,$39,$0B
	.db $78,$60,$3A,$0B
	.db $80,$58,$3B,$0B
	.db $80,$60,$3C,$0B

	.db $00,$00,$7F,$08
	.db $00,$00,$7F,$08
	.db $00,$00,$7F,$08
	.db $00,$00,$7F,$08
.ENDS



; Ending fixes:
SETREV1 9
.BANK 0 SLOT 0
.ORG $11A7+REVOFFSET
.SECTION "Heart offset fix Hook" OVERWRITE
	call HeartOffset
.ENDS
.ORG $11CC+REVOFFSET
.SECTION "Heart offset fix 2" OVERWRITE
	ld hl,OAM_Misc.5
.ENDS

.ORG $1363+REVOFFSET
.SECTION "Top bg color Hook" OVERWRITE
	call FixTopBG
.ENDS
.BANK $03 SLOT 1
.SECTION "Top bg color" FREE
	; Sets the BG tiles and attributes so the sky remains blue
  FixTopBG:
	ld (hl),$2C
	push hl
	SETVRAM 1
	pop hl
	push hl
	ld (hl),$02
	SETVRAM 0
	pop hl
	ld a,l
	ret
.ENDS
.SECTION "Heart offset & BG column fix" FREE
 HeartOffset:
	ld a,$5C
	ldh (<CurDrawTile),a
	ld hl,OAM_Misc.5
	ret
.ENDS

.BANK 0 SLOT 0
.ORG $1418+REVOFFSET
.SECTION "Credits BG Color fix 2" OVERWRITE
	ld b,$27
.ENDS

.ORG $15E2+REVOFFSET
.SECTION "Credits TEXT 1" OVERWRITE
	.db $27
.ENDS

.ORG $15E9+REVOFFSET
.SECTION "Credits TEXT 2" OVERWRITE
	.db $27
.ENDS


.BANK $03 SLOT 1
.ORGA $4B79
.SECTION "Flower removal when falling into a pit hook" OVERWRITE
	call PitFlowerRemoval
.ENDS
.SECTION "Flower removal when falling into a pit" FREE
 PitFlowerRemoval:
	ld a,$03
	ldh (<DXEventsTrigger),a
	xor a
	ldh (<CurrPower),a
	ret
.ENDS


SETREV1 9
.BANK 0 SLOT 0
.ORG $11B3+REVOFFSET
.SECTION "Daisy's heart palette" OVERWRITE
	ld (hl),$01
.ENDS

.BANK 0 SLOT 0
.ORG $14BB+REVOFFSET
.SECTION "The end text" OVERWRITE
	.db $4E,$CC,$52,$06
	.db $4E,$D4,$53,$06
	.db $4E,$DC,$54,$06
	.db $4E,$EC,$54,$06
	.db $4E,$F4,$55,$06
	.db $4E,$FC,$56,$06
.ENDS

SETREV1 9
.BANK 0 SLOT 0
.ORG $1B1F+REVOFFSET
.SECTION "Entering pipe Hook" OVERWRITE
	call EnterPipe
	nop
.ENDS
.SECTION "Entering pipe" FREE
 EnterPipe:
	ld a,$0B
	ldh ($B3),a
	ld a,$06
	ldh (<DXEventsTrigger),a
	ret
.ENDS

SETREV1 9
.BANK 0 SLOT 0
.ORG $1E9B+REVOFFSET
.SECTION "Fix OAMMisc horizontal movement during the ending Hook" OVERWRITE
	call OAMEndingFix
.ENDS
.SECTION "Fix OAMMisc horizontal movement during the ending" FREE
 OAMEndingFix:
	ld a,(GameStatus)
	cp $2A
	jr nc,@IsEnding
	ld hl,$C031
	ret
	@IsEnding:
	pop af
	ret
.ENDS

.ORG $01D1
.SECTION "Remove artifacts after Game Over hook" OVERWRITE
	call GameOverArtifacts
.ENDS
.SECTION "Remove artifacts after Game Over" FREE
 GameOverArtifacts:
	ld a,$2C
	ld b,$00
	ret
.ENDS
.ORG $01DE
.SECTION "Remove artifacts after Game Over 2" OVERWRITE
	xor a
	nop
.ENDS

.ORG $14AE+REVOFFSET
.SECTION "Saves the no. of times the game has been finished Hook" OVERWRITE
	ld a,(ModeFlag)
	cp $00
	call SaveCompleted
.ENDS
.SECTION "Saves the no. of times the game has been finished" FREE
 SaveCompleted:
	jr z,@NormalMode
	ld a,$02
	ld (SaveTimesCompleted),a
	ldh (<HardMode),a
	@NormalMode:
	ld a,$01
	ld (ModeFlag),a
	ret
.ENDS

; Intercepts the routine to write the pointer graphic (Mario/Mushroom)
; to write the appropriate palette
.ORG $036E
.SECTION "Pointer palette Hook" OVERWRITE
	call PointerPalette
.ENDS
.SECTION "Pointer palette" FREE
 PointerPalette:
	ld a,h
	cp $4E
	jr z,@MarioPointer
	ld a,$01
	jr @MushroomPointer
	@MarioPointer:
	ld a,$04
	@MushroomPointer:
	ld (OAM_Table.2.attrs),a

	call CopyData
	ret
.ENDS

