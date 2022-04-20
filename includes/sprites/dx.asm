; This routine used to handle sprites in a very rudimentary way.
; It's been rewritten for flexibility.

.BANK BANK_SPRITES SLOT 1
.ORGA $4000
.SECTION "SetSpriteDX" SEMIFREE
 SetSprite:
	xor a			; $25b7: $af
	ld (SprAttrMask),a	; $25b8: $ea $00 $d0

	ld hl,OAM_Enemies	; Start of the enemies on the OAM
	ld a,(SprIteration)	; $25be: $fa $13 $d0
	rlca			; $25c1: $07
	rlca			; $25c2: $07
	ld d,$00		; $25c3: $16 $00
	ld e,a			; $25c5: $5f
	add hl,de		; $25c6: $19
	ld b,h			; $25c7: $44
	ld c,l			; $25c8: $4d

	ld a,(CurSprTable)
	ld l,a
	ld a,(CurSprTable+1)
	ld h,a

	ldh a,($C5)		; Is sprite reversed?
	and $01
	jr z,@TableLoaded
	ld de,SprTableAlt-SprTable
	add hl,de

	@TableLoaded:
	ldh a,($C6)		; $25d5: $f0 $c6
	rlca			; $25d7: $07
	ld d,$00		; $25d8: $16 $00
	ld e,a			; $25da: $5f
	add hl,de		; $25db: $19
	ldi a,(hl)		; $25dc: $2a
	ld e,a			; $25dd: $5f
	ld a,(hl)		; $25de: $7e
	ld d,a			; $25df: $57
	ld h,d			; $25e0: $62
	ld l,e			; $25e1: $6b

	@Loop:
	ld a,(SprIteration)	
	cp $14			; No. of sprites that fit in OAM from $FE50
	ret nc

	ldi a,(hl)		; Relative PosY
	cp $80
	ret z

	push de

	ld d,a
	ldh a,($C2)		; Sprite PosY
	add d
	ld (bc),a		; Sets PosY
	inc bc

	ldi a,(hl)		; Relative PosX
	ld d,a
	ldh a,($C3)		; Sprite PosX
	add d
	ld (bc),a		; Sets PosX
	inc bc

	ldi a,(hl)
	ld (bc),a		; Sets Tile No.
	inc bc

	ldi a,(hl)
	ld (bc),a		; Sets Attributes (needs the relative one)
	inc bc

	pop de

	ld a,(SprIteration)	; $2636: $fa $13 $d0
	inc a			; $2639: $3c
	ld (SprIteration),a	; $263a: $ea $13 $d0
	jr @Loop		; $263d: $18 $a3

.ENDS

.ORGA $5000
.SECTION "Sprite Data DX" SEMIFREE
 Enemy:
	@Default:					.db $00,$00,$6E,$01,END
	@Goomba:					.db $00,$00,$90,$05,END
	@GoombaR:					.db $00,$00,$90,$25,END
	@GoombaF:					.db $00,$00,$90,$45,END
	@DeadGoomba:				.db $00,$00,$91,$05,END

	@Goomba1:					.db $00,$00,$90,$04,END
	@GoombaR1:					.db $00,$00,$90,$24,END
	@GoombaF1:					.db $00,$00,$90,$44,END
	@DeadGoomba1:				.db $00,$00,$91,$04,END

	; OBJ7 + OBJ5
	@Piranha1d:					.db $F8,$FF,$16,$0F
								.db $FD,$00,$17,$0F
								.db $00,$FF,$8B,$0E,END
	@Piranha2d:					.db $F8,$FF,$15,$0F
								.db $FD,$00,$17,$0F
								.db $00,$FF,$8B,$0E,END

	; OBJ7 + OBJ4
	@Piranha1c:					.db $F8,$FF,$16,$0F
								.db $FD,$00,$17,$0F
								.db $00,$FF,$18,$0C,END
	@Piranha2c:					.db $F8,$FF,$15,$0F
								.db $FD,$00,$17,$0F
								.db $00,$FF,$18,$0C,END

	; OBJ4 + OBJ7
	@Piranha1b:					.db $F8,$FF,$16,$0C
								.db $FD,$00,$17,$0C
								.db $00,$FF,$18,$0F,END
	@Piranha2b:					.db $F8,$FF,$15,$0C
								.db $FD,$00,$17,$0C
								.db $00,$FF,$18,$0F,END

	; OBJ2 + OBJ4
	@Piranha1a:					.db $F8,$FF,$16,$0A
								.db $FD,$00,$17,$0A
								.db $00,$FF,$18,$0C,END
	@Piranha2a:					.db $F8,$FF,$15,$0A
								.db $FD,$00,$17,$0A
								.db $00,$FF,$18,$0C,END

	; OBJ1 + OBJ4
	@Piranha1:					.db $F8,$FF,$16,$09
								.db $FD,$00,$17,$09
								.db $00,$FF,$18,$0C,END
	@Piranha2:					.db $F8,$FF,$15,$09
								.db $FD,$00,$17,$09
								.db $00,$FF,$18,$0C,END


	@Koopa1b:					.db $00,$00,$97,$04
								.db $FC,$FF,$96,$04,END
	@Koopa2b:					.db $00,$00,$99,$04
								.db $FC,$FF,$98,$04,END
	@Koopa1Rb:					.db $00,$00,$97,$24
								.db $FC,$01,$96,$24,END
	@Koopa2Rb:					.db $00,$00,$99,$24
								.db $FC,$01,$98,$24,END
	@Koopa1Fb:					.db $00,$00,$97,$44
								.db $04,$FF,$96,$44,END

	@Koopa1a:					.db $00,$00,$97,$05
								.db $FC,$FF,$96,$05,END
	@Koopa2a:					.db $00,$00,$99,$05
								.db $FC,$FF,$98,$05,END
	@Koopa1Ra:					.db $00,$00,$97,$25
								.db $FC,$01,$96,$25,END
	@Koopa2Ra:					.db $00,$00,$99,$25
								.db $FC,$01,$98,$25,END
	@Koopa1Fa:					.db $00,$00,$97,$45
								.db $04,$FF,$96,$45,END

	@Koopa1:					.db $00,$00,$97,$06
								.db $FC,$FF,$96,$06,END
	@Koopa2:					.db $00,$00,$99,$06
								.db $FC,$FF,$98,$06,END
	@Koopa1R:					.db $00,$00,$97,$26
								.db $FC,$01,$96,$26,END
	@Koopa2R:					.db $00,$00,$99,$26
								.db $FC,$01,$98,$26,END
	@Koopa1F:					.db $00,$00,$97,$46
								.db $04,$FF,$96,$46,END
	
	@KoopaShell1:				.db $00,$00,$9A,$06,END
	@KoopaShell1b:				.db $00,$00,$9A,$04,END
	@KoopaShell1c:				.db $00,$00,$9A,$05,END
	@KoopaShell2:				.db $00,$00,$9B,$03,END

	@Explosion1:				.db $00,$00,$9D,$01
								.db $00,$08,$9D,$21,END
	@Explosion2:				.db $00,$00,$9E,$01
								.db $00,$08,$9E,$21,END

	@Fly1R:				
	@Fly1:						.db $00,$00,$B0,$04
								.db $00,$08,$B1,$04
								.db $F8,$00,$A0,$04
								.db $F8,$08,$A1,$04
								.db $00,$04,$2D,$0E,END
	@Fly2R:				
	@Fly2:						.db $00,$00,$B2,$04
								.db $00,$08,$B3,$04
								.db $F8,$00,$A2,$04
								.db $F8,$08,$A3,$04
								.db $00,$04,$2D,$0E,END

	@FlyDead:					.db $00,$00,$A8,$04
								.db $00,$08,$A9,$04
								.db $00,$04,$2D,$0E,END
	@FlyDeadF:					.db $00,$00,$A8,$44
								.db $00,$08,$A9,$44
								.db $00,$04,$2D,$4E,END

	@Sphynx1:					.db $F8,$00,$A4,$07
								.db $F8,$08,$A5,$07
								.db $00,$00,$B4,$07
								.db $00,$08,$B5,$07

								.db $F6,$00,$10,$0B
								.db $F8,$05,$11,$0B
								.db $00,$FF,$12,$0B,END

	@Sphynx1R:					.db $F8,$00,$A5,$27
								.db $F8,$08,$A4,$27
								.db $00,$00,$B5,$27
								.db $00,$08,$B4,$27

								.db $F6,$08,$10,$2B
								.db $F8,$03,$11,$2B
								.db $00,$09,$12,$2B,END

	@Sphynx2:					.db $F8,$00,$A6,$07
								.db $F8,$08,$A7,$07
								.db $00,$00,$B6,$07
								.db $00,$08,$B7,$07
								
								.db $F6,$01,$10,$0B
								.db $F8,$06,$11,$0B
								.db $00,$01,$13,$0B,END

	@Sphynx2R:					.db $F8,$00,$A7,$27
								.db $F8,$08,$A6,$27
								.db $00,$00,$B7,$27
								.db $00,$08,$B6,$27
								
								.db $F6,$07,$10,$2B
								.db $F8,$02,$11,$2B
								.db $00,$07,$13,$2B,END

	@SphynxDead:				.db $00,$00,$B8,$07
								.db $00,$08,$B9,$07
								.db $00,$03,$14,$0B,END

	@SphynxDeadR:				.db $00,$00,$B9,$27
								.db $00,$08,$B8,$27
								.db $00,$05,$14,$2B,END

	@SphynxDeadF:				.db $00,$00,$B8,$47
								.db $00,$08,$B9,$47
								.db $00,$03,$14,$4B,END

	@FireBall:					.db $00,$00,$E2,$01,END
	@FireBall2:					.db $00,$00,$E3,$01,END

	@Bee1:						.db $01,$00,$D0,$04
								.db $00,$08,$D1,$07
								.db $F9,$00,$C0,$06
								.db $F8,$08,$C1,$04,END

	@Bee2:						.db $00,$00,$D2,$04
								.db $FF,$08,$D3,$07
								.db $F8,$00,$C2,$06
								.db $F7,$08,$C3,$04,END

	@BeeArrow:					.db $00,$00,$BC,$04
								.db $F8,$00,$AC,$04,END

	@BeeDead:					.db $00,$00,$C8,$06
								.db $00,$08,$C9,$07
								.db $00,$08,$32,$0C,END

	@BeeDeadF:					.db $00,$00,$C8,$46
								.db $00,$08,$C9,$47
								.db $00,$08,$32,$4C,END




	@Seahorse1:					.db $F8,$00,$A4,$06
								.db $F8,$08,$A5,$06
								.db $00,$00,$B4,$06
								.db $00,$08,$B5,$06,END

	@Seahorse2:					.db $F8,$00,$A6,$06
								.db $F8,$08,$A7,$06
								.db $00,$00,$B6,$06
								.db $00,$08,$B7,$06,END

	@Seahorse1R:				.db $F8,$00,$A5,$26
								.db $F8,$08,$A4,$26
								.db $00,$00,$B5,$26
								.db $00,$08,$B4,$26,END

	@Seahorse2R:				.db $F8,$00,$A7,$26
								.db $F8,$08,$A6,$26
								.db $00,$00,$B7,$26
								.db $00,$08,$B6,$26,END


	@Fishbone1:					.db $00,$00,$9C,$0F
								.db $F8,$00,$8C,$0F,END

	@Fishbone2:					.db $00,$00,$9D,$0F
								.db $F8,$00,$8D,$0F,END


	@Robot1:					.db $00,$00,$D4,$05
								.db $00,$08,$D5,$05
								.db $F8,$00,$C4,$05
								.db $F8,$08,$C5,$05
								.db $F8,$04,$C8,$07
								.db $00,$04,$C9,$07,END

	@Robot2:					.db $00,$00,$D6,$05
								.db $00,$08,$D7,$05
								.db $F8,$00,$C6,$05
								.db $F8,$08,$C7,$05
								.db $F7,$04,$C8,$07
								.db $00,$04,$C9,$07,END


	@RobotHead:					.db $00,$00,$C6,$05
								.db $00,$08,$C7,$05
								.db $FF,$04,$C8,$07,END

	@RobotBody:					.db $00,$00,$D6,$05
								.db $00,$08,$D7,$05
								.db $00,$04,$C9,$07,END

	@RobotDead:					.db $00,$00,$D8,$05
								.db $00,$08,$D9,$05
								.db $FF,$04,$C8,$07,END

	@RobotDeadF:				.db $00,$00,$D8,$45
								.db $00,$08,$D9,$45
								.db $02,$04,$C8,$47,END


	@Fish1:						.db $00,$00,$A8,$07
								.db $00,$08,$A9,$07,END

	@Fish2:						.db $00,$00,$B8,$07
								.db $00,$08,$B9,$07,END

	@Fish1R:					.db $00,$00,$A9,$27
								.db $00,$08,$A8,$27,END

	@Fish2R:					.db $00,$00,$B9,$27
								.db $00,$08,$B8,$27,END

	@Octopus1R:				
	@Octopus1:					.db $01,$00,$B0,$04
								.db $01,$08,$B1,$04
								.db $F9,$00,$A0,$04
								.db $F9,$08,$A1,$04
								.db $F9,$04,$26,$08,END
	@Octopus2R:				
	@Octopus2:					.db $01,$00,$B2,$04
								.db $01,$08,$B3,$04
								.db $F9,$00,$A2,$04
								.db $F9,$08,$A3,$04
								.db $FA,$04,$26,$08,END


	@Totem1:					.db $00,$00,$BB,$05
								.db $FB,$F8,$AA,$07
								.db $F8,$00,$AB,$05
								.db $FB,$08,$AA,$27,END
	@Totem2:					.db $00,$00,$BB,$05
								.db $F8,$F8,$BA,$07
								.db $F8,$00,$AB,$05
								.db $F8,$08,$BA,$27,END
	@Totem3:					.db $00,$00,$BB,$05
								.db $FA,$F8,$AC,$07
								.db $F8,$00,$AB,$05
								.db $FA,$08,$AC,$27,END
	@TotemDead:					.db $00,$00,$AC,$07
								.db $00,$08,$AD,$05
								.db $00,$10,$AC,$27,END
	@TotemDeadF:				.db $00,$00,$AC,$47
								.db $00,$08,$AD,$45
								.db $00,$10,$AC,$67,END

	@BulletBill1:				.db $00,$00,$88,$07
								.db $F8,$00,$87,$07,END
	@BulletBill2:				.db $00,$00,$F9,$07
								.db $00,$08,$FB,$01,END
	@BulletBill3:				.db $00,$00,$F9,$07
								.db $00,$08,$FA,$01,END

	@BulletBill2R:				.db $00,$00,$FB,$21
								.db $00,$08,$F9,$27,END
	@BulletBill3R:				.db $00,$00,$FA,$21
								.db $00,$08,$F9,$27,END

	@BulletBill1a:				.db $00,$00,$88,$06
								.db $F8,$00,$87,$06,END
	@BulletBill2a:				.db $00,$00,$F9,$06
								.db $00,$08,$FB,$01,END
	@BulletBill3a:				.db $00,$00,$F9,$06
								.db $00,$08,$FA,$01,END

	@BulletBill2Ra:				.db $00,$00,$FB,$21
								.db $00,$08,$F9,$26,END
	@BulletBill3Ra:				.db $00,$00,$FA,$21
								.db $00,$08,$F9,$26,END
	
	
	@BulletBill1b:				.db $00,$00,$88,$07
								.db $F8,$00,$87,$07,END
	@BulletBill2b:				.db $00,$00,$F9,$07
								.db $00,$08,$FB,$01,END
	@BulletBill3b:				.db $00,$00,$F9,$07
								.db $00,$08,$FA,$01,END

	@BulletBill2Rb:				.db $00,$00,$FB,$21
								.db $00,$08,$F9,$27,END
	@BulletBill3Rb:				.db $00,$00,$FA,$21
								.db $00,$08,$F9,$27,END

	@Tokoto1:					.db $F8,$00,$A4,$05
								.db $F8,$08,$A5,$05
								.db $00,$00,$B4,$05
								.db $00,$08,$B5,$05,END

	@Tokoto2:					.db $F8,$00,$A6,$05
								.db $F8,$08,$A7,$05
								.db $00,$00,$B6,$05
								.db $00,$08,$B7,$05,END

	@Tokoto1R:					.db $F8,$00,$A5,$25
								.db $F8,$08,$A4,$25
								.db $00,$00,$B5,$25
								.db $00,$08,$B4,$25,END

	@Tokoto2R:					.db $F8,$00,$A7,$25
								.db $F8,$08,$A6,$25
								.db $00,$00,$B7,$25
								.db $00,$08,$B6,$25,END

	@TokotoDead:				.db $00,$00,$B8,$05
								.db $00,$08,$B9,$05$80

	@TokotoDeadR:				.db $00,$00,$B9,$25
								.db $00,$08,$B8,$25,END

	@TokotoDeadF:				.db $00,$00,$B8,$45
								.db $00,$08,$B9,$45,END

	@Boulder:					.db $00,$00,$D2,$05
								.db $00,$08,$D3,$05
								.db $F8,$00,$C2,$05
								.db $F8,$08,$C3,$05,END

	@BoulderR:					.db $00,$00,$D3,$25
								.db $00,$08,$D2,$25
								.db $F8,$00,$C3,$25
								.db $F8,$08,$C2,$25,END

	@BoulderF:					.db $00,$00,$C2,$45
								.db $00,$08,$C3,$45
								.db $F8,$00,$D2,$45
								.db $F8,$08,$D3,$45,END

	@BoulderFR:					.db $00,$00,$C3,$65
								.db $00,$08,$C2,$65
								.db $F8,$00,$D3,$65
								.db $F8,$08,$D2,$65,END
								
	@Boulder1:					.db $00,$00,$D2,$04
								.db $00,$08,$D3,$04
								.db $F8,$00,$C2,$04
								.db $F8,$08,$C3,$04,END

	@BoulderR1:					.db $00,$00,$D3,$24
								.db $00,$08,$D2,$24
								.db $F8,$00,$C3,$24
								.db $F8,$08,$C2,$24,END

	@BoulderF1:					.db $00,$00,$C2,$44
								.db $00,$08,$C3,$44
								.db $F8,$00,$D2,$44
								.db $F8,$08,$D3,$44,END

	@BoulderFR1:				.db $00,$00,$C3,$64
								.db $00,$08,$C2,$64
								.db $F8,$00,$D3,$64
								.db $F8,$08,$D2,$64,END
								
	@Stalactite:				.db $00,$00,$DF,$05,END

	@Spider1:					.db $01,$00,$B0,$07
								.db $01,$08,$B1,$07
								.db $F9,$00,$A0,$07
								.db $F9,$08,$A1,$07,END
	
	@Spider2:					.db $01,$00,$B2,$07
								.db $01,$08,$B3,$07
								.db $F9,$00,$A2,$07
								.db $F9,$08,$A3,$07,END

	@SpiderDead:				.db $00,$00,$A8,$07
								.db $00,$08,$A9,$07,END

	@SpiderDeadF:				.db $00,$00,$A8,$47
								.db $00,$08,$A9,$47,END

	@Chicken1:					.db $FA,$FF,$86,$0D
								.db $F8,$00,$C4,$04
								.db $F8,$08,$C5,$04
								.db $00,$00,$D4,$04
								.db $00,$08,$D5,$04,END

	@Chicken2:					.db $FB,$FF,$86,$0D
								.db $F8,$00,$C6,$04
								.db $F8,$08,$C7,$04
								.db $00,$00,$D6,$04
								.db $00,$08,$D7,$04,END

	@CeilSpider1:				.db $00,$00,$D4,$06
								.db $00,$08,$D5,$06
								.db $F8,$00,$C4,$06
								.db $F8,$08,$C5,$06,END

	@CeilSpider2:				.db $00,$00,$D6,$06
								.db $00,$08,$D7,$06
								.db $F8,$00,$C6,$06
								.db $F8,$08,$C7,$06,END

	@CeilSpiderDead:			.db $00,$00,$D8,$06
								.db $00,$08,$D9,$06,END

	@CeilSpiderDeadF:			.db $00,$00,$D8,$46
								.db $00,$08,$D9,$46,END


	@Zombie1:					.db $01,$00,$B0,$06
								.db $01,$08,$B1,$06
								.db $F9,$00,$A0,$06
								.db $F9,$08,$A1,$06
								
								.db $F9,$01,$10,$0B,END
	
	@Zombie2:					.db $01,$00,$B2,$06
								.db $01,$08,$B3,$06
								.db $F9,$00,$A2,$06
								.db $F9,$08,$A3,$06
								
								.db $F9,$03,$10,$0B,END

	@ZombieDead:				.db $00,$00,$A8,$06
								.db $00,$08,$A9,$06,END

	@ZombieDeadF:				.db $00,$00,$A8,$46
								.db $00,$08,$A9,$46,END

	@Zombie1R:					.db $01,$00,$B1,$26
								.db $01,$08,$B0,$26
								.db $F9,$00,$A1,$26
								.db $F9,$08,$A0,$26
								
								.db $F9,$07,$10,$2B,END
	
	@Zombie2R:					.db $01,$00,$B3,$26
								.db $01,$08,$B2,$26
								.db $F9,$00,$A3,$26
								.db $F9,$08,$A2,$26
								
								.db $F9,$05,$10,$2B,END

	@ZombieDeadR:				.db $00,$00,$A9,$26
								.db $00,$08,$A8,$26,END

	@ZombieDeadFR:				.db $00,$00,$A9,$66
								.db $00,$08,$A8,$66,END


	@Piranha1F:					.db $08,$00,$16,$6F
								.db $03,$FF,$17,$6F
								.db $00,$00,$18,$6C,END
	@Piranha2F:					.db $08,$00,$15,$6F
								.db $03,$FF,$17,$6F
								.db $00,$00,$18,$6C,END
	
	@Piranha1Fd:				.db $08,$00,$16,$6F
								.db $03,$FF,$17,$6F
								.db $00,$00,$18,$6E,END
	@Piranha2Fd:				.db $08,$00,$15,$6F
								.db $03,$FF,$17,$6F
								.db $00,$00,$18,$6E,END


	@FireFlower1:				.db $00,$00,$D0,$06
								.db $00,$08,$D0,$26
								.db $F8,$00,$C0,$05
								.db $F8,$08,$C0,$25
								
								.db $FB,$04,$8A,$0D,END

	@FireFlower2:				.db $02,$00,$D1,$06
								.db $02,$08,$D1,$26
								.db $FA,$00,$C1,$05
								.db $FA,$08,$C1,$25

								.db $FB,$04,$89,$0D,END

	@Snake1:					.db $F8,$00,$A4,$06
								.db $F8,$08,$A5,$06
								.db $00,$00,$B4,$06
								.db $00,$08,$B5,$06,END

	@Snake2:					.db $F8,$00,$A6,$06
								.db $F8,$08,$A7,$06
								.db $00,$00,$B6,$06
								.db $00,$08,$B7,$06,END

	@Snake1R:					.db $F8,$00,$A5,$26
								.db $F8,$08,$A4,$26
								.db $00,$00,$B5,$26
								.db $00,$08,$B4,$26,END
								

	@Snake2R:					.db $F8,$00,$A7,$26
								.db $F8,$08,$A6,$26
								.db $00,$00,$B7,$26
								.db $00,$08,$B6,$26,END
								

	@SnakeDead:					.db $00,$00,$B8,$06
								.db $00,$08,$B9,$06,END

	@SnakeDeadR:				.db $00,$00,$B9,$26
								.db $00,$08,$B8,$26,END

	@SnakeDeadF:				.db $00,$00,$B8,$46
								.db $00,$08,$B9,$46,END

	@Plane:						.db $FC,$00,$C2,$06
								.db $FC,$08,$C3,$06
								.db $F5,$03,$85,$0D
								.db $04,$04,$D2,$07
								.db $F5,$0B,$D3,$06,END

	@DeadlyStar1:				.db $00,$00,$D8,$05,END
	@DeadlyStar2:				.db $00,$00,$D9,$05,END


	@Fist:						.db $00,$00,$F2,$06
								.db $00,$08,$F3,$06
								.db $F8,$00,$F0,$06
								.db $F8,$08,$F1,$06,END





 Boss:
 	@Lion:						.db $00,$00,$DA,$06
								.db $00,$08,$DB,$06
								.db $00,$10,$DC,$06
								.db $F8,$00,$CA,$06
								.db $F8,$08,$CB,$06
								.db $F8,$10,$CC,$06
								.db $F8,$18,$BA,$06
								.db $F0,$00,$CD,$06
								.db $F0,$08,$CE,$06
								.db $F4,$00,$0D,$0C,END

	@Lion2:						.db $00,$00,$D6,$06
								.db $00,$08,$D7,$06
								.db $00,$10,$D8,$06
								.db $F8,$FF,$BD,$06
								.db $F8,$07,$BE,$06
								.db $FA,$0F,$C6,$06
								.db $FF,$17,$C7,$06
								.db $F8,$18,$AA,$06
								.db $F0,$00,$AD,$06
								.db $F0,$08,$AE,$06
								.db $F4,$FF,$0D,$0C,END

	@LionFire:					.db $00,$00,$C4,$05
								.db $00,$08,$C5,$05,END
	@LionFire2:					.db $00,$00,$D4,$05
								.db $00,$08,$D5,$05,END

	@Explosion1:				.db $00,$00,$9D,$41
								.db $00,$08,$9D,$61
								.db $F8,$00,$9D,$01
								.db $F8,$08,$9D,$21,END

	@Explosion2:				.db $00,$00,$37,$09
								.db $00,$08,$38,$09
								.db $F8,$00,$35,$09
								.db $F8,$08,$36,$09,END


	@Dragon:					.db $E9,$02,$AE,$07
								.db $E8,$08,$AF,$06
								.db $F0,$00,$BE,$06
								.db $F0,$08,$BF,$06
								.db $F8,$00,$CE,$06
								.db $F8,$08,$CF,$06
								.db $00,$00,$BC,$06
								.db $00,$08,$BD,$06
								.db $F7,$04,$49,$0F,END

	@Dragon2:					.db $E9,$02,$BA,$07
								.db $E8,$08,$BB,$06
								.db $F1,$00,$CA,$06
								.db $F0,$08,$CB,$06
								.db $F9,$02,$DA,$07
								.db $F8,$08,$DB,$06			
								.db $00,$00,$CC,$06
								.db $00,$08,$CD,$06
								.db $F1,$07,$46,$0F,END

	@DragonFire1:				.db $00,$00,$AA,$44
								.db $00,$08,$AA,$64
								.db $F8,$00,$AA,$04
								.db $F8,$08,$AA,$24,END
	@DragonFire2:				.db $00,$00,$AB,$44
								.db $00,$08,$AB,$64
								.db $F8,$00,$AB,$04
								.db $F8,$08,$AB,$24,END

	@Boulder1:					.db $00,$00,$CE,$06
								.db $00,$08,$CF,$06
								.db $F8,$00,$BE,$06
								.db $F8,$08,$BF,$06
								.db $F0,$00,$AE,$04
								.db $F0,$08,$AF,$06
								
								.db $FF,$08,$D0,$04,END

	@Boulder2:					.db $00,$00,$CA,$06
								.db $00,$08,$CB,$06
								.db $F8,$00,$CC,$06
								.db $F8,$08,$CD,$06
								.db $F0,$00,$BC,$06
								.db $F0,$08,$BD,$06

								.db $F0,$08,$C0,$04
								.db $F8,$06,$C1,$04,END

	@Kinton2:					.db $00,$00,$DA,$07
								.db $00,$08,$C8,$07
								.db $00,$10,$C9,$07
								.db $F8,$00,$CA,$07
								.db $F8,$08,$DB,$07
								.db $F8,$10,$DC,$07,END

	@Kinton1:					.db $00,$00,$8C,$07
								.db $00,$08,$8D,$07
								.db $00,$10,$9C,$07
								.db $F8,$00,$89,$07
								.db $F8,$08,$8A,$07
								.db $F8,$10,$8B,$07,END


	@Tatanga:					.db $00,$00,$CC,$05
								.db $00,$08,$CD,$05
								.db $00,$10,$CE,$05
								.db $00,$18,$CF,$05

								.db $F8,$00,$BC,$07
								.db $F8,$08,$BD,$07
								.db $F8,$10,$BE,$05
								.db $F8,$18,$BF,$05
								
								.db $F0,$01,$AC,$07
								.db $F0,$09,$AD,$07
								.db $F0,$10,$AE,$05
								.db $F0,$18,$AF,$05
								
								.db $E8,$10,$CB,$06,END


	@Ball:						.db $00,$00,$BA,$04
								.db $00,$08,$BB,$04
								.db $F8,$00,$AA,$01
								.db $F8,$08,$AB,$04,END

 Item:
	@Default:					.db $00,$00,$6E,$01,END
	@Mushroom:					.db $00,$00,$83,$02,END
	@Heart:						.db $00,$00,$83,$02,END
	@Flower:					.db $00,$00,$E5,$02
								.db $00,$00,$A0,$0B,END
	@FlowerAlt:					.db $00,$00,$E0,$02
								.db $00,$00,$A0,$0B,END
	@Star:						.db $00,$00,$86,$02,END

	@Platform:					.db $00,$00,$EF,$01
								.db $00,$08,$EF,$01
								.db $00,$10,$EF,$01,END

	@Spring:					.db $00,$00,$EE,$84,END
	@Spring1:					.db $00,$00,$EE,$85,END
	@Spring2:					.db $00,$00,$EE,$87,END
	@Spring1b:					.db $00,$00,$EE,$05,END

	@MidPlatform:				.db $00,$00,$EF,$01
								.db $00,$08,$EF,$01,END

	@EgyptPlatform:				.db $00,$00,$DD,$07
								.db $00,$08,$DE,$07,END

	@Elevator:					.db $00,$00,$E6,$87,END
	@Elevator1:					.db $00,$00,$E6,$84,END

	@Nothing:					.db $00,$00,$FE,$05,END

	@EgyptPlatformAlt:			.db $00,$00,$8E,$0B
								.db $00,$08,$8F,$0B,END

.ENDS

.ORGA $6000
.SECTION "Sprite Pointers DX" SEMIFREE

 SprTable:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03	; Goomba flipped
	POINTER Enemy@Piranha1a		; 04	; Piranha Plant closed mouth
	POINTER Enemy@Piranha2a		; 05	; Piranha Plant open mouth
	POINTER Enemy@Koopa1		; 06
	POINTER Enemy@Koopa2		; 07
	POINTER Enemy@KoopaShell1	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; 0A	; Part of the cloud?
	POINTER Enemy@Default		; 0B	; Cannon?
	POINTER Enemy@Default		; 0C	; Part of the cloud?
	POINTER Enemy@Default		; 0D	; ""
	POINTER Enemy@KoopaShell2 	; 0E	
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Item@Platform		; 11	; Apparently repeated?
	POINTER Item@Platform		; 12
	POINTER Item@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15	; Circular explosion 2
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18	; Light colored star
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C	; Coin 1. Unused?
	POINTER Enemy@Default		; 1D	; Coin 2 ""
	POINTER Enemy@Default		; 1E	; Coin 3 ""
	POINTER Item@Nothing		; 1F	; Nothing? It uses tile FE
	POINTER Enemy@Default		; 20	; Stalactite 
	POINTER Item@Spring			; 21	; Small platform (spring shaped)
	POINTER Item@MidPlatform	; 22	; Medium platform (two steps)
	POINTER Enemy@Default		; 23	; No idea. Alternate gfx needed?
	POINTER Enemy@Default		; 24	; No idea 2
	POINTER Enemy@Default		; 25	; No idea 3
	POINTER Enemy@Default		; 26	
	POINTER Enemy@Default		; 27
	POINTER Enemy@Fly1			; 28
	POINTER Enemy@Fly2			; 29
	POINTER Enemy@Sphynx1		; 2A
	POINTER Enemy@Sphynx2		; 2B
	POINTER Enemy@FlyDead		; 2C
	POINTER Enemy@FlyDeadF		; 2D
	POINTER Enemy@SphynxDead	; *2E	; SphynxDead, not sure if reversed or flipped
	POINTER Enemy@SphynxDeadF	; 2F
	POINTER Enemy@Bee1			; *30	; Bee	D0 D1 C0 C1
	POINTER Enemy@Bee2			; *31	; Bee 2	D2 D3 C2 C3
	POINTER Enemy@Default		; *32	; Two fires at the same time?
	POINTER Enemy@Default		; *33	; Half lion
	POINTER Enemy@BeeDead		; *34	; Dead Bee
	POINTER Enemy@BeeDeadF		; 35	; Dead Bee flipped
	POINTER Enemy@Default		; *36
	POINTER Enemy@Default		; 37	
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C	; Lion's tail?
	POINTER Enemy@Default		; 3D	; Lion's paw?
	POINTER Enemy@Default		; 3E	; Lion's back?
	POINTER Enemy@Default		; 3F	; Lion's back? flipped
	POINTER Enemy@Default		; 40	; Lion something
	POINTER Enemy@Default		; 41	; Lion something flipped
	POINTER Enemy@Default		; 42	; Half bee?
	POINTER Enemy@Default		; 43	; Other half bee
	POINTER Enemy@BeeArrow		; 44	; Arrow down
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@Default		; 46
	POINTER Enemy@Default		; 47	; Bee (not dead) flipped
	POINTER Boss@Lion			; 48	; Lion Boss
	POINTER Boss@Lion2			; 49	; Lion Boss 2
	POINTER Boss@LionFire		; 4A	; Fireball A (lion's?)
	POINTER Boss@LionFire2		; 4B	; Fireball B
	POINTER Enemy@Default		; 4C	
	POINTER Enemy@Default		; 4D
	POINTER Enemy@Default		; 4E
	POINTER Enemy@Default		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@Default		; 51	; 
	POINTER Enemy@Default		; 52	; 
	POINTER Enemy@Default		; 53	; 
	POINTER Enemy@Default		; 54	; 
	POINTER Enemy@Default		; 55	; 
	POINTER Enemy@Default		; 56	; 
	POINTER Enemy@Default		; 57	; 
	POINTER Enemy@Default		; 58	; 
	POINTER Enemy@Default		; 59	; 
	POINTER Enemy@Default		; 5A	; 
	POINTER Enemy@Default		; 5B	; 
	POINTER Enemy@Default		; 5C	; 
	POINTER Enemy@Default		; 5D	; 
	POINTER Enemy@Default		; 5E	; 
	POINTER Enemy@Default		; 5F	; 
	POINTER Enemy@Default		; 60	; 
	POINTER Enemy@Default		; 61	; 
	POINTER Enemy@Default		; 62	; 
	POINTER Enemy@Default		; 63	; 
	POINTER Enemy@Default		; 64	; 
	POINTER Enemy@Default		; 65	; 
	POINTER Enemy@Default		; 66	; 
	POINTER Enemy@Default		; 67	; 
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69
	
 SprTableAlt:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03
	POINTER Enemy@Default		; 04
	POINTER Enemy@Default		; 05
	POINTER Enemy@Koopa1R		; *06
	POINTER Enemy@Koopa2R		; *07
	POINTER Enemy@KoopaShell1 	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; *0A
	POINTER Enemy@Default		; *0B
	POINTER Enemy@Default		; *0C
	POINTER Enemy@Default		; 0D
	POINTER Enemy@KoopaShell2 	; 0E
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Enemy@Default		; 11
	POINTER Item@Platform		; 12
	POINTER Enemy@Default		; 13
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C
	POINTER Enemy@Default		; 1D
	POINTER Enemy@Default		; 1E
	POINTER Enemy@Default		; 1F
	POINTER Enemy@Default		; 20
	POINTER Enemy@Default		; 21
	POINTER Enemy@Default		; 22
	POINTER Enemy@Default		; 23
	POINTER Enemy@Default		; 24
	POINTER Enemy@Default		; 25
	POINTER Enemy@Default		; 26
	POINTER Enemy@Default		; 27
	POINTER Enemy@Fly1R			; *28
	POINTER Enemy@Fly2R			; *29
	POINTER Enemy@Sphynx1R		; *2A
	POINTER Enemy@Sphynx2R		; *2B
	POINTER Enemy@FlyDead		; *2C
	POINTER Enemy@FlyDeadF		; 2D
	POINTER Enemy@SphynxDeadR	; *2E
	POINTER Enemy@SphynxDeadF	; 2F
	POINTER Enemy@Default		; *30
	POINTER Enemy@Default		; *31
	POINTER Enemy@Default		; *32
	POINTER Enemy@Default		; *33
	POINTER Enemy@Default		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@Default		; *36
	POINTER Enemy@Default		; 37
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C
	POINTER Enemy@Default		; 3D
	POINTER Enemy@Default		; 3E
	POINTER Enemy@Default		; 3F
	POINTER Enemy@Default		; 40
	POINTER Enemy@Default		; 41
	POINTER Enemy@Default		; 42
	POINTER Enemy@Default		; 43
	POINTER Enemy@Default		; 44
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@Default		; 46
	POINTER Enemy@Default		; 47
	POINTER Enemy@Default		; 48
	POINTER Enemy@Default		; 49
	POINTER Enemy@Default		; 4A
	POINTER Enemy@Default		; 4B
	POINTER Enemy@Default		; 4C
	POINTER Enemy@Default		; 4D
	POINTER Enemy@Default		; 4E
	POINTER Enemy@Default		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@Default		; 51
	POINTER Enemy@Default		; *52
	POINTER Enemy@Default		; *53
	POINTER Enemy@Default		; 54
	POINTER Enemy@Default		; 55
	POINTER Enemy@Default		; 56
	POINTER Enemy@Default		; 57
	POINTER Enemy@Default		; 58
	POINTER Enemy@Default		; 59
	POINTER Enemy@Default		; 5A
	POINTER Enemy@Default		; 5B
	POINTER Enemy@Default		; 5C
	POINTER Enemy@Default		; 5D
	POINTER Enemy@Default		; 5E
	POINTER Enemy@Default		; 5F
	POINTER Enemy@Default		; 60
	POINTER Enemy@Default		; 61
	POINTER Enemy@Default		; 62
	POINTER Enemy@Default		; 63
	POINTER Enemy@Default		; 64
	POINTER Enemy@Default		; 65
	POINTER Enemy@Default		; 66
	POINTER Enemy@Default		; 67
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69

 SprTable1b:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03	; Goomba flipped
	POINTER Enemy@Piranha1a		; 04	; Piranha Plant closed mouth
	POINTER Enemy@Piranha2a		; 05	; Piranha Plant open mouth
	POINTER Enemy@Koopa1		; 06
	POINTER Enemy@Koopa2		; 07
	POINTER Enemy@KoopaShell1	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; 0A	; Part of the cloud?
	POINTER Enemy@Default		; 0B	; Cannon?
	POINTER Enemy@Default		; 0C	; Part of the cloud?
	POINTER Enemy@Default		; 0D	; ""
	POINTER Enemy@KoopaShell2 	; 0E	
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Item@Platform		; 11	; Apparently repeated?
	POINTER Item@Platform		; 12
	POINTER Item@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15	; Circular explosion 2
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18	; Light colored star
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C	; Coin 1. Unused?
	POINTER Enemy@Default		; 1D	; Coin 2 ""
	POINTER Enemy@Default		; 1E	; Coin 3 ""
	POINTER Item@Nothing		; 1F	; Nothing? It uses tile FE
	POINTER Enemy@Default		; 20	; Stalactite 
	POINTER Item@Spring1			; 21	; Small platform (spring shaped)
	POINTER Item@MidPlatform	; 22	; Medium platform (two steps)
	POINTER Enemy@Default		; 23	; No idea. Alternate gfx needed?
	POINTER Enemy@Default		; 24	; No idea 2
	POINTER Enemy@Default		; 25	; No idea 3
	POINTER Enemy@Default		; 26	
	POINTER Enemy@Default		; 27
	POINTER Enemy@Fly1			; 28
	POINTER Enemy@Fly2			; 29
	POINTER Enemy@Sphynx1		; 2A
	POINTER Enemy@Sphynx2		; 2B
	POINTER Enemy@FlyDead		; 2C
	POINTER Enemy@FlyDeadF		; 2D
	POINTER Enemy@SphynxDead	; *2E	; SphynxDead, not sure if reversed or flipped
	POINTER Enemy@SphynxDeadF	; 2F
	POINTER Enemy@Bee1			; *30	; Bee	D0 D1 C0 C1
	POINTER Enemy@Bee2			; *31	; Bee 2	D2 D3 C2 C3
	POINTER Enemy@Default		; *32	; Two fires at the same time?
	POINTER Enemy@Default		; *33	; Half lion
	POINTER Enemy@BeeDead		; *34	; Dead Bee
	POINTER Enemy@BeeDeadF		; 35	; Dead Bee flipped
	POINTER Enemy@Default		; *36
	POINTER Enemy@Default		; 37	
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C	; Lion's tail?
	POINTER Enemy@Default		; 3D	; Lion's paw?
	POINTER Enemy@Default		; 3E	; Lion's back?
	POINTER Enemy@Default		; 3F	; Lion's back? flipped
	POINTER Enemy@Default		; 40	; Lion something
	POINTER Enemy@Default		; 41	; Lion something flipped
	POINTER Enemy@Default		; 42	; Half bee?
	POINTER Enemy@Default		; 43	; Other half bee
	POINTER Enemy@BeeArrow		; 44	; Arrow down
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@Default		; 46
	POINTER Enemy@Default		; 47	; Bee (not dead) flipped
	POINTER Boss@Lion			; 48	; Lion Boss
	POINTER Boss@Lion2			; 49	; Lion Boss 2
	POINTER Boss@LionFire		; 4A	; Fireball A (lion's?)
	POINTER Boss@LionFire2		; 4B	; Fireball B
	POINTER Enemy@Default		; 4C	
	POINTER Enemy@Default		; 4D
	POINTER Enemy@Default		; 4E
	POINTER Enemy@Default		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@Default		; 51	; 
	POINTER Enemy@Default		; 52	; 
	POINTER Enemy@Default		; 53	; 
	POINTER Enemy@Default		; 54	; 
	POINTER Enemy@Default		; 55	; 
	POINTER Enemy@Default		; 56	; 
	POINTER Enemy@Default		; 57	; 
	POINTER Enemy@Default		; 58	; 
	POINTER Enemy@Default		; 59	; 
	POINTER Enemy@Default		; 5A	; 
	POINTER Enemy@Default		; 5B	; 
	POINTER Enemy@Default		; 5C	; 
	POINTER Enemy@Default		; 5D	; 
	POINTER Enemy@Default		; 5E	; 
	POINTER Enemy@Default		; 5F	; 
	POINTER Enemy@Default		; 60	; 
	POINTER Enemy@Default		; 61	; 
	POINTER Enemy@Default		; 62	; 
	POINTER Enemy@Default		; 63	; 
	POINTER Enemy@Default		; 64	; 
	POINTER Enemy@Default		; 65	; 
	POINTER Enemy@Default		; 66	; 
	POINTER Enemy@Default		; 67	; 
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69
	
 SprTableAlt1b:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03
	POINTER Enemy@Default		; 04
	POINTER Enemy@Default		; 05
	POINTER Enemy@Koopa1R		; *06
	POINTER Enemy@Koopa2R		; *07
	POINTER Enemy@KoopaShell1 	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; *0A
	POINTER Enemy@Default		; *0B
	POINTER Enemy@Default		; *0C
	POINTER Enemy@Default		; 0D
	POINTER Enemy@KoopaShell2 	; 0E
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Enemy@Default		; 11
	POINTER Item@Platform		; 12
	POINTER Enemy@Default		; 13
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C
	POINTER Enemy@Default		; 1D
	POINTER Enemy@Default		; 1E
	POINTER Enemy@Default		; 1F
	POINTER Enemy@Default		; 20
	POINTER Enemy@Default		; 21
	POINTER Enemy@Default		; 22
	POINTER Enemy@Default		; 23
	POINTER Enemy@Default		; 24
	POINTER Enemy@Default		; 25
	POINTER Enemy@Default		; 26
	POINTER Enemy@Default		; 27
	POINTER Enemy@Fly1R			; *28
	POINTER Enemy@Fly2R			; *29
	POINTER Enemy@Sphynx1R		; *2A
	POINTER Enemy@Sphynx2R		; *2B
	POINTER Enemy@FlyDead		; *2C
	POINTER Enemy@FlyDeadF		; 2D
	POINTER Enemy@SphynxDeadR	; *2E
	POINTER Enemy@SphynxDeadF	; 2F
	POINTER Enemy@Default		; *30
	POINTER Enemy@Default		; *31
	POINTER Enemy@Default		; *32
	POINTER Enemy@Default		; *33
	POINTER Enemy@Default		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@Default		; *36
	POINTER Enemy@Default		; 37
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C
	POINTER Enemy@Default		; 3D
	POINTER Enemy@Default		; 3E
	POINTER Enemy@Default		; 3F
	POINTER Enemy@Default		; 40
	POINTER Enemy@Default		; 41
	POINTER Enemy@Default		; 42
	POINTER Enemy@Default		; 43
	POINTER Enemy@Default		; 44
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@Default		; 46
	POINTER Enemy@Default		; 47
	POINTER Enemy@Default		; 48
	POINTER Enemy@Default		; 49
	POINTER Enemy@Default		; 4A
	POINTER Enemy@Default		; 4B
	POINTER Enemy@Default		; 4C
	POINTER Enemy@Default		; 4D
	POINTER Enemy@Default		; 4E
	POINTER Enemy@Default		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@Default		; 51
	POINTER Enemy@Default		; *52
	POINTER Enemy@Default		; *53
	POINTER Enemy@Default		; 54
	POINTER Enemy@Default		; 55
	POINTER Enemy@Default		; 56
	POINTER Enemy@Default		; 57
	POINTER Enemy@Default		; 58
	POINTER Enemy@Default		; 59
	POINTER Enemy@Default		; 5A
	POINTER Enemy@Default		; 5B
	POINTER Enemy@Default		; 5C
	POINTER Enemy@Default		; 5D
	POINTER Enemy@Default		; 5E
	POINTER Enemy@Default		; 5F
	POINTER Enemy@Default		; 60
	POINTER Enemy@Default		; 61
	POINTER Enemy@Default		; 62
	POINTER Enemy@Default		; 63
	POINTER Enemy@Default		; 64
	POINTER Enemy@Default		; 65
	POINTER Enemy@Default		; 66
	POINTER Enemy@Default		; 67
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69



 SprTable2:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03	; Goomba flipped
	POINTER Enemy@Piranha1a		; 04	; Piranha Plant closed mouth
	POINTER Enemy@Piranha2a		; 05	; Piranha Plant open mouth
	POINTER Enemy@Koopa1		; 06
	POINTER Enemy@Koopa2		; 07
	POINTER Enemy@KoopaShell1	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; 0A	; Part of the cloud?
	POINTER Enemy@Default		; 0B	; Cannon?
	POINTER Enemy@Default		; 0C	; Part of the cloud?
	POINTER Enemy@Default		; 0D	; ""
	POINTER Enemy@KoopaShell2 	; 0E	
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Item@Platform		; 11	; Apparently repeated?
	POINTER Item@Platform		; 12
	POINTER Item@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15	; Circular explosion 2
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18	; Light colored star
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C	; Coin 1. Unused?
	POINTER Enemy@Default		; 1D	; Coin 2 ""
	POINTER Enemy@Default		; 1E	; Coin 3 ""
	POINTER Item@Nothing		; 1F	; Nothing? It uses tile FE
	POINTER Enemy@Default		; 20	; Stalactite 
	POINTER Item@Spring			; 21	; Small platform (spring shaped)
	POINTER Item@MidPlatform	; 22	; Medium platform (two steps)
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26	
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Octopus1		; 28
	POINTER Enemy@Octopus2		; 29
	POINTER Enemy@Seahorse1		; 2A
	POINTER Enemy@Seahorse2		; 2B		
	POINTER Enemy@Fish1			; 2C
	POINTER Enemy@FlyDeadF		; 2D
	POINTER Enemy@Fish2			; *2E	; SphynxDead, not sure if reversed or flipped
	POINTER Enemy@SphynxDeadF	; 2F
	POINTER Enemy@Bee1			; *30	; Bee	D0 D1 C0 C1
	POINTER Enemy@Bee2			; *31	; Bee 2	D2 D3 C2 C3
	POINTER Enemy@Robot1		; *32	; Robot 1
	POINTER Enemy@Robot2		; *33	; Robot 2
	POINTER Enemy@BeeDead		; *34	; Dead Bee
	POINTER Enemy@BeeDeadF		; 35	; Dead Bee flipped
	POINTER Enemy@RobotDead		; *36
	POINTER Enemy@RobotDeadF	; 37	
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C	; 
	POINTER Enemy@Default		; 3D	; 
	POINTER Enemy@RobotHead		; 3E	; Robot's head
	POINTER Enemy@Default		; 3F	; 
	POINTER Enemy@RobotBody		; 40	; Robot's body
	POINTER Enemy@Default		; 41	; 
	POINTER Enemy@Fishbone1		; 42	; Fishbone 1
	POINTER Enemy@Fishbone2		; 43	; Fishbone 2
	POINTER Enemy@BeeArrow		; 44	; Arrow down
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@Default		; 47	; Bee (not dead) flipped
	POINTER Boss@Lion			; 48	; Lion Boss
	POINTER Boss@Lion2			; 49	; Lion Boss 2
	POINTER Boss@LionFire		; 4A	; Fireball A (lion's?)
	POINTER Boss@LionFire2		; 4B	; Fireball B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1	; 51	; 
	POINTER Enemy@BulletBill2	; 52	; 
	POINTER Enemy@BulletBill3	; 53	; 
	POINTER Enemy@Default		; 54	; 
	POINTER Enemy@Default		; 55	; 
	POINTER Enemy@Default		; 56	; 
	POINTER Enemy@Default		; 57	; 
	POINTER Enemy@Default		; 58	; 
	POINTER Enemy@Default		; 59	; 
	POINTER Enemy@Default		; 5A	; 
	POINTER Enemy@Default		; 5B	; 
	POINTER Enemy@Default		; 5C	; 
	POINTER Enemy@Default		; 5D	; 
	POINTER Enemy@Default		; 5E	; 
	POINTER Enemy@Default		; 5F	; 
	POINTER Enemy@Default		; 60	; 
	POINTER Enemy@Default		; 61	; 
	POINTER Enemy@Default		; 62	; 
	POINTER Enemy@Default		; 63	; 
	POINTER Enemy@Default		; 64	; 
	POINTER Enemy@Default		; 65	; 
	POINTER Enemy@Default		; 66	; 
	POINTER Enemy@Default		; 67	; 
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69
	
 SprTableAlt2:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03
	POINTER Enemy@Default		; 04
	POINTER Enemy@Default		; 05
	POINTER Enemy@Koopa1R		; *06
	POINTER Enemy@Koopa2R		; *07
	POINTER Enemy@KoopaShell1 	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; *0A
	POINTER Enemy@Default		; *0B
	POINTER Enemy@Default		; *0C
	POINTER Enemy@Default		; 0D
	POINTER Enemy@KoopaShell2 	; 0E
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Enemy@Default		; 11
	POINTER Item@Platform		; 12
	POINTER Enemy@Default		; 13
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C
	POINTER Enemy@Default		; 1D
	POINTER Enemy@Default		; 1E
	POINTER Enemy@Default		; 1F
	POINTER Enemy@Default		; 20
	POINTER Enemy@Default		; 21
	POINTER Enemy@Default		; 22
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Octopus1R		; *28
	POINTER Enemy@Octopus2R		; *29
	POINTER Enemy@Seahorse1R	; *2A
	POINTER Enemy@Seahorse2R	; *2B
	POINTER Enemy@Fish1R		; *2C
	POINTER Enemy@FlyDeadF		; 2D
	POINTER Enemy@Fish2R		; *2E
	POINTER Enemy@SphynxDeadF	; 2F
	POINTER Enemy@Default		; *30
	POINTER Enemy@Default		; *31
	POINTER Enemy@Robot1		; *32
	POINTER Enemy@Robot2		; *33
	POINTER Enemy@Default		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@RobotDead		; *36
	POINTER Enemy@RobotDeadF	; 37
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C
	POINTER Enemy@Default		; 3D
	POINTER Enemy@RobotHead		; 3E	
	POINTER Enemy@Default		; 3F
	POINTER Enemy@RobotBody		; 40
	POINTER Enemy@Default		; 41
	POINTER Enemy@Default		; 42
	POINTER Enemy@Default		; 43
	POINTER Enemy@Default		; 44
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@Default		; 47
	POINTER Enemy@Default		; 48
	POINTER Enemy@Default		; 49
	POINTER Enemy@Default		; 4A
	POINTER Enemy@Default		; 4B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1	; 51	; 
	POINTER Enemy@BulletBill2R	; *52	; 
	POINTER Enemy@BulletBill3R	; *53	; 
	POINTER Enemy@Default		; 54
	POINTER Enemy@Default		; 55
	POINTER Enemy@Default		; 56
	POINTER Enemy@Default		; 57
	POINTER Enemy@Default		; 58
	POINTER Enemy@Default		; 59
	POINTER Enemy@Default		; 5A
	POINTER Enemy@Default		; 5B
	POINTER Enemy@Default		; 5C
	POINTER Enemy@Default		; 5D
	POINTER Enemy@Default		; 5E
	POINTER Enemy@Default		; 5F
	POINTER Enemy@Default		; 60
	POINTER Enemy@Default		; 61
	POINTER Enemy@Default		; 62
	POINTER Enemy@Default		; 63
	POINTER Enemy@Default		; 64
	POINTER Enemy@Default		; 65
	POINTER Enemy@Default		; 66
	POINTER Enemy@Default		; 67
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69

 SprTable3:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03	; Goomba flipped
	POINTER Enemy@Piranha1b		; 04	; Piranha Plant closed mouth
	POINTER Enemy@Piranha2b		; 05	; Piranha Plant open mouth
	POINTER Enemy@Koopa1		; 06
	POINTER Enemy@Koopa2		; 07
	POINTER Enemy@KoopaShell1	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; 0A	; Part of the cloud?
	POINTER Enemy@Default		; 0B	; Cannon?
	POINTER Enemy@Default		; 0C	; Part of the cloud?
	POINTER Enemy@Default		; 0D	; ""
	POINTER Enemy@KoopaShell2 	; 0E	
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Item@Platform		; 11	; Apparently repeated?
	POINTER Item@Platform		; 12
	POINTER Item@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15	; Circular explosion 2
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18	; Light colored star
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C	; Coin 1. Unused?
	POINTER Enemy@Default		; 1D	; Coin 2 ""
	POINTER Enemy@Default		; 1E	; Coin 3 ""
	POINTER Item@Nothing		; 1F	; Nothing? It uses tile FE
	POINTER Enemy@Stalactite	; 20	; Stalactite 
	POINTER Item@Spring			; 21	; Small platform (spring shaped)
	POINTER Item@MidPlatform	; 22	; Medium platform (two steps)
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26	
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Spider1		; 28
	POINTER Enemy@Spider2		; 29
	POINTER Enemy@Tokoto1		; 2A
	POINTER Enemy@Tokoto2		; 2B		
	POINTER Enemy@SpiderDead	; 2C
	POINTER Enemy@SpiderDeadF	; 2D
	POINTER Enemy@TokotoDead	; *2E	
	POINTER Enemy@TokotoDeadF	; 2F
	POINTER Enemy@Bee1			; *30
	POINTER Enemy@Boulder		; *31
	POINTER Enemy@CeilSpider1	; *32
	POINTER Enemy@CeilSpider2	; *33
	POINTER Enemy@BeeDead		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37	
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C	; 
	POINTER Enemy@Default		; 3D	; 
	POINTER Enemy@RobotHead		; 3E	; Robot's head
	POINTER Enemy@Default		; 3F	; 
	POINTER Enemy@RobotBody		; 40	; Robot's body
	POINTER Enemy@Default		; 41	; 
	POINTER Enemy@Fishbone1		; 42	; Fishbone 1
	POINTER Enemy@Fishbone2		; 43	; Fishbone 2
	POINTER Enemy@BeeArrow		; 44	; Arrow down
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderF		; 47	; 
	POINTER Boss@Lion			; 48	; Lion Boss
	POINTER Boss@Lion2			; 49	; Lion Boss 2
	POINTER Boss@LionFire		; 4A	; Fireball A (lion's?)
	POINTER Boss@LionFire2		; 4B	; Fireball B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1	; 51	; 
	POINTER Enemy@BulletBill2	; 52	; 
	POINTER Enemy@BulletBill3	; 53	; 
	POINTER Boss@Boulder1		; 54	; 
	POINTER Boss@Boulder2		; 55	; 
	POINTER Enemy@Default		; 56	; 
	POINTER Enemy@Default		; 57	; 
	POINTER Enemy@Default		; 58	; 
	POINTER Enemy@Default		; 59	; 
	POINTER Enemy@Default		; 5A	; 
	POINTER Enemy@Default		; 5B	; 
	POINTER Enemy@Default		; 5C	; 
	POINTER Enemy@Default		; 5D	; 
	POINTER Enemy@Default		; 5E	; 
	POINTER Enemy@Default		; 5F	; 
	POINTER Enemy@Default		; 60	; 
	POINTER Enemy@Default		; 61	; 
	POINTER Enemy@Default		; 62	; 
	POINTER Enemy@Default		; 63	; 
	POINTER Enemy@Default		; 64	; 
	POINTER Enemy@Default		; 65	; 
	POINTER Enemy@Default		; 66	; 
	POINTER Enemy@Default		; 67	; 
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69
	
 SprTableAlt3:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03
	POINTER Enemy@Default		; 04
	POINTER Enemy@Default		; 05
	POINTER Enemy@Koopa1R		; *06
	POINTER Enemy@Koopa2R		; *07
	POINTER Enemy@KoopaShell1 	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; *0A
	POINTER Enemy@Default		; *0B
	POINTER Enemy@Default		; *0C
	POINTER Enemy@Default		; 0D
	POINTER Enemy@KoopaShell2 	; 0E
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Enemy@Default		; 11
	POINTER Item@Platform		; 12
	POINTER Enemy@Default		; 13
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C
	POINTER Enemy@Default		; 1D
	POINTER Enemy@Default		; 1E
	POINTER Enemy@Default		; 1F
	POINTER Enemy@Stalactite	; 20
	POINTER Enemy@Default		; 21
	POINTER Item@MidPlatform	; 22
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Spider1		; *28
	POINTER Enemy@Spider2		; *29
	POINTER Enemy@Tokoto1R		; *2A
	POINTER Enemy@Tokoto2R		; *2B
	POINTER Enemy@SpiderDead	; 2C
	POINTER Enemy@SpiderDeadF	; 2D
	POINTER Enemy@TokotoDeadR	; *2E
	POINTER Enemy@TokotoDeadF	; 2F
	POINTER Enemy@Default		; *30
	POINTER Enemy@BoulderR		; *31
	POINTER Enemy@CeilSpider1	; *32
	POINTER Enemy@CeilSpider2	; *33
	POINTER Enemy@Default		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C
	POINTER Enemy@Default		; 3D
	POINTER Enemy@RobotHead		; 3E	
	POINTER Enemy@Default		; 3F
	POINTER Enemy@RobotBody		; 40
	POINTER Enemy@Default		; 41
	POINTER Enemy@Default		; 42
	POINTER Enemy@Default		; 43
	POINTER Enemy@Default		; 44
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderFR		; 47
	POINTER Enemy@Default		; 48
	POINTER Enemy@Default		; 49
	POINTER Enemy@Default		; 4A
	POINTER Enemy@Default		; 4B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1	; 51	; 
	POINTER Enemy@BulletBill2R	; *52	; 
	POINTER Enemy@BulletBill3R	; *53	; 
	POINTER Boss@Boulder1		; 54
	POINTER Boss@Boulder2		; 55
	POINTER Enemy@Default		; 56
	POINTER Enemy@Default		; 57
	POINTER Enemy@Default		; 58
	POINTER Enemy@Default		; 59
	POINTER Enemy@Default		; 5A
	POINTER Enemy@Default		; 5B
	POINTER Enemy@Default		; 5C
	POINTER Enemy@Default		; 5D
	POINTER Enemy@Default		; 5E
	POINTER Enemy@Default		; 5F
	POINTER Enemy@Default		; 60
	POINTER Enemy@Default		; 61
	POINTER Enemy@Default		; 62
	POINTER Enemy@Default		; 63
	POINTER Enemy@Default		; 64
	POINTER Enemy@Default		; 65
	POINTER Enemy@Default		; 66
	POINTER Enemy@Default		; 67
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69

 

 SprTable3b:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03	; Goomba flipped
	POINTER Enemy@Piranha1b		; 04	; Piranha Plant closed mouth
	POINTER Enemy@Piranha1b		; 05	; Piranha Plant open mouth
	POINTER Enemy@Koopa1		; 06
	POINTER Enemy@Koopa2		; 07
	POINTER Enemy@KoopaShell1	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; 0A	; Part of the cloud?
	POINTER Enemy@Default		; 0B	; Cannon?
	POINTER Enemy@Default		; 0C	; Part of the cloud?
	POINTER Enemy@Default		; 0D	; ""
	POINTER Enemy@KoopaShell2 	; 0E	
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Item@Platform		; 11	; Apparently repeated?
	POINTER Item@Platform		; 12
	POINTER Item@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15	; Circular explosion 2
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18	; Light colored star
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C	; Coin 1. Unused?
	POINTER Enemy@Default		; 1D	; Coin 2 ""
	POINTER Enemy@Default		; 1E	; Coin 3 ""
	POINTER Item@Nothing		; 1F	; Nothing? It uses tile FE
	POINTER Enemy@Stalactite	; 20	; Stalactite 
	POINTER Item@Spring1b		; 21	; Small platform (spring shaped)
	POINTER Item@MidPlatform	; 22	; Medium platform (two steps)
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26	
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Spider1		; 28
	POINTER Enemy@Spider2		; 29
	POINTER Enemy@Tokoto1		; 2A
	POINTER Enemy@Tokoto2		; 2B		
	POINTER Enemy@SpiderDead	; 2C
	POINTER Enemy@SpiderDeadF	; 2D
	POINTER Enemy@TokotoDead	; *2E	
	POINTER Enemy@TokotoDeadF	; 2F
	POINTER Enemy@Bee1			; *30
	POINTER Enemy@Boulder1		; *31
	POINTER Enemy@CeilSpider1	; *32
	POINTER Enemy@CeilSpider2	; *33
	POINTER Enemy@BeeDead		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37	
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C	; 
	POINTER Enemy@Default		; 3D	; 
	POINTER Enemy@RobotHead		; 3E	; Robot's head
	POINTER Enemy@Default		; 3F	; 
	POINTER Enemy@RobotBody		; 40	; Robot's body
	POINTER Enemy@Default		; 41	; 
	POINTER Enemy@Fishbone1		; 42	; Fishbone 1
	POINTER Enemy@Fishbone2		; 43	; Fishbone 2
	POINTER Enemy@BeeArrow		; 44	; Arrow down
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderF1		; 47	; 
	POINTER Boss@Lion			; 48	; Lion Boss
	POINTER Boss@Lion2			; 49	; Lion Boss 2
	POINTER Boss@LionFire		; 4A	; Fireball A (lion's?)
	POINTER Boss@LionFire2		; 4B	; Fireball B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1	; 51	; 
	POINTER Enemy@BulletBill2	; 52	; 
	POINTER Enemy@BulletBill3	; 53	; 
	POINTER Boss@Boulder1		; 54	; 
	POINTER Boss@Boulder2		; 55	; 
	POINTER Enemy@Default		; 56	; 
	POINTER Enemy@Default		; 57	; 
	POINTER Enemy@Default		; 58	; 
	POINTER Enemy@Default		; 59	; 
	POINTER Enemy@Default		; 5A	; 
	POINTER Enemy@Default		; 5B	; 
	POINTER Enemy@Default		; 5C	; 
	POINTER Enemy@Default		; 5D	; 
	POINTER Enemy@Default		; 5E	; 
	POINTER Enemy@Default		; 5F	; 
	POINTER Enemy@Default		; 60	; 
	POINTER Enemy@Default		; 61	; 
	POINTER Enemy@Default		; 62	; 
	POINTER Enemy@Default		; 63	; 
	POINTER Enemy@Default		; 64	; 
	POINTER Enemy@Default		; 65	; 
	POINTER Enemy@Default		; 66	; 
	POINTER Enemy@Default		; 67	; 
	POINTER Item@Elevator1		; 68	; Elevator
	POINTER Enemy@Default		; 69
	
 SprTableAlt3b:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03
	POINTER Enemy@Default		; 04
	POINTER Enemy@Default		; 05
	POINTER Enemy@Koopa1R		; *06
	POINTER Enemy@Koopa2R		; *07
	POINTER Enemy@KoopaShell1 	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; *0A
	POINTER Enemy@Default		; *0B
	POINTER Enemy@Default		; *0C
	POINTER Enemy@Default		; 0D
	POINTER Enemy@KoopaShell2 	; 0E
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Enemy@Default		; 11
	POINTER Item@Platform		; 12
	POINTER Enemy@Default		; 13
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C
	POINTER Enemy@Default		; 1D
	POINTER Enemy@Default		; 1E
	POINTER Enemy@Default		; 1F
	POINTER Enemy@Stalactite	; 20
	POINTER Enemy@Default		; 21
	POINTER Item@MidPlatform	; 22
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Spider1		; *28
	POINTER Enemy@Spider2		; *29
	POINTER Enemy@Tokoto1R		; *2A
	POINTER Enemy@Tokoto2R		; *2B
	POINTER Enemy@SpiderDead	; 2C
	POINTER Enemy@SpiderDeadF	; 2D
	POINTER Enemy@TokotoDeadR	; *2E
	POINTER Enemy@TokotoDeadF	; 2F
	POINTER Enemy@Default		; *30
	POINTER Enemy@BoulderR1		; *31
	POINTER Enemy@CeilSpider1	; *32
	POINTER Enemy@CeilSpider2	; *33
	POINTER Enemy@Default		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C
	POINTER Enemy@Default		; 3D
	POINTER Enemy@RobotHead		; 3E	
	POINTER Enemy@Default		; 3F
	POINTER Enemy@RobotBody		; 40
	POINTER Enemy@Default		; 41
	POINTER Enemy@Default		; 42
	POINTER Enemy@Default		; 43
	POINTER Enemy@Default		; 44
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderFR1	; 47
	POINTER Enemy@Default		; 48
	POINTER Enemy@Default		; 49
	POINTER Enemy@Default		; 4A
	POINTER Enemy@Default		; 4B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1	; 51	; 
	POINTER Enemy@BulletBill2R	; *52	; 
	POINTER Enemy@BulletBill3R	; *53	; 
	POINTER Boss@Boulder1		; 54
	POINTER Boss@Boulder2		; 55
	POINTER Enemy@Default		; 56
	POINTER Enemy@Default		; 57
	POINTER Enemy@Default		; 58
	POINTER Enemy@Default		; 59
	POINTER Enemy@Default		; 5A
	POINTER Enemy@Default		; 5B
	POINTER Enemy@Default		; 5C
	POINTER Enemy@Default		; 5D
	POINTER Enemy@Default		; 5E
	POINTER Enemy@Default		; 5F
	POINTER Enemy@Default		; 60
	POINTER Enemy@Default		; 61
	POINTER Enemy@Default		; 62
	POINTER Enemy@Default		; 63
	POINTER Enemy@Default		; 64
	POINTER Enemy@Default		; 65
	POINTER Enemy@Default		; 66
	POINTER Enemy@Default		; 67
	POINTER Item@Elevator1		; 68	; Elevator
	POINTER Enemy@Default		; 69


 SprTable3c:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03	; Goomba flipped
	POINTER Enemy@Piranha1b		; 04	; Piranha Plant closed mouth
	POINTER Enemy@Piranha1b		; 05	; Piranha Plant open mouth
	POINTER Enemy@Koopa1		; 06
	POINTER Enemy@Koopa2		; 07
	POINTER Enemy@KoopaShell1	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; 0A	; Part of the cloud?
	POINTER Enemy@Default		; 0B	; Cannon?
	POINTER Enemy@Default		; 0C	; Part of the cloud?
	POINTER Enemy@Default		; 0D	; ""
	POINTER Enemy@KoopaShell2 	; 0E	
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Item@Platform		; 11	; Apparently repeated?
	POINTER Item@Platform		; 12
	POINTER Item@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15	; Circular explosion 2
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18	; Light colored star
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C	; Coin 1. Unused?
	POINTER Enemy@Default		; 1D	; Coin 2 ""
	POINTER Enemy@Default		; 1E	; Coin 3 ""
	POINTER Item@Nothing		; 1F	; Nothing? It uses tile FE
	POINTER Enemy@Stalactite	; 20	; Stalactite 
	POINTER Item@Spring2		; 21	; Small platform (spring shaped)
	POINTER Item@MidPlatform	; 22	; Medium platform (two steps)
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26	
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Spider1		; 28
	POINTER Enemy@Spider2		; 29
	POINTER Enemy@Tokoto1		; 2A
	POINTER Enemy@Tokoto2		; 2B		
	POINTER Enemy@SpiderDead	; 2C
	POINTER Enemy@SpiderDeadF	; 2D
	POINTER Enemy@TokotoDead	; *2E	
	POINTER Enemy@TokotoDeadF	; 2F
	POINTER Enemy@Bee1			; *30
	POINTER Enemy@Boulder		; *31
	POINTER Enemy@CeilSpider1	; *32
	POINTER Enemy@CeilSpider2	; *33
	POINTER Enemy@BeeDead		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37	
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C	; 
	POINTER Enemy@Default		; 3D	; 
	POINTER Enemy@RobotHead		; 3E	; Robot's head
	POINTER Enemy@Default		; 3F	; 
	POINTER Enemy@RobotBody		; 40	; Robot's body
	POINTER Enemy@Default		; 41	; 
	POINTER Enemy@Fishbone1		; 42	; Fishbone 1
	POINTER Enemy@Fishbone2		; 43	; Fishbone 2
	POINTER Enemy@BeeArrow		; 44	; Arrow down
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderF		; 47	; 
	POINTER Boss@Lion			; 48	; Lion Boss
	POINTER Boss@Lion2			; 49	; Lion Boss 2
	POINTER Boss@LionFire		; 4A	; Fireball A (lion's?)
	POINTER Boss@LionFire2		; 4B	; Fireball B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1	; 51	; 
	POINTER Enemy@BulletBill2	; 52	; 
	POINTER Enemy@BulletBill3	; 53	; 
	POINTER Boss@Boulder1		; 54	; 
	POINTER Boss@Boulder2		; 55	; 
	POINTER Enemy@Default		; 56	; 
	POINTER Enemy@Default		; 57	; 
	POINTER Enemy@Default		; 58	; 
	POINTER Enemy@Default		; 59	; 
	POINTER Enemy@Default		; 5A	; 
	POINTER Enemy@Default		; 5B	; 
	POINTER Enemy@Default		; 5C	; 
	POINTER Enemy@Default		; 5D	; 
	POINTER Enemy@Default		; 5E	; 
	POINTER Enemy@Default		; 5F	; 
	POINTER Enemy@Default		; 60	; 
	POINTER Enemy@Default		; 61	; 
	POINTER Enemy@Default		; 62	; 
	POINTER Enemy@Default		; 63	; 
	POINTER Enemy@Default		; 64	; 
	POINTER Enemy@Default		; 65	; 
	POINTER Enemy@Default		; 66	; 
	POINTER Enemy@Default		; 67	; 
	POINTER Item@Elevator1		; 68	; Elevator
	POINTER Enemy@Default		; 69
	
 SprTableAlt3c:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03
	POINTER Enemy@Default		; 04
	POINTER Enemy@Default		; 05
	POINTER Enemy@Koopa1R		; *06
	POINTER Enemy@Koopa2R		; *07
	POINTER Enemy@KoopaShell1 	; 08
	POINTER Enemy@Koopa1F		; 09
	POINTER Enemy@Default		; *0A
	POINTER Enemy@Default		; *0B
	POINTER Enemy@Default		; *0C
	POINTER Enemy@Default		; 0D
	POINTER Enemy@KoopaShell2 	; 0E
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Enemy@Default		; 11
	POINTER Item@Platform		; 12
	POINTER Enemy@Default		; 13
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C
	POINTER Enemy@Default		; 1D
	POINTER Enemy@Default		; 1E
	POINTER Enemy@Default		; 1F
	POINTER Enemy@Stalactite	; 20
	POINTER Enemy@Default		; 21
	POINTER Item@MidPlatform	; 22
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Spider1		; *28
	POINTER Enemy@Spider2		; *29
	POINTER Enemy@Tokoto1R		; *2A
	POINTER Enemy@Tokoto2R		; *2B
	POINTER Enemy@SpiderDead	; 2C
	POINTER Enemy@SpiderDeadF	; 2D
	POINTER Enemy@TokotoDeadR	; *2E
	POINTER Enemy@TokotoDeadF	; 2F
	POINTER Enemy@Default		; *30
	POINTER Enemy@BoulderR		; *31
	POINTER Enemy@CeilSpider1	; *32
	POINTER Enemy@CeilSpider2	; *33
	POINTER Enemy@Default		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C
	POINTER Enemy@Default		; 3D
	POINTER Enemy@RobotHead		; 3E	
	POINTER Enemy@Default		; 3F
	POINTER Enemy@RobotBody		; 40
	POINTER Enemy@Default		; 41
	POINTER Enemy@Default		; 42
	POINTER Enemy@Default		; 43
	POINTER Enemy@Default		; 44
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderFR	; 47
	POINTER Enemy@Default		; 48
	POINTER Enemy@Default		; 49
	POINTER Enemy@Default		; 4A
	POINTER Enemy@Default		; 4B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1	; 51	; 
	POINTER Enemy@BulletBill2R	; *52	; 
	POINTER Enemy@BulletBill3R	; *53	; 
	POINTER Boss@Boulder1		; 54
	POINTER Boss@Boulder2		; 55
	POINTER Enemy@Default		; 56
	POINTER Enemy@Default		; 57
	POINTER Enemy@Default		; 58
	POINTER Enemy@Default		; 59
	POINTER Enemy@Default		; 5A
	POINTER Enemy@Default		; 5B
	POINTER Enemy@Default		; 5C
	POINTER Enemy@Default		; 5D
	POINTER Enemy@Default		; 5E
	POINTER Enemy@Default		; 5F
	POINTER Enemy@Default		; 60
	POINTER Enemy@Default		; 61
	POINTER Enemy@Default		; 62
	POINTER Enemy@Default		; 63
	POINTER Enemy@Default		; 64
	POINTER Enemy@Default		; 65
	POINTER Enemy@Default		; 66
	POINTER Enemy@Default		; 67
	POINTER Item@Elevator1		; 68	; Elevator
	POINTER Enemy@Default		; 69

 
 
 SprTable4:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03	; Goomba flipped
	POINTER Enemy@Piranha1c		; 04	; Piranha Plant closed mouth
	POINTER Enemy@Piranha2c		; 05	; Piranha Plant open mouth
	POINTER Enemy@Koopa1a		; 06
	POINTER Enemy@Koopa2a		; 07
	POINTER Enemy@KoopaShell1c	; 08
	POINTER Enemy@Koopa1Fa		; 09
	POINTER Enemy@Default		; 0A	; Part of the cloud?
	POINTER Enemy@Default		; 0B	; Cannon?
	POINTER Enemy@Default		; 0C	; Part of the cloud?
	POINTER Enemy@Default		; 0D	; ""
	POINTER Enemy@KoopaShell2 	; 0E	
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Item@Platform		; 11	; Apparently repeated?
	POINTER Item@Platform		; 12
	POINTER Item@EgyptPlatformAlt; 13	; Solid platform (Egypt) / DD+DE
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15	; Circular explosion 2
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18	; Light colored star
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C	; Coin 1. Unused?
	POINTER Enemy@Default		; 1D	; Coin 2 ""
	POINTER Enemy@Default		; 1E	; Coin 3 ""
	POINTER Item@Nothing		; 1F	; Nothing? It uses tile FE
	POINTER Enemy@Stalactite	; 20	; Stalactite 
	POINTER Item@Spring			; 21	; Small platform (spring shaped)
	POINTER Item@MidPlatform	; 22	; Medium platform (two steps)
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26	
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Zombie1		; 28
	POINTER Enemy@Zombie2		; 29
	POINTER Enemy@Snake1		; 2A
	POINTER Enemy@Snake2		; 2B		
	POINTER Enemy@ZombieDead	; 2C
	POINTER Enemy@ZombieDeadF	; 2D
	POINTER Enemy@SnakeDead		; *2E	
	POINTER Enemy@SnakeDeadF	; 2F
	POINTER Enemy@Bee1			; *30
	POINTER Enemy@Plane			; *31
	POINTER Enemy@CeilSpider1	; *32
	POINTER Enemy@CeilSpider2	; *33
	POINTER Enemy@BeeDead		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37	
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C	; 
	POINTER Enemy@Default		; 3D	; 
	POINTER Enemy@RobotHead		; 3E	; Robot's head
	POINTER Enemy@Default		; 3F	; 
	POINTER Enemy@RobotBody		; 40	; Robot's body
	POINTER Enemy@Default		; 41	; 
	POINTER Enemy@Fishbone1		; 42	; Fishbone 1
	POINTER Enemy@Fishbone2		; 43	; Fishbone 2
	POINTER Enemy@BeeArrow		; 44	; Arrow down
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderF		; 47	; 
	POINTER Boss@Lion			; 48	; Lion Boss
	POINTER Boss@Lion2			; 49	; Lion Boss 2
	POINTER Boss@LionFire		; 4A	; Fireball A (lion's?)
	POINTER Boss@LionFire2		; 4B	; Fireball B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1a	; 51	; 
	POINTER Enemy@BulletBill2a	; 52	; 
	POINTER Enemy@BulletBill3a	; 53	; 
	POINTER Boss@Boulder1		; 54	; 
	POINTER Boss@Boulder2		; 55	; 
	POINTER Enemy@FireFlower1	; 56
	POINTER Enemy@FireFlower2	; 57
	POINTER Enemy@Default		; 58	; 
	POINTER Enemy@Default		; 59	; 
	POINTER Enemy@Default		; 5A	; 
	POINTER Enemy@Default		; 5B	; 
	POINTER Enemy@Default		; 5C	; 
	POINTER Enemy@Default		; 5D	; 
	POINTER Enemy@Default		; 5E	; 
	POINTER Enemy@Piranha1F		; 5F	; 
	POINTER Enemy@Piranha2F		; 60	; 
	POINTER Enemy@DeadlyStar1	; 61
	POINTER Enemy@DeadlyStar2	; 62	; 
	POINTER Boss@Tatanga		; 63
	POINTER Boss@Ball			; 64
	POINTER Enemy@Fist			; 65	; 
	POINTER Boss@Kinton1		; 66
	POINTER Boss@Kinton2		; 67
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69
	
 SprTableAlt4:
	POINTER Enemy@Goomba		; 00
	POINTER Enemy@GoombaR		; 01
	POINTER Enemy@DeadGoomba	; 02
	POINTER Enemy@GoombaF		; 03
	POINTER Enemy@Default		; 04
	POINTER Enemy@Default		; 05
	POINTER Enemy@Koopa1Ra		; *06
	POINTER Enemy@Koopa2Ra		; *07
	POINTER Enemy@KoopaShell1c 	; 08
	POINTER Enemy@Koopa1Fa		; 09
	POINTER Enemy@Default		; *0A
	POINTER Enemy@Default		; *0B
	POINTER Enemy@Default		; *0C
	POINTER Enemy@Default		; 0D
	POINTER Enemy@KoopaShell2 	; 0E
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Enemy@Default		; 11
	POINTER Item@Platform		; 12
	POINTER Enemy@Default		; 13
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C
	POINTER Enemy@Default		; 1D
	POINTER Enemy@Default		; 1E
	POINTER Enemy@Default		; 1F
	POINTER Enemy@Stalactite	; 20
	POINTER Enemy@Default		; 21
	POINTER Item@MidPlatform	; 22
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Zombie1R		; *28
	POINTER Enemy@Zombie2R		; *29
	POINTER Enemy@Snake1R		; *2A
	POINTER Enemy@Snake2R		; *2B
	POINTER Enemy@ZombieDeadR	; 2C
	POINTER Enemy@ZombieDeadFR	; 2D
	POINTER Enemy@SnakeDeadR	; *2E
	POINTER Enemy@SnakeDeadF	; 2F
	POINTER Enemy@Default		; *30
	POINTER Enemy@BoulderR		; *31
	POINTER Enemy@CeilSpider1	; *32
	POINTER Enemy@CeilSpider2	; *33
	POINTER Enemy@Default		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C
	POINTER Enemy@Default		; 3D
	POINTER Enemy@RobotHead		; 3E	
	POINTER Enemy@Default		; 3F
	POINTER Enemy@RobotBody		; 40
	POINTER Enemy@Default		; 41
	POINTER Enemy@Default		; 42
	POINTER Enemy@Default		; 43
	POINTER Enemy@Default		; 44
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderFR		; 47
	POINTER Enemy@Default		; 48
	POINTER Enemy@Default		; 49
	POINTER Enemy@Default		; 4A
	POINTER Enemy@Default		; 4B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1a	; 51	; 
	POINTER Enemy@BulletBill2Ra	; *52	; 
	POINTER Enemy@BulletBill3Ra	; *53	; 
	POINTER Boss@Boulder1		; 54
	POINTER Boss@Boulder2		; 55
	POINTER Enemy@FireFlower1	; 56
	POINTER Enemy@FireFlower2	; 57
	POINTER Enemy@Default		; 58
	POINTER Enemy@Default		; 59
	POINTER Enemy@Default		; 5A
	POINTER Enemy@Default		; 5B
	POINTER Enemy@Default		; 5C
	POINTER Enemy@Default		; 5D
	POINTER Enemy@Default		; 5E
	POINTER Enemy@Piranha1F		; 5F	; 
	POINTER Enemy@Piranha2F		; 60
	POINTER Enemy@DeadlyStar1	; 61
	POINTER Enemy@DeadlyStar2	; 62
	POINTER Boss@Tatanga		; 63
	POINTER Boss@Ball			; 64
	POINTER Enemy@Fist			; 65
	POINTER Boss@Kinton1		; 66
	POINTER Boss@Kinton2		; 67
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69


 SprTable4b:
	POINTER Enemy@Goomba1		; 00
	POINTER Enemy@GoombaR1		; 01
	POINTER Enemy@DeadGoomba1	; 02
	POINTER Enemy@GoombaF1		; 03	; Goomba flipped
	POINTER Enemy@Piranha1d		; 04	; Piranha Plant closed mouth
	POINTER Enemy@Piranha2d		; 05	; Piranha Plant open mouth
	POINTER Enemy@Koopa1b		; 06
	POINTER Enemy@Koopa2b		; 07
	POINTER Enemy@KoopaShell1b	; 08
	POINTER Enemy@Koopa1Fb		; 09
	POINTER Enemy@Default		; 0A	; Part of the cloud?
	POINTER Enemy@Default		; 0B	; Cannon?
	POINTER Enemy@Default		; 0C	; Part of the cloud?
	POINTER Enemy@Default		; 0D	; ""
	POINTER Enemy@KoopaShell2 	; 0E	
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Item@Platform		; 11	; Apparently repeated?
	POINTER Item@Platform		; 12
	POINTER Item@EgyptPlatformAlt; 13	; Solid platform (Egypt) / DD+DE
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15	; Circular explosion 2
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18	; Light colored star
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C	; Coin 1. Unused?
	POINTER Enemy@Default		; 1D	; Coin 2 ""
	POINTER Enemy@Default		; 1E	; Coin 3 ""
	POINTER Item@Nothing		; 1F	; Nothing? It uses tile FE
	POINTER Enemy@Stalactite	; 20	; Stalactite 
	POINTER Item@Spring1			; 21	; Small platform (spring shaped)
	POINTER Item@MidPlatform	; 22	; Medium platform (two steps)
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26	
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Zombie1		; 28
	POINTER Enemy@Zombie2		; 29
	POINTER Enemy@Snake1		; 2A
	POINTER Enemy@Snake2		; 2B		
	POINTER Enemy@ZombieDead	; 2C
	POINTER Enemy@ZombieDeadF	; 2D
	POINTER Enemy@SnakeDead		; *2E	
	POINTER Enemy@SnakeDeadF	; 2F
	POINTER Enemy@Bee1			; *30
	POINTER Enemy@Plane			; *31
	POINTER Enemy@Chicken1	; *32
	POINTER Enemy@Chicken2	; *33
	POINTER Enemy@BeeDead		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37	
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C	; 
	POINTER Enemy@Default		; 3D	; 
	POINTER Enemy@RobotHead		; 3E	; Robot's head
	POINTER Enemy@Default		; 3F	; 
	POINTER Enemy@RobotBody		; 40	; Robot's body
	POINTER Enemy@Default		; 41	; 
	POINTER Enemy@Fishbone1		; 42	; Fishbone 1
	POINTER Enemy@Fishbone2		; 43	; Fishbone 2
	POINTER Enemy@BeeArrow		; 44	; Arrow down
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderF		; 47	; 
	POINTER Boss@Lion			; 48	; Lion Boss
	POINTER Boss@Lion2			; 49	; Lion Boss 2
	POINTER Boss@LionFire		; 4A	; Fireball A (lion's?)
	POINTER Boss@LionFire2		; 4B	; Fireball B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1b	; 51	; 
	POINTER Enemy@BulletBill2b	; 52	; 
	POINTER Enemy@BulletBill3b	; 53	; 
	POINTER Boss@Boulder1		; 54	; 
	POINTER Boss@Boulder2		; 55	; 
	POINTER Enemy@FireFlower1	; 56
	POINTER Enemy@FireFlower2	; 57
	POINTER Enemy@Default		; 58	; 
	POINTER Enemy@Default		; 59	; 
	POINTER Enemy@Default		; 5A	; 
	POINTER Enemy@Default		; 5B	; 
	POINTER Enemy@Default		; 5C	; 
	POINTER Enemy@Default		; 5D	; 
	POINTER Enemy@Default		; 5E	; 
	POINTER Enemy@Piranha1Fd		; 5F	; 
	POINTER Enemy@Piranha2Fd		; 60	; 
	POINTER Enemy@DeadlyStar1	; 61
	POINTER Enemy@DeadlyStar2	; 62	; 
	POINTER Boss@Tatanga		; 63
	POINTER Boss@Ball			; 64
	POINTER Enemy@Fist			; 65	; 
	POINTER Boss@Kinton1		; 66
	POINTER Boss@Kinton2		; 67
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69
	
 SprTableAlt4b:
	POINTER Enemy@Goomba1		; 00
	POINTER Enemy@GoombaR1		; 01
	POINTER Enemy@DeadGoomba1	; 02
	POINTER Enemy@GoombaF1		; 03
	POINTER Enemy@Default		; 04
	POINTER Enemy@Default		; 05
	POINTER Enemy@Koopa1Rb		; *06
	POINTER Enemy@Koopa2Rb		; *07
	POINTER Enemy@KoopaShell1b 	; 08
	POINTER Enemy@Koopa1Fb		; 09
	POINTER Enemy@Default		; *0A
	POINTER Enemy@Default		; *0B
	POINTER Enemy@Default		; *0C
	POINTER Enemy@Default		; 0D
	POINTER Enemy@KoopaShell2 	; 0E
	POINTER Enemy@Explosion1	; 0F
	POINTER Enemy@Explosion2	; 10
	POINTER Enemy@Default		; 11
	POINTER Item@Platform		; 12
	POINTER Enemy@Default		; 13
	POINTER Boss@Explosion1		; 14	; Circular explosion 1
	POINTER Boss@Explosion2		; 15
	POINTER Item@Mushroom		; 16
	POINTER Item@Heart			; 17
	POINTER Enemy@Default		; 18
	POINTER Item@Star			; 19
	POINTER Item@Flower			; 1A
	POINTER Item@FlowerAlt		; 1B
	POINTER Enemy@Default		; 1C
	POINTER Enemy@Default		; 1D
	POINTER Enemy@Default		; 1E
	POINTER Enemy@Default		; 1F
	POINTER Enemy@Stalactite	; 20
	POINTER Enemy@Default		; 21
	POINTER Item@MidPlatform	; 22
	POINTER Enemy@Totem1		; 23	; Totem 1
	POINTER Enemy@Totem2		; 24	; Totem 2
	POINTER Enemy@Totem3		; 25	; Totem 3
	POINTER Enemy@TotemDead		; 26
	POINTER Enemy@TotemDeadF	; 27
	POINTER Enemy@Zombie1R		; *28
	POINTER Enemy@Zombie2R		; *29
	POINTER Enemy@Snake1R		; *2A
	POINTER Enemy@Snake2R		; *2B
	POINTER Enemy@ZombieDeadR	; 2C
	POINTER Enemy@ZombieDeadFR	; 2D
	POINTER Enemy@SnakeDeadR	; *2E
	POINTER Enemy@SnakeDeadF	; 2F
	POINTER Enemy@Default		; *30
	POINTER Enemy@BoulderR		; *31
	POINTER Enemy@Chicken1	; *32
	POINTER Enemy@Chicken2	; *33
	POINTER Enemy@Default		; *34
	POINTER Enemy@BeeDeadF		; 35
	POINTER Enemy@CeilSpiderDead	; *36
	POINTER Enemy@CeilSpiderDeadF	; 37
	POINTER Enemy@Default		; 38
	POINTER Enemy@Default		; 39
	POINTER Enemy@Default		; 3A
	POINTER Enemy@Default		; *3B
	POINTER Enemy@Default		; 3C
	POINTER Enemy@Default		; 3D
	POINTER Enemy@RobotHead		; 3E	
	POINTER Enemy@Default		; 3F
	POINTER Enemy@RobotBody		; 40
	POINTER Enemy@Default		; 41
	POINTER Enemy@Default		; 42
	POINTER Enemy@Default		; 43
	POINTER Enemy@Default		; 44
	POINTER Enemy@FireBall		; 45
	POINTER Enemy@FireBall2		; 46
	POINTER Enemy@BoulderFR		; 47
	POINTER Enemy@Default		; 48
	POINTER Enemy@Default		; 49
	POINTER Enemy@Default		; 4A
	POINTER Enemy@Default		; 4B
	POINTER Boss@DragonFire1	; 4C	
	POINTER Boss@DragonFire2	; 4D
	POINTER Boss@Dragon			; 4E
	POINTER Boss@Dragon2		; 4F
	POINTER Enemy@Default		; 50 Platform?
	POINTER Enemy@BulletBill1b	; 51	; 
	POINTER Enemy@BulletBill2Rb	; *52	; 
	POINTER Enemy@BulletBill3Rb	; *53	; 
	POINTER Boss@Boulder1		; 54
	POINTER Boss@Boulder2		; 55
	POINTER Enemy@FireFlower1	; 56
	POINTER Enemy@FireFlower2	; 57
	POINTER Enemy@Default		; 58
	POINTER Enemy@Default		; 59
	POINTER Enemy@Default		; 5A
	POINTER Enemy@Default		; 5B
	POINTER Enemy@Default		; 5C
	POINTER Enemy@Default		; 5D
	POINTER Enemy@Default		; 5E
	POINTER Enemy@Piranha1Fd		; 5F	; 
	POINTER Enemy@Piranha2Fd		; 60
	POINTER Enemy@DeadlyStar1	; 61
	POINTER Enemy@DeadlyStar2	; 62
	POINTER Boss@Tatanga		; 63
	POINTER Boss@Ball			; 64
	POINTER Enemy@Fist			; 65
	POINTER Boss@Kinton1		; 66
	POINTER Boss@Kinton2		; 67
	POINTER Item@Elevator		; 68	; Elevator
	POINTER Enemy@Default		; 69

.ENDS
