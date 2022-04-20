	ld a,($C203)
	cp $10
	jr nz,@@NotStanding
	ld a,$40	; PLAYER_SHOOT
	ld ($C203),a
	ld a,$10
	ld (ShooterCounter),a
	@@NotStanding:
	ld hl,$DFE0
	ret