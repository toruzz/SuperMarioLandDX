; This routine used to handle sprites in a very rudimentary way.
; It's been rewritten for flexibility.

.BANK BANK_SPRITES_OG SLOT 1
.ORGA $4000
.SECTION "SetSpriteOG" SEMIFREE
 SetSpriteOG:
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
	cp $14			; Max sprite size
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
.SECTION "Sprite Data OG" SEMIFREE
 EnemyO:
	@Default:					.db $00,$00,$6E,$01,END
	@Goomba:					.db $00,$00,$90,$05,END
	@GoombaR:					.db $00,$00,$90,$25,END
	@GoombaF:					.db $00,$00,$90,$45,END
	@DeadGoomba:				.db $00,$00,$91,$05,END
	
	@Goomba1:					.db $00,$00,$90,$07,END
	@GoombaR1:					.db $00,$00,$90,$27,END
	@GoombaF1:					.db $00,$00,$90,$47,END
	@DeadGoomba1:				.db $00,$00,$91,$07,END

	@Goomba2:					.db $00,$00,$90,$04,END
	@GoombaR2:					.db $00,$00,$90,$24,END
	@GoombaF2:					.db $00,$00,$90,$44,END
	@DeadGoomba2:				.db $00,$00,$91,$04,END

	@Piranha1:					.db $00,$00,$93,$04
								.db $F8,$00,$92,$04,END
	@Piranha2:					.db $00,$00,$95,$04
								.db $F8,$00,$94,$04,END

	@Piranha1b:					.db $00,$00,$93,$07
								.db $F8,$00,$92,$07,END
	@Piranha2b:					.db $00,$00,$95,$07
								.db $F8,$00,$94,$07,END

	@Koopa1b:					.db $00,$00,$97,$04
								.db $F8,$00,$96,$04,END
	@Koopa2b:					.db $00,$00,$99,$04
								.db $F8,$00,$98,$04,END
	@Koopa1Rb:					.db $00,$00,$97,$24
								.db $F8,$00,$96,$24,END
	@Koopa2Rb:					.db $00,$00,$99,$24
								.db $F8,$00,$98,$24,END
	@Koopa1Fb:					.db $00,$00,$97,$44
								.db $04,$FF,$96,$44,END
	@KoopaShell1b:				.db $00,$00,$9A,$04,END

	@Koopa1a:					.db $00,$00,$97,$05
								.db $F8,$00,$96,$05,END
	@Koopa2a:					.db $00,$00,$99,$05
								.db $F8,$00,$98,$05,END
	@Koopa1Ra:					.db $00,$00,$97,$25
								.db $F8,$00,$96,$25,END
	@Koopa2Ra:					.db $00,$00,$99,$25
								.db $F8,$00,$98,$25,END
	@Koopa1Fa:					.db $00,$00,$97,$45
								.db $04,$FF,$96,$45,END
	@KoopaShell1a:				.db $00,$00,$9A,$05,END

	@Koopa1:					.db $00,$00,$97,$06
								.db $F8,$00,$96,$06,END
	@Koopa2:					.db $00,$00,$99,$06
								.db $F8,$00,$98,$06,END
	@Koopa1R:					.db $00,$00,$97,$26
								.db $F8,$00,$96,$26,END
	@Koopa2R:					.db $00,$00,$99,$26
								.db $F8,$00,$98,$26,END
	@Koopa1F:					.db $00,$00,$97,$46
								.db $04,$FF,$96,$46,END
	@KoopaShell1:				.db $00,$00,$9A,$06,END
	@KoopaShell2:				.db $00,$00,$9B,$03,END




	@Explosion1:				.db $00,$00,$9D,$01
								.db $00,$08,$9D,$21,END
	@Explosion2:				.db $00,$00,$9E,$01
								.db $00,$08,$9E,$21,END

	@Fly1R:				
	@Fly1:						.db $01,$00,$B0,$04
								.db $01,$08,$B1,$04
								.db $F9,$00,$A0,$04
								.db $F9,$08,$A1,$04,END
	@Fly2R:				
	@Fly2:						.db $01,$00,$B2,$04
								.db $01,$08,$B3,$04
								.db $F9,$00,$A2,$04
								.db $F9,$08,$A3,$04,END

	@FlyDead:					.db $00,$00,$A8,$04
								.db $00,$08,$A9,$04,END
	@FlyDeadF:					.db $00,$00,$A8,$44
								.db $00,$08,$A9,$44,END

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

	@Bee1:						.db $00,$00,$D0,$04
								.db $00,$08,$D1,$07
								.db $F8,$00,$C0,$04
								.db $F8,$08,$C1,$04,END

	@Bee2:						.db $00,$00,$D2,$04
								.db $00,$08,$D3,$07
								.db $F8,$00,$C2,$04
								.db $F8,$08,$C3,$04,END

	@BeeArrow:					.db $00,$00,$BC,$04
								.db $F8,$00,$AC,$04,END

	@BeeDead:					.db $00,$00,$C8,$04
								.db $00,$08,$C9,$07,END

	@BeeDeadF:					.db $00,$00,$C8,$44
								.db $00,$08,$C9,$47,END




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


	@Fishbone1:					.db $00,$00,$D0,$07
								.db $F8,$00,$C0,$07,END

	@Fishbone2:					.db $00,$00,$D1,$07
								.db $F8,$00,$C1,$07,END


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
								.db $00,$08,$D9,$05,END

	@RobotDeadF:				.db $00,$00,$D8,$45
								.db $00,$08,$D9,$45,END


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
								.db $F9,$04,$26,$0B,END
	@Octopus2R:				
	@Octopus2:					.db $01,$00,$B2,$04
								.db $01,$08,$B3,$04
								.db $F9,$00,$A2,$04
								.db $F9,$08,$A3,$04
								.db $FA,$04,$26,$0B,END


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

	

	@Chicken1:					.db $00,$00,$D4,$04
								.db $00,$08,$D5,$04
								.db $F8,$00,$C4,$04
								.db $F8,$08,$C5,$04,END

	@Chicken2:					.db $00,$00,$D6,$04
								.db $00,$08,$D7,$04
								.db $F8,$00,$C6,$04
								.db $F8,$08,$C7,$04,END


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
								.db $F9,$08,$A1,$06,END
	
	@Zombie2:					.db $01,$00,$B2,$06
								.db $01,$08,$B3,$06
								.db $F9,$00,$A2,$06
								.db $F9,$08,$A3,$06,END

	@ZombieDead:				.db $00,$00,$A8,$06
								.db $00,$08,$A9,$06,END

	@ZombieDeadF:				.db $00,$00,$A8,$46
								.db $00,$08,$A9,$46,END

	@Zombie1R:					.db $01,$00,$B1,$26
								.db $01,$08,$B0,$26
								.db $F9,$00,$A1,$26
								.db $F9,$08,$A0,$26,END
	
	@Zombie2R:					.db $01,$00,$B3,$26
								.db $01,$08,$B2,$26
								.db $F9,$00,$A3,$26
								.db $F9,$08,$A2,$26,END

	@ZombieDeadR:				.db $00,$00,$A9,$26
								.db $00,$08,$A8,$26,END

	@ZombieDeadFR:				.db $00,$00,$A9,$66
								.db $00,$08,$A8,$66,END


	@Piranha1F:					.db $08,$00,$92,$64
								.db $00,$00,$93,$64,END
	@Piranha2F:					.db $08,$00,$94,$64
								.db $00,$00,$95,$64,END
	@Piranha1Fb:				.db $08,$00,$92,$67
								.db $00,$00,$93,$67,END
	@Piranha2Fb:				.db $08,$00,$94,$67
								.db $00,$00,$95,$67,END


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
								.db $00,$08,$B5,$06
								.db $F8,$00,$A4,$06
								
								.db $F8,$01,$87,$0C
								.db $00,$00,$88,$0C,END

	@Snake2:					.db $F8,$00,$A6,$06
								.db $F8,$08,$A7,$06
								.db $00,$00,$B6,$06
								.db $00,$08,$B7,$06

								.db $00,$02,$88,$0C,END

	@Snake1R:					.db $F8,$00,$A5,$26
								.db $F8,$08,$A4,$26
								.db $00,$00,$B5,$26
								.db $00,$08,$B4,$26

								.db $F8,$07,$87,$2C
								.db $00,$08,$88,$2C,END
								

	@Snake2R:					.db $F8,$00,$A7,$26
								.db $F8,$08,$A6,$26
								.db $00,$00,$B7,$26
								.db $00,$08,$B6,$26

								.db $00,$06,$88,$2C,END
								

	@SnakeDead:					.db $00,$00,$B8,$06
								.db $00,$08,$B9,$06,END

	@SnakeDeadR:				.db $00,$00,$B9,$26
								.db $00,$08,$B8,$26,END

	@SnakeDeadF:				.db $00,$00,$B8,$46
								.db $00,$08,$B9,$46,END

	@Plane:						.db $00,$00,$D2,$07
								.db $00,$08,$D3,$07
								.db $F8,$00,$C2,$07
								.db $F8,$08,$C3,$07,END

	@DeadlyStar1:				.db $00,$00,$D8,$04,END
	@DeadlyStar2:				.db $00,$00,$D9,$04,END


	@Fist:						.db $00,$00,$F2,$06
								.db $00,$08,$F3,$06
								.db $F8,$00,$F0,$06
								.db $F8,$08,$F1,$06,END





 BossO:
 	@Lion:						.db $00,$00,$DA,$06
								.db $00,$08,$DB,$06
								.db $00,$10,$DC,$06
								.db $F8,$00,$CA,$06
								.db $F8,$08,$CB,$06
								.db $F8,$10,$CC,$06
								.db $F8,$18,$BA,$06
								.db $F0,$00,$CD,$06
								.db $F0,$08,$CE,$06
								.db $F0,$00,$0D,$0B,END

	@Lion2:						.db $00,$00,$BB,$06
								.db $00,$08,$D6,$06
								.db $00,$10,$D7,$06
								.db $F8,$00,$AB,$06
								.db $F8,$08,$C6,$06
								.db $F8,$10,$C7,$06
								.db $F8,$18,$AA,$06
								.db $F0,$00,$CD,$06
								.db $F0,$08,$CE,$06
								.db $F0,$00,$0D,$0B,END

	@LionFire:					.db $00,$00,$C4,$05
								.db $00,$08,$C5,$05,END
	@LionFire2:					.db $00,$00,$D4,$05
								.db $00,$08,$D5,$05,END

	@Explosion1:				.db $00,$00,$9D,$43
								.db $00,$08,$9D,$63
								.db $F8,$00,$9D,$03
								.db $F8,$08,$9D,$23,END

	@Explosion2:				.db $00,$00,$9E,$43
								.db $00,$08,$9E,$63
								.db $F8,$00,$9E,$03
								.db $F8,$08,$9E,$23,END


	@Dragon:					.db $00,$00,$BC,$06
								.db $00,$08,$BD,$06
								.db $F8,$01,$CE,$06
								.db $F8,$09,$CF,$07
								.db $F0,$00,$BE,$06
								.db $F0,$08,$BF,$07
								.db $E8,$00,$AE,$06
								.db $E8,$08,$AF,$06,END

	@Dragon2:					.db $00,$00,$CC,$06
								.db $00,$08,$CD,$06
								.db $FA,$00,$DA,$07
								.db $F8,$08,$DB,$07
								.db $F2,$00,$CA,$06
								.db $F0,$08,$CB,$06
								.db $EA,$00,$BA,$06
								.db $E8,$08,$BB,$06,END

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
								
								.db $F0,$00,$AC,$07
								.db $F0,$08,$AD,$07
								.db $F0,$10,$AE,$05
								.db $F0,$18,$AF,$05
								
								.db $E8,$10,$CB,$05,END


	@Ball:						.db $00,$00,$BA,$04
								.db $00,$08,$BB,$04
								.db $F8,$00,$AA,$01
								.db $F8,$08,$AB,$04,END

 ItemO:
	@Default:					.db $00,$00,$6E,$01,END
	@Mushroom:					.db $00,$00,$83,$02,END
	@Heart:						.db $00,$00,$84,$01,END ; Original heart: .db $00,$00,$84,$00,END
	@Flower:					.db $00,$00,$E5,$82,END
	@FlowerAlt:					.db $00,$00,$E0,$82,END
	@Star:						.db $00,$00,$86,$03,END

	@Platform:					.db $00,$00,$EF,$01
								.db $00,$08,$EF,$01
								.db $00,$10,$EF,$01,END

	@Spring:					.db $00,$00,$EE,$84,END
	@Spring1:					.db $00,$00,$EE,$85,END
	@Spring1b:					.db $00,$00,$EE,$05,END
	@Spring2:					.db $00,$00,$EE,$87,END

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
.SECTION "Sprite Pointers OG" SEMIFREE
 SprTableO:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03	; Goomba flipped
	POINTER EnemyO@Piranha1		; 04	; Piranha Plant closed mouth
	POINTER EnemyO@Piranha2		; 05	; Piranha Plant open mouth
	POINTER EnemyO@Koopa1			; 06
	POINTER EnemyO@Koopa2			; 07
	POINTER EnemyO@KoopaShell1	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; 0A	; Part of the cloud?
	POINTER EnemyO@Default		; 0B	; Cannon?
	POINTER EnemyO@Default		; 0C	; Part of the cloud?
	POINTER EnemyO@Default		; 0D	; ""
	POINTER EnemyO@KoopaShell2 	; 0E	
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER ItemO@Platform		; 11	; Apparently repeated?
	POINTER ItemO@Platform		; 12
	POINTER ItemO@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15	; Circular explosion 2
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18	; Light colored star
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C	; Coin 1. Unused?
	POINTER EnemyO@Default		; 1D	; Coin 2 ""
	POINTER EnemyO@Default		; 1E	; Coin 3 ""
	POINTER ItemO@Nothing			; 1F	; Nothing? It uses tile FE
	POINTER EnemyO@Default		; 20	; Stalactite 
	POINTER ItemO@Spring	; 21	; Small platform (spring shaped)
	POINTER ItemO@MidPlatform		; 22	; Medium platform (two steps)
	POINTER EnemyO@Default		; 23	; No idea. Alternate gfx needed?
	POINTER EnemyO@Default		; 24	; No idea 2
	POINTER EnemyO@Default		; 25	; No idea 3
	POINTER EnemyO@Default		; 26	
	POINTER EnemyO@Default		; 27
	POINTER EnemyO@Fly1			; 28
	POINTER EnemyO@Fly2			; 29
	POINTER EnemyO@Sphynx1		; 2A
	POINTER EnemyO@Sphynx2		; 2B
	POINTER EnemyO@FlyDead		; 2C
	POINTER EnemyO@FlyDeadF		; 2D
	POINTER EnemyO@SphynxDead		; *2E	; SphynxDead, not sure if reversed or flipped
	POINTER EnemyO@SphynxDeadF	; 2F
	POINTER EnemyO@Bee1			; *30	; Bee	D0 D1 C0 C1
	POINTER EnemyO@Bee2			; *31	; Bee 2	D2 D3 C2 C3
	POINTER EnemyO@Default		; *32	; Two fires at the same time?
	POINTER EnemyO@Default		; *33	; Half lion
	POINTER EnemyO@BeeDead		; *34	; Dead Bee
	POINTER EnemyO@BeeDeadF		; 35	; Dead Bee flipped
	POINTER EnemyO@Default		; *36
	POINTER EnemyO@Default		; 37	
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C	; Lion's tail?
	POINTER EnemyO@Default		; 3D	; Lion's paw?
	POINTER EnemyO@Default		; 3E	; Lion's back?
	POINTER EnemyO@Default		; 3F	; Lion's back? flipped
	POINTER EnemyO@Default		; 40	; Lion something
	POINTER EnemyO@Default		; 41	; Lion something flipped
	POINTER EnemyO@Default		; 42	; Half bee?
	POINTER EnemyO@Default		; 43	; Other half bee
	POINTER EnemyO@BeeArrow		; 44	; Arrow down
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@Default		; 46
	POINTER EnemyO@Default		; 47	; Bee (not dead) flipped
	POINTER BossO@Lion			; 48	; Lion Boss
	POINTER BossO@Lion2			; 49	; Lion Boss 2
	POINTER BossO@LionFire		; 4A	; Fireball A (lion's?)
	POINTER BossO@LionFire2		; 4B	; Fireball B
	POINTER EnemyO@Default		; 4C	
	POINTER EnemyO@Default		; 4D
	POINTER EnemyO@Default		; 4E
	POINTER EnemyO@Default		; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@Default		; 51	; 
	POINTER EnemyO@Default		; 52	; 
	POINTER EnemyO@Default		; 53	; 
	POINTER EnemyO@Default		; 54	; 
	POINTER EnemyO@Default		; 55	; 
	POINTER EnemyO@Default		; 56	; 
	POINTER EnemyO@Default		; 57	; 
	POINTER EnemyO@Default		; 58	; 
	POINTER EnemyO@Default		; 59	; 
	POINTER EnemyO@Default		; 5A	; 
	POINTER EnemyO@Default		; 5B	; 
	POINTER EnemyO@Default		; 5C	; 
	POINTER EnemyO@Default		; 5D	; 
	POINTER EnemyO@Default		; 5E	; 
	POINTER EnemyO@Default		; 5F	; 
	POINTER EnemyO@Default		; 60	; 
	POINTER EnemyO@Default		; 61	; 
	POINTER EnemyO@Default		; 62	; 
	POINTER EnemyO@Default		; 63	; 
	POINTER EnemyO@Default		; 64	; 
	POINTER EnemyO@Default		; 65	; 
	POINTER EnemyO@Default		; 66	; 
	POINTER EnemyO@Default		; 67	; 
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69
	
 SprTableAltO:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03
	POINTER EnemyO@Default		; 04
	POINTER EnemyO@Default		; 05
	POINTER EnemyO@Koopa1R		; *06
	POINTER EnemyO@Koopa2R		; *07
	POINTER EnemyO@KoopaShell1 	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; *0A
	POINTER EnemyO@Default		; *0B
	POINTER EnemyO@Default		; *0C
	POINTER EnemyO@Default		; 0D
	POINTER EnemyO@KoopaShell2 	; 0E
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER EnemyO@Default		; 11
	POINTER ItemO@Platform		; 12
	POINTER EnemyO@Default		; 13
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C
	POINTER EnemyO@Default		; 1D
	POINTER EnemyO@Default		; 1E
	POINTER EnemyO@Default		; 1F
	POINTER EnemyO@Default		; 20
	POINTER EnemyO@Default		; 21
	POINTER EnemyO@Default		; 22
	POINTER EnemyO@Default		; 23
	POINTER EnemyO@Default		; 24
	POINTER EnemyO@Default		; 25
	POINTER EnemyO@Default		; 26
	POINTER EnemyO@Default		; 27
	POINTER EnemyO@Fly1R			; *28
	POINTER EnemyO@Fly2R			; *29
	POINTER EnemyO@Sphynx1R		; *2A
	POINTER EnemyO@Sphynx2R		; *2B
	POINTER EnemyO@FlyDead		; *2C
	POINTER EnemyO@FlyDeadF		; 2D
	POINTER EnemyO@SphynxDeadR	; *2E
	POINTER EnemyO@SphynxDeadF	; 2F
	POINTER EnemyO@Default		; *30
	POINTER EnemyO@Default		; *31
	POINTER EnemyO@Default		; *32
	POINTER EnemyO@Default		; *33
	POINTER EnemyO@Default		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@Default		; *36
	POINTER EnemyO@Default		; 37
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C
	POINTER EnemyO@Default		; 3D
	POINTER EnemyO@Default		; 3E
	POINTER EnemyO@Default		; 3F
	POINTER EnemyO@Default		; 40
	POINTER EnemyO@Default		; 41
	POINTER EnemyO@Default		; 42
	POINTER EnemyO@Default		; 43
	POINTER EnemyO@Default		; 44
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@Default		; 46
	POINTER EnemyO@Default		; 47
	POINTER EnemyO@Default		; 48
	POINTER EnemyO@Default		; 49
	POINTER EnemyO@Default		; 4A
	POINTER EnemyO@Default		; 4B
	POINTER EnemyO@Default		; 4C
	POINTER EnemyO@Default		; 4D
	POINTER EnemyO@Default		; 4E
	POINTER EnemyO@Default		; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@Default		; 51
	POINTER EnemyO@Default		; *52
	POINTER EnemyO@Default		; *53
	POINTER EnemyO@Default		; 54
	POINTER EnemyO@Default		; 55
	POINTER EnemyO@Default		; 56
	POINTER EnemyO@Default		; 57
	POINTER EnemyO@Default		; 58
	POINTER EnemyO@Default		; 59
	POINTER EnemyO@Default		; 5A
	POINTER EnemyO@Default		; 5B
	POINTER EnemyO@Default		; 5C
	POINTER EnemyO@Default		; 5D
	POINTER EnemyO@Default		; 5E
	POINTER EnemyO@Default		; 5F
	POINTER EnemyO@Default		; 60
	POINTER EnemyO@Default		; 61
	POINTER EnemyO@Default		; 62
	POINTER EnemyO@Default		; 63
	POINTER EnemyO@Default		; 64
	POINTER EnemyO@Default		; 65
	POINTER EnemyO@Default		; 66
	POINTER EnemyO@Default		; 67
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69

 SprTableOb:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03	; Goomba flipped
	POINTER EnemyO@Piranha1		; 04	; Piranha Plant closed mouth
	POINTER EnemyO@Piranha2		; 05	; Piranha Plant open mouth
	POINTER EnemyO@Koopa1			; 06
	POINTER EnemyO@Koopa2			; 07
	POINTER EnemyO@KoopaShell1	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; 0A	; Part of the cloud?
	POINTER EnemyO@Default		; 0B	; Cannon?
	POINTER EnemyO@Default		; 0C	; Part of the cloud?
	POINTER EnemyO@Default		; 0D	; ""
	POINTER EnemyO@KoopaShell2 	; 0E	
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER ItemO@Platform		; 11	; Apparently repeated?
	POINTER ItemO@Platform		; 12
	POINTER ItemO@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15	; Circular explosion 2
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18	; Light colored star
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C	; Coin 1. Unused?
	POINTER EnemyO@Default		; 1D	; Coin 2 ""
	POINTER EnemyO@Default		; 1E	; Coin 3 ""
	POINTER ItemO@Nothing			; 1F	; Nothing? It uses tile FE
	POINTER EnemyO@Default		; 20	; Stalactite 
	POINTER ItemO@Spring1	; 21	; Small platform (spring shaped)
	POINTER ItemO@MidPlatform		; 22	; Medium platform (two steps)
	POINTER EnemyO@Default		; 23	; No idea. Alternate gfx needed?
	POINTER EnemyO@Default		; 24	; No idea 2
	POINTER EnemyO@Default		; 25	; No idea 3
	POINTER EnemyO@Default		; 26	
	POINTER EnemyO@Default		; 27
	POINTER EnemyO@Fly1			; 28
	POINTER EnemyO@Fly2			; 29
	POINTER EnemyO@Sphynx1		; 2A
	POINTER EnemyO@Sphynx2		; 2B
	POINTER EnemyO@FlyDead		; 2C
	POINTER EnemyO@FlyDeadF		; 2D
	POINTER EnemyO@SphynxDead		; *2E	; SphynxDead, not sure if reversed or flipped
	POINTER EnemyO@SphynxDeadF	; 2F
	POINTER EnemyO@Bee1			; *30	; Bee	D0 D1 C0 C1
	POINTER EnemyO@Bee2			; *31	; Bee 2	D2 D3 C2 C3
	POINTER EnemyO@Default		; *32	; Two fires at the same time?
	POINTER EnemyO@Default		; *33	; Half lion
	POINTER EnemyO@BeeDead		; *34	; Dead Bee
	POINTER EnemyO@BeeDeadF		; 35	; Dead Bee flipped
	POINTER EnemyO@Default		; *36
	POINTER EnemyO@Default		; 37	
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C	; Lion's tail?
	POINTER EnemyO@Default		; 3D	; Lion's paw?
	POINTER EnemyO@Default		; 3E	; Lion's back?
	POINTER EnemyO@Default		; 3F	; Lion's back? flipped
	POINTER EnemyO@Default		; 40	; Lion something
	POINTER EnemyO@Default		; 41	; Lion something flipped
	POINTER EnemyO@Default		; 42	; Half bee?
	POINTER EnemyO@Default		; 43	; Other half bee
	POINTER EnemyO@BeeArrow		; 44	; Arrow down
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@Default		; 46
	POINTER EnemyO@Default		; 47	; Bee (not dead) flipped
	POINTER BossO@Lion			; 48	; Lion Boss
	POINTER BossO@Lion2			; 49	; Lion Boss 2
	POINTER BossO@LionFire		; 4A	; Fireball A (lion's?)
	POINTER BossO@LionFire2		; 4B	; Fireball B
	POINTER EnemyO@Default		; 4C	
	POINTER EnemyO@Default		; 4D
	POINTER EnemyO@Default		; 4E
	POINTER EnemyO@Default		; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@Default		; 51	; 
	POINTER EnemyO@Default		; 52	; 
	POINTER EnemyO@Default		; 53	; 
	POINTER EnemyO@Default		; 54	; 
	POINTER EnemyO@Default		; 55	; 
	POINTER EnemyO@Default		; 56	; 
	POINTER EnemyO@Default		; 57	; 
	POINTER EnemyO@Default		; 58	; 
	POINTER EnemyO@Default		; 59	; 
	POINTER EnemyO@Default		; 5A	; 
	POINTER EnemyO@Default		; 5B	; 
	POINTER EnemyO@Default		; 5C	; 
	POINTER EnemyO@Default		; 5D	; 
	POINTER EnemyO@Default		; 5E	; 
	POINTER EnemyO@Default		; 5F	; 
	POINTER EnemyO@Default		; 60	; 
	POINTER EnemyO@Default		; 61	; 
	POINTER EnemyO@Default		; 62	; 
	POINTER EnemyO@Default		; 63	; 
	POINTER EnemyO@Default		; 64	; 
	POINTER EnemyO@Default		; 65	; 
	POINTER EnemyO@Default		; 66	; 
	POINTER EnemyO@Default		; 67	; 
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69
	
 SprTableAltOb:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03
	POINTER EnemyO@Default		; 04
	POINTER EnemyO@Default		; 05
	POINTER EnemyO@Koopa1R		; *06
	POINTER EnemyO@Koopa2R		; *07
	POINTER EnemyO@KoopaShell1 	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; *0A
	POINTER EnemyO@Default		; *0B
	POINTER EnemyO@Default		; *0C
	POINTER EnemyO@Default		; 0D
	POINTER EnemyO@KoopaShell2 	; 0E
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER EnemyO@Default		; 11
	POINTER ItemO@Platform		; 12
	POINTER EnemyO@Default		; 13
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C
	POINTER EnemyO@Default		; 1D
	POINTER EnemyO@Default		; 1E
	POINTER EnemyO@Default		; 1F
	POINTER EnemyO@Default		; 20
	POINTER EnemyO@Default		; 21
	POINTER EnemyO@Default		; 22
	POINTER EnemyO@Default		; 23
	POINTER EnemyO@Default		; 24
	POINTER EnemyO@Default		; 25
	POINTER EnemyO@Default		; 26
	POINTER EnemyO@Default		; 27
	POINTER EnemyO@Fly1R			; *28
	POINTER EnemyO@Fly2R			; *29
	POINTER EnemyO@Sphynx1R		; *2A
	POINTER EnemyO@Sphynx2R		; *2B
	POINTER EnemyO@FlyDead		; *2C
	POINTER EnemyO@FlyDeadF		; 2D
	POINTER EnemyO@SphynxDeadR	; *2E
	POINTER EnemyO@SphynxDeadF	; 2F
	POINTER EnemyO@Default		; *30
	POINTER EnemyO@Default		; *31
	POINTER EnemyO@Default		; *32
	POINTER EnemyO@Default		; *33
	POINTER EnemyO@Default		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@Default		; *36
	POINTER EnemyO@Default		; 37
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C
	POINTER EnemyO@Default		; 3D
	POINTER EnemyO@Default		; 3E
	POINTER EnemyO@Default		; 3F
	POINTER EnemyO@Default		; 40
	POINTER EnemyO@Default		; 41
	POINTER EnemyO@Default		; 42
	POINTER EnemyO@Default		; 43
	POINTER EnemyO@Default		; 44
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@Default		; 46
	POINTER EnemyO@Default		; 47
	POINTER EnemyO@Default		; 48
	POINTER EnemyO@Default		; 49
	POINTER EnemyO@Default		; 4A
	POINTER EnemyO@Default		; 4B
	POINTER EnemyO@Default		; 4C
	POINTER EnemyO@Default		; 4D
	POINTER EnemyO@Default		; 4E
	POINTER EnemyO@Default		; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@Default		; 51
	POINTER EnemyO@Default		; *52
	POINTER EnemyO@Default		; *53
	POINTER EnemyO@Default		; 54
	POINTER EnemyO@Default		; 55
	POINTER EnemyO@Default		; 56
	POINTER EnemyO@Default		; 57
	POINTER EnemyO@Default		; 58
	POINTER EnemyO@Default		; 59
	POINTER EnemyO@Default		; 5A
	POINTER EnemyO@Default		; 5B
	POINTER EnemyO@Default		; 5C
	POINTER EnemyO@Default		; 5D
	POINTER EnemyO@Default		; 5E
	POINTER EnemyO@Default		; 5F
	POINTER EnemyO@Default		; 60
	POINTER EnemyO@Default		; 61
	POINTER EnemyO@Default		; 62
	POINTER EnemyO@Default		; 63
	POINTER EnemyO@Default		; 64
	POINTER EnemyO@Default		; 65
	POINTER EnemyO@Default		; 66
	POINTER EnemyO@Default		; 67
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69



 SprTable2O:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03	; Goomba flipped
	POINTER EnemyO@Piranha1		; 04	; Piranha Plant closed mouth
	POINTER EnemyO@Piranha2		; 05	; Piranha Plant open mouth
	POINTER EnemyO@Koopa1			; 06
	POINTER EnemyO@Koopa2			; 07
	POINTER EnemyO@KoopaShell1	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; 0A	; Part of the cloud?
	POINTER EnemyO@Default		; 0B	; Cannon?
	POINTER EnemyO@Default		; 0C	; Part of the cloud?
	POINTER EnemyO@Default		; 0D	; ""
	POINTER EnemyO@KoopaShell2 	; 0E	
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER ItemO@Platform		; 11	; Apparently repeated?
	POINTER ItemO@Platform		; 12
	POINTER ItemO@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15	; Circular explosion 2
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18	; Light colored star
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C	; Coin 1. Unused?
	POINTER EnemyO@Default		; 1D	; Coin 2 ""
	POINTER EnemyO@Default		; 1E	; Coin 3 ""
	POINTER ItemO@Nothing			; 1F	; Nothing? It uses tile FE
	POINTER EnemyO@Default		; 20	; Stalactite 
	POINTER ItemO@Spring	; 21	; Small platform (spring shaped)
	POINTER ItemO@MidPlatform		; 22	; Medium platform (two steps)
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26	
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Octopus1		; 28
	POINTER EnemyO@Octopus2		; 29
	POINTER EnemyO@Seahorse1		; 2A
	POINTER EnemyO@Seahorse2		; 2B		
	POINTER EnemyO@Fish1		; 2C
	POINTER EnemyO@FlyDeadF		; 2D
	POINTER EnemyO@Fish2		; *2E	; SphynxDead, not sure if reversed or flipped
	POINTER EnemyO@SphynxDeadF	; 2F
	POINTER EnemyO@Bee1			; *30	; Bee	D0 D1 C0 C1
	POINTER EnemyO@Bee2			; *31	; Bee 2	D2 D3 C2 C3
	POINTER EnemyO@Robot1			; *32	; Robot 1
	POINTER EnemyO@Robot2			; *33	; Robot 2
	POINTER EnemyO@BeeDead		; *34	; Dead Bee
	POINTER EnemyO@BeeDeadF		; 35	; Dead Bee flipped
	POINTER EnemyO@RobotDead		; *36
	POINTER EnemyO@RobotDeadF		; 37	
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C	; 
	POINTER EnemyO@Default		; 3D	; 
	POINTER EnemyO@RobotHead		; 3E	; Robot's head
	POINTER EnemyO@Default		; 3F	; 
	POINTER EnemyO@RobotBody		; 40	; Robot's body
	POINTER EnemyO@Default		; 41	; 
	POINTER EnemyO@Fishbone1		; 42	; Fishbone 1
	POINTER EnemyO@Fishbone2		; 43	; Fishbone 2
	POINTER EnemyO@BeeArrow		; 44	; Arrow down
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@Default		; 47	; Bee (not dead) flipped
	POINTER BossO@Lion			; 48	; Lion Boss
	POINTER BossO@Lion2			; 49	; Lion Boss 2
	POINTER BossO@LionFire		; 4A	; Fireball A (lion's?)
	POINTER BossO@LionFire2		; 4B	; Fireball B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2	; 52	; 
	POINTER EnemyO@BulletBill3	; 53	; 
	POINTER EnemyO@Default		; 54	; 
	POINTER EnemyO@Default		; 55	; 
	POINTER EnemyO@Default		; 56	; 
	POINTER EnemyO@Default		; 57	; 
	POINTER EnemyO@Default		; 58	; 
	POINTER EnemyO@Default		; 59	; 
	POINTER EnemyO@Default		; 5A	; 
	POINTER EnemyO@Default		; 5B	; 
	POINTER EnemyO@Default		; 5C	; 
	POINTER EnemyO@Default		; 5D	; 
	POINTER EnemyO@Default		; 5E	; 
	POINTER EnemyO@Default		; 5F	; 
	POINTER EnemyO@Default		; 60	; 
	POINTER EnemyO@Default		; 61	; 
	POINTER EnemyO@Default		; 62	; 
	POINTER EnemyO@Default		; 63	; 
	POINTER EnemyO@Default		; 64	; 
	POINTER EnemyO@Default		; 65	; 
	POINTER EnemyO@Default		; 66	; 
	POINTER EnemyO@Default		; 67	; 
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69
	
 SprTableAlt2O:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03
	POINTER EnemyO@Default		; 04
	POINTER EnemyO@Default		; 05
	POINTER EnemyO@Koopa1R		; *06
	POINTER EnemyO@Koopa2R		; *07
	POINTER EnemyO@KoopaShell1 	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; *0A
	POINTER EnemyO@Default		; *0B
	POINTER EnemyO@Default		; *0C
	POINTER EnemyO@Default		; 0D
	POINTER EnemyO@KoopaShell2 	; 0E
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER EnemyO@Default		; 11
	POINTER ItemO@Platform		; 12
	POINTER EnemyO@Default		; 13
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C
	POINTER EnemyO@Default		; 1D
	POINTER EnemyO@Default		; 1E
	POINTER EnemyO@Default		; 1F
	POINTER EnemyO@Default		; 20
	POINTER EnemyO@Default		; 21
	POINTER EnemyO@Default		; 22
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Octopus1R		; *28
	POINTER EnemyO@Octopus2R		; *29
	POINTER EnemyO@Seahorse1R		; *2A
	POINTER EnemyO@Seahorse2R		; *2B
	POINTER EnemyO@Fish1R			; *2C
	POINTER EnemyO@FlyDeadF		; 2D
	POINTER EnemyO@Fish2R			; *2E
	POINTER EnemyO@SphynxDeadF	; 2F
	POINTER EnemyO@Default		; *30
	POINTER EnemyO@Default		; *31
	POINTER EnemyO@Robot1			; *32
	POINTER EnemyO@Robot2			; *33
	POINTER EnemyO@Default		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@RobotDead		; *36
	POINTER EnemyO@RobotDeadF		; 37
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C
	POINTER EnemyO@Default		; 3D
	POINTER EnemyO@RobotHead		; 3E	
	POINTER EnemyO@Default		; 3F
	POINTER EnemyO@RobotBody		; 40
	POINTER EnemyO@Default		; 41
	POINTER EnemyO@Default		; 42
	POINTER EnemyO@Default		; 43
	POINTER EnemyO@Default		; 44
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@Default		; 47
	POINTER EnemyO@Default		; 48
	POINTER EnemyO@Default		; 49
	POINTER EnemyO@Default		; 4A
	POINTER EnemyO@Default		; 4B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2R	; *52	; 
	POINTER EnemyO@BulletBill3R	; *53	; 
	POINTER EnemyO@Default		; 54
	POINTER EnemyO@Default		; 55
	POINTER EnemyO@Default		; 56
	POINTER EnemyO@Default		; 57
	POINTER EnemyO@Default		; 58
	POINTER EnemyO@Default		; 59
	POINTER EnemyO@Default		; 5A
	POINTER EnemyO@Default		; 5B
	POINTER EnemyO@Default		; 5C
	POINTER EnemyO@Default		; 5D
	POINTER EnemyO@Default		; 5E
	POINTER EnemyO@Default		; 5F
	POINTER EnemyO@Default		; 60
	POINTER EnemyO@Default		; 61
	POINTER EnemyO@Default		; 62
	POINTER EnemyO@Default		; 63
	POINTER EnemyO@Default		; 64
	POINTER EnemyO@Default		; 65
	POINTER EnemyO@Default		; 66
	POINTER EnemyO@Default		; 67
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69



 SprTable3O:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03	; Goomba flipped
	POINTER EnemyO@Piranha1		; 04	; Piranha Plant closed mouth
	POINTER EnemyO@Piranha2		; 05	; Piranha Plant open mouth
	POINTER EnemyO@Koopa1			; 06
	POINTER EnemyO@Koopa2			; 07
	POINTER EnemyO@KoopaShell1	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; 0A	; Part of the cloud?
	POINTER EnemyO@Default		; 0B	; Cannon?
	POINTER EnemyO@Default		; 0C	; Part of the cloud?
	POINTER EnemyO@Default		; 0D	; ""
	POINTER EnemyO@KoopaShell2 	; 0E	
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER ItemO@Platform		; 11	; Apparently repeated?
	POINTER ItemO@Platform		; 12
	POINTER ItemO@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15	; Circular explosion 2
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18	; Light colored star
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C	; Coin 1. Unused?
	POINTER EnemyO@Default		; 1D	; Coin 2 ""
	POINTER EnemyO@Default		; 1E	; Coin 3 ""
	POINTER ItemO@Nothing			; 1F	; Nothing? It uses tile FE
	POINTER EnemyO@Stalactite		; 20	; Stalactite 
	POINTER ItemO@Spring	; 21	; Small platform (spring shaped)
	POINTER ItemO@MidPlatform		; 22	; Medium platform (two steps)
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26	
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Spider1		; 28
	POINTER EnemyO@Spider2		; 29
	POINTER EnemyO@Tokoto1		; 2A
	POINTER EnemyO@Tokoto2		; 2B		
	POINTER EnemyO@SpiderDead		; 2C
	POINTER EnemyO@SpiderDeadF	; 2D
	POINTER EnemyO@TokotoDead		; *2E	
	POINTER EnemyO@TokotoDeadF	; 2F
	POINTER EnemyO@Bee1			; *30
	POINTER EnemyO@Boulder		; *31
	POINTER EnemyO@CeilSpider1	; *32
	POINTER EnemyO@CeilSpider2	; *33
	POINTER EnemyO@BeeDead		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37	
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C	; 
	POINTER EnemyO@Default		; 3D	; 
	POINTER EnemyO@RobotHead		; 3E	; Robot's head
	POINTER EnemyO@Default		; 3F	; 
	POINTER EnemyO@RobotBody		; 40	; Robot's body
	POINTER EnemyO@Default		; 41	; 
	POINTER EnemyO@Fishbone1		; 42	; Fishbone 1
	POINTER EnemyO@Fishbone2		; 43	; Fishbone 2
	POINTER EnemyO@BeeArrow		; 44	; Arrow down
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderF		; 47	; 
	POINTER BossO@Lion			; 48	; Lion Boss
	POINTER BossO@Lion2			; 49	; Lion Boss 2
	POINTER BossO@LionFire		; 4A	; Fireball A (lion's?)
	POINTER BossO@LionFire2		; 4B	; Fireball B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2	; 52	; 
	POINTER EnemyO@BulletBill3	; 53	; 
	POINTER BossO@Boulder1		; 54	; 
	POINTER BossO@Boulder2		; 55	; 
	POINTER EnemyO@Default		; 56	; 
	POINTER EnemyO@Default		; 57	; 
	POINTER EnemyO@Default		; 58	; 
	POINTER EnemyO@Default		; 59	; 
	POINTER EnemyO@Default		; 5A	; 
	POINTER EnemyO@Default		; 5B	; 
	POINTER EnemyO@Default		; 5C	; 
	POINTER EnemyO@Default		; 5D	; 
	POINTER EnemyO@Default		; 5E	; 
	POINTER EnemyO@Default		; 5F	; 
	POINTER EnemyO@Default		; 60	; 
	POINTER EnemyO@Default		; 61	; 
	POINTER EnemyO@Default		; 62	; 
	POINTER EnemyO@Default		; 63	; 
	POINTER EnemyO@Default		; 64	; 
	POINTER EnemyO@Default		; 65	; 
	POINTER EnemyO@Default		; 66	; 
	POINTER EnemyO@Default		; 67	; 
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69
	
 SprTableAlt3O:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03
	POINTER EnemyO@Default		; 04
	POINTER EnemyO@Default		; 05
	POINTER EnemyO@Koopa1R		; *06
	POINTER EnemyO@Koopa2R		; *07
	POINTER EnemyO@KoopaShell1 	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; *0A
	POINTER EnemyO@Default		; *0B
	POINTER EnemyO@Default		; *0C
	POINTER EnemyO@Default		; 0D
	POINTER EnemyO@KoopaShell2 	; 0E
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER EnemyO@Default		; 11
	POINTER ItemO@Platform		; 12
	POINTER EnemyO@Default		; 13
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C
	POINTER EnemyO@Default		; 1D
	POINTER EnemyO@Default		; 1E
	POINTER EnemyO@Default		; 1F
	POINTER EnemyO@Stalactite		; 20
	POINTER EnemyO@Default		; 21
	POINTER ItemO@MidPlatform		; 22
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Spider1		; *28
	POINTER EnemyO@Spider2		; *29
	POINTER EnemyO@Tokoto1R		; *2A
	POINTER EnemyO@Tokoto2R		; *2B
	POINTER EnemyO@SpiderDead		; 2C
	POINTER EnemyO@SpiderDeadF	; 2D
	POINTER EnemyO@TokotoDeadR	; *2E
	POINTER EnemyO@TokotoDeadF	; 2F
	POINTER EnemyO@Default		; *30
	POINTER EnemyO@BoulderR		; *31
	POINTER EnemyO@CeilSpider1	; *32
	POINTER EnemyO@CeilSpider2	; *33
	POINTER EnemyO@Default		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C
	POINTER EnemyO@Default		; 3D
	POINTER EnemyO@RobotHead		; 3E	
	POINTER EnemyO@Default		; 3F
	POINTER EnemyO@RobotBody		; 40
	POINTER EnemyO@Default		; 41
	POINTER EnemyO@Default		; 42
	POINTER EnemyO@Default		; 43
	POINTER EnemyO@Default		; 44
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderFR		; 47
	POINTER EnemyO@Default		; 48
	POINTER EnemyO@Default		; 49
	POINTER EnemyO@Default		; 4A
	POINTER EnemyO@Default		; 4B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2R	; *52	; 
	POINTER EnemyO@BulletBill3R	; *53	; 
	POINTER BossO@Boulder1		; 54
	POINTER BossO@Boulder2			; 55
	POINTER EnemyO@Default		; 56
	POINTER EnemyO@Default		; 57
	POINTER EnemyO@Default		; 58
	POINTER EnemyO@Default		; 59
	POINTER EnemyO@Default		; 5A
	POINTER EnemyO@Default		; 5B
	POINTER EnemyO@Default		; 5C
	POINTER EnemyO@Default		; 5D
	POINTER EnemyO@Default		; 5E
	POINTER EnemyO@Default		; 5F
	POINTER EnemyO@Default		; 60
	POINTER EnemyO@Default		; 61
	POINTER EnemyO@Default		; 62
	POINTER EnemyO@Default		; 63
	POINTER EnemyO@Default		; 64
	POINTER EnemyO@Default		; 65
	POINTER EnemyO@Default		; 66
	POINTER EnemyO@Default		; 67
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69

 SprTable3Ob:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03	; Goomba flipped
	POINTER EnemyO@Piranha1		; 04	; Piranha Plant closed mouth
	POINTER EnemyO@Piranha2		; 05	; Piranha Plant open mouth
	POINTER EnemyO@Koopa1			; 06
	POINTER EnemyO@Koopa2			; 07
	POINTER EnemyO@KoopaShell1	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; 0A	; Part of the cloud?
	POINTER EnemyO@Default		; 0B	; Cannon?
	POINTER EnemyO@Default		; 0C	; Part of the cloud?
	POINTER EnemyO@Default		; 0D	; ""
	POINTER EnemyO@KoopaShell2 	; 0E	
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER ItemO@Platform		; 11	; Apparently repeated?
	POINTER ItemO@Platform		; 12
	POINTER ItemO@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15	; Circular explosion 2
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18	; Light colored star
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C	; Coin 1. Unused?
	POINTER EnemyO@Default		; 1D	; Coin 2 ""
	POINTER EnemyO@Default		; 1E	; Coin 3 ""
	POINTER ItemO@Nothing			; 1F	; Nothing? It uses tile FE
	POINTER EnemyO@Stalactite		; 20	; Stalactite 
	POINTER ItemO@Spring1b	; 21	; Small platform (spring shaped)
	POINTER ItemO@MidPlatform		; 22	; Medium platform (two steps)
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26	
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Spider1		; 28
	POINTER EnemyO@Spider2		; 29
	POINTER EnemyO@Tokoto1		; 2A
	POINTER EnemyO@Tokoto2		; 2B		
	POINTER EnemyO@SpiderDead		; 2C
	POINTER EnemyO@SpiderDeadF	; 2D
	POINTER EnemyO@TokotoDead		; *2E	
	POINTER EnemyO@TokotoDeadF	; 2F
	POINTER EnemyO@Bee1			; *30
	POINTER EnemyO@Boulder1		; *31
	POINTER EnemyO@CeilSpider1	; *32
	POINTER EnemyO@CeilSpider2	; *33
	POINTER EnemyO@BeeDead		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37	
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C	; 
	POINTER EnemyO@Default		; 3D	; 
	POINTER EnemyO@RobotHead		; 3E	; Robot's head
	POINTER EnemyO@Default		; 3F	; 
	POINTER EnemyO@RobotBody		; 40	; Robot's body
	POINTER EnemyO@Default		; 41	; 
	POINTER EnemyO@Fishbone1		; 42	; Fishbone 1
	POINTER EnemyO@Fishbone2		; 43	; Fishbone 2
	POINTER EnemyO@BeeArrow		; 44	; Arrow down
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderF1		; 47	; 
	POINTER BossO@Lion			; 48	; Lion Boss
	POINTER BossO@Lion2			; 49	; Lion Boss 2
	POINTER BossO@LionFire		; 4A	; Fireball A (lion's?)
	POINTER BossO@LionFire2		; 4B	; Fireball B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2	; 52	; 
	POINTER EnemyO@BulletBill3	; 53	; 
	POINTER BossO@Boulder1		; 54	; 
	POINTER BossO@Boulder2		; 55	; 
	POINTER EnemyO@Default		; 56	; 
	POINTER EnemyO@Default		; 57	; 
	POINTER EnemyO@Default		; 58	; 
	POINTER EnemyO@Default		; 59	; 
	POINTER EnemyO@Default		; 5A	; 
	POINTER EnemyO@Default		; 5B	; 
	POINTER EnemyO@Default		; 5C	; 
	POINTER EnemyO@Default		; 5D	; 
	POINTER EnemyO@Default		; 5E	; 
	POINTER EnemyO@Default		; 5F	; 
	POINTER EnemyO@Default		; 60	; 
	POINTER EnemyO@Default		; 61	; 
	POINTER EnemyO@Default		; 62	; 
	POINTER EnemyO@Default		; 63	; 
	POINTER EnemyO@Default		; 64	; 
	POINTER EnemyO@Default		; 65	; 
	POINTER EnemyO@Default		; 66	; 
	POINTER EnemyO@Default		; 67	; 
	POINTER ItemO@Elevator1		; 68	; Elevator
	POINTER EnemyO@Default		; 69
	
 SprTableAlt3Ob:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03
	POINTER EnemyO@Default		; 04
	POINTER EnemyO@Default		; 05
	POINTER EnemyO@Koopa1R		; *06
	POINTER EnemyO@Koopa2R		; *07
	POINTER EnemyO@KoopaShell1 	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; *0A
	POINTER EnemyO@Default		; *0B
	POINTER EnemyO@Default		; *0C
	POINTER EnemyO@Default		; 0D
	POINTER EnemyO@KoopaShell2 	; 0E
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER EnemyO@Default		; 11
	POINTER ItemO@Platform		; 12
	POINTER EnemyO@Default		; 13
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C
	POINTER EnemyO@Default		; 1D
	POINTER EnemyO@Default		; 1E
	POINTER EnemyO@Default		; 1F
	POINTER EnemyO@Stalactite		; 20
	POINTER EnemyO@Default		; 21
	POINTER ItemO@MidPlatform		; 22
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Spider1		; *28
	POINTER EnemyO@Spider2		; *29
	POINTER EnemyO@Tokoto1R		; *2A
	POINTER EnemyO@Tokoto2R		; *2B
	POINTER EnemyO@SpiderDead		; 2C
	POINTER EnemyO@SpiderDeadF	; 2D
	POINTER EnemyO@TokotoDeadR	; *2E
	POINTER EnemyO@TokotoDeadF	; 2F
	POINTER EnemyO@Default		; *30
	POINTER EnemyO@BoulderR1	; *31
	POINTER EnemyO@CeilSpider1	; *32
	POINTER EnemyO@CeilSpider2	; *33
	POINTER EnemyO@Default		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C
	POINTER EnemyO@Default		; 3D
	POINTER EnemyO@RobotHead		; 3E	
	POINTER EnemyO@Default		; 3F
	POINTER EnemyO@RobotBody		; 40
	POINTER EnemyO@Default		; 41
	POINTER EnemyO@Default		; 42
	POINTER EnemyO@Default		; 43
	POINTER EnemyO@Default		; 44
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderFR1		; 47
	POINTER EnemyO@Default		; 48
	POINTER EnemyO@Default		; 49
	POINTER EnemyO@Default		; 4A
	POINTER EnemyO@Default		; 4B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2R	; *52	; 
	POINTER EnemyO@BulletBill3R	; *53	; 
	POINTER BossO@Boulder1		; 54
	POINTER BossO@Boulder2			; 55
	POINTER EnemyO@Default		; 56
	POINTER EnemyO@Default		; 57
	POINTER EnemyO@Default		; 58
	POINTER EnemyO@Default		; 59
	POINTER EnemyO@Default		; 5A
	POINTER EnemyO@Default		; 5B
	POINTER EnemyO@Default		; 5C
	POINTER EnemyO@Default		; 5D
	POINTER EnemyO@Default		; 5E
	POINTER EnemyO@Default		; 5F
	POINTER EnemyO@Default		; 60
	POINTER EnemyO@Default		; 61
	POINTER EnemyO@Default		; 62
	POINTER EnemyO@Default		; 63
	POINTER EnemyO@Default		; 64
	POINTER EnemyO@Default		; 65
	POINTER EnemyO@Default		; 66
	POINTER EnemyO@Default		; 67
	POINTER ItemO@Elevator1		; 68	; Elevator
	POINTER EnemyO@Default		; 69

 SprTable3Oc:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03	; Goomba flipped
	POINTER EnemyO@Piranha1		; 04	; Piranha Plant closed mouth
	POINTER EnemyO@Piranha2		; 05	; Piranha Plant open mouth
	POINTER EnemyO@Koopa1			; 06
	POINTER EnemyO@Koopa2			; 07
	POINTER EnemyO@KoopaShell1	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; 0A	; Part of the cloud?
	POINTER EnemyO@Default		; 0B	; Cannon?
	POINTER EnemyO@Default		; 0C	; Part of the cloud?
	POINTER EnemyO@Default		; 0D	; ""
	POINTER EnemyO@KoopaShell2 	; 0E	
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER ItemO@Platform		; 11	; Apparently repeated?
	POINTER ItemO@Platform		; 12
	POINTER ItemO@EgyptPlatform	; 13	; Solid platform (Egypt) / DD+DE
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15	; Circular explosion 2
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18	; Light colored star
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C	; Coin 1. Unused?
	POINTER EnemyO@Default		; 1D	; Coin 2 ""
	POINTER EnemyO@Default		; 1E	; Coin 3 ""
	POINTER ItemO@Nothing			; 1F	; Nothing? It uses tile FE
	POINTER EnemyO@Stalactite		; 20	; Stalactite 
	POINTER ItemO@Spring2	; 21	; Small platform (spring shaped)
	POINTER ItemO@MidPlatform		; 22	; Medium platform (two steps)
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26	
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Spider1		; 28
	POINTER EnemyO@Spider2		; 29
	POINTER EnemyO@Tokoto1		; 2A
	POINTER EnemyO@Tokoto2		; 2B		
	POINTER EnemyO@SpiderDead		; 2C
	POINTER EnemyO@SpiderDeadF	; 2D
	POINTER EnemyO@TokotoDead		; *2E	
	POINTER EnemyO@TokotoDeadF	; 2F
	POINTER EnemyO@Bee1			; *30
	POINTER EnemyO@Boulder		; *31
	POINTER EnemyO@CeilSpider1	; *32
	POINTER EnemyO@CeilSpider2	; *33
	POINTER EnemyO@BeeDead		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37	
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C	; 
	POINTER EnemyO@Default		; 3D	; 
	POINTER EnemyO@RobotHead		; 3E	; Robot's head
	POINTER EnemyO@Default		; 3F	; 
	POINTER EnemyO@RobotBody		; 40	; Robot's body
	POINTER EnemyO@Default		; 41	; 
	POINTER EnemyO@Fishbone1		; 42	; Fishbone 1
	POINTER EnemyO@Fishbone2		; 43	; Fishbone 2
	POINTER EnemyO@BeeArrow		; 44	; Arrow down
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderF		; 47	; 
	POINTER BossO@Lion			; 48	; Lion Boss
	POINTER BossO@Lion2			; 49	; Lion Boss 2
	POINTER BossO@LionFire		; 4A	; Fireball A (lion's?)
	POINTER BossO@LionFire2		; 4B	; Fireball B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2	; 52	; 
	POINTER EnemyO@BulletBill3	; 53	; 
	POINTER BossO@Boulder1		; 54	; 
	POINTER BossO@Boulder2		; 55	; 
	POINTER EnemyO@Default		; 56	; 
	POINTER EnemyO@Default		; 57	; 
	POINTER EnemyO@Default		; 58	; 
	POINTER EnemyO@Default		; 59	; 
	POINTER EnemyO@Default		; 5A	; 
	POINTER EnemyO@Default		; 5B	; 
	POINTER EnemyO@Default		; 5C	; 
	POINTER EnemyO@Default		; 5D	; 
	POINTER EnemyO@Default		; 5E	; 
	POINTER EnemyO@Default		; 5F	; 
	POINTER EnemyO@Default		; 60	; 
	POINTER EnemyO@Default		; 61	; 
	POINTER EnemyO@Default		; 62	; 
	POINTER EnemyO@Default		; 63	; 
	POINTER EnemyO@Default		; 64	; 
	POINTER EnemyO@Default		; 65	; 
	POINTER EnemyO@Default		; 66	; 
	POINTER EnemyO@Default		; 67	; 
	POINTER ItemO@Elevator1		; 68	; Elevator
	POINTER EnemyO@Default		; 69
	
 SprTableAlt3Oc:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03
	POINTER EnemyO@Default		; 04
	POINTER EnemyO@Default		; 05
	POINTER EnemyO@Koopa1R		; *06
	POINTER EnemyO@Koopa2R		; *07
	POINTER EnemyO@KoopaShell1 	; 08
	POINTER EnemyO@Koopa1F		; 09
	POINTER EnemyO@Default		; *0A
	POINTER EnemyO@Default		; *0B
	POINTER EnemyO@Default		; *0C
	POINTER EnemyO@Default		; 0D
	POINTER EnemyO@KoopaShell2 	; 0E
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER EnemyO@Default		; 11
	POINTER ItemO@Platform		; 12
	POINTER EnemyO@Default		; 13
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C
	POINTER EnemyO@Default		; 1D
	POINTER EnemyO@Default		; 1E
	POINTER EnemyO@Default		; 1F
	POINTER EnemyO@Stalactite		; 20
	POINTER EnemyO@Default		; 21
	POINTER ItemO@MidPlatform		; 22
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Spider1		; *28
	POINTER EnemyO@Spider2		; *29
	POINTER EnemyO@Tokoto1R		; *2A
	POINTER EnemyO@Tokoto2R		; *2B
	POINTER EnemyO@SpiderDead		; 2C
	POINTER EnemyO@SpiderDeadF	; 2D
	POINTER EnemyO@TokotoDeadR	; *2E
	POINTER EnemyO@TokotoDeadF	; 2F
	POINTER EnemyO@Default		; *30
	POINTER EnemyO@BoulderR	; *31
	POINTER EnemyO@CeilSpider1	; *32
	POINTER EnemyO@CeilSpider2	; *33
	POINTER EnemyO@Default		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C
	POINTER EnemyO@Default		; 3D
	POINTER EnemyO@RobotHead		; 3E	
	POINTER EnemyO@Default		; 3F
	POINTER EnemyO@RobotBody		; 40
	POINTER EnemyO@Default		; 41
	POINTER EnemyO@Default		; 42
	POINTER EnemyO@Default		; 43
	POINTER EnemyO@Default		; 44
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderFR		; 47
	POINTER EnemyO@Default		; 48
	POINTER EnemyO@Default		; 49
	POINTER EnemyO@Default		; 4A
	POINTER EnemyO@Default		; 4B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2R	; *52	; 
	POINTER EnemyO@BulletBill3R	; *53	; 
	POINTER BossO@Boulder1		; 54
	POINTER BossO@Boulder2			; 55
	POINTER EnemyO@Default		; 56
	POINTER EnemyO@Default		; 57
	POINTER EnemyO@Default		; 58
	POINTER EnemyO@Default		; 59
	POINTER EnemyO@Default		; 5A
	POINTER EnemyO@Default		; 5B
	POINTER EnemyO@Default		; 5C
	POINTER EnemyO@Default		; 5D
	POINTER EnemyO@Default		; 5E
	POINTER EnemyO@Default		; 5F
	POINTER EnemyO@Default		; 60
	POINTER EnemyO@Default		; 61
	POINTER EnemyO@Default		; 62
	POINTER EnemyO@Default		; 63
	POINTER EnemyO@Default		; 64
	POINTER EnemyO@Default		; 65
	POINTER EnemyO@Default		; 66
	POINTER EnemyO@Default		; 67
	POINTER ItemO@Elevator1		; 68	; Elevator
	POINTER EnemyO@Default		; 69



 SprTable4O:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03	; Goomba flipped
	POINTER EnemyO@Piranha1		; 04	; Piranha Plant closed mouth
	POINTER EnemyO@Piranha2		; 05	; Piranha Plant open mouth
	POINTER EnemyO@Koopa1a			; 06
	POINTER EnemyO@Koopa2a			; 07
	POINTER EnemyO@KoopaShell1a	; 08
	POINTER EnemyO@Koopa1Fa		; 09
	POINTER EnemyO@Default		; 0A	; Part of the cloud?
	POINTER EnemyO@Default		; 0B	; Cannon?
	POINTER EnemyO@Default		; 0C	; Part of the cloud?
	POINTER EnemyO@Default		; 0D	; ""
	POINTER EnemyO@KoopaShell2 	; 0E	
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER ItemO@Platform		; 11	; Apparently repeated?
	POINTER ItemO@Platform		; 12
	POINTER ItemO@EgyptPlatformAlt; 13	; Solid platform (Egypt) / DD+DE
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15	; Circular explosion 2
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18	; Light colored star
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C	; Coin 1. Unused?
	POINTER EnemyO@Default		; 1D	; Coin 2 ""
	POINTER EnemyO@Default		; 1E	; Coin 3 ""
	POINTER ItemO@Nothing			; 1F	; Nothing? It uses tile FE
	POINTER EnemyO@Stalactite		; 20	; Stalactite 
	POINTER ItemO@Spring	; 21	; Small platform (spring shaped)
	POINTER ItemO@MidPlatform		; 22	; Medium platform (two steps)
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26	
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Zombie1		; 28
	POINTER EnemyO@Zombie2		; 29
	POINTER EnemyO@Snake1		; 2A
	POINTER EnemyO@Snake2		; 2B		
	POINTER EnemyO@ZombieDead		; 2C
	POINTER EnemyO@ZombieDeadF	; 2D
	POINTER EnemyO@SnakeDead		; *2E	
	POINTER EnemyO@SnakeDeadF	; 2F
	POINTER EnemyO@Bee1			; *30
	POINTER EnemyO@Plane		; *31
	POINTER EnemyO@CeilSpider1	; *32
	POINTER EnemyO@CeilSpider2	; *33
	POINTER EnemyO@BeeDead		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37	
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C	; 
	POINTER EnemyO@Default		; 3D	; 
	POINTER EnemyO@RobotHead		; 3E	; Robot's head
	POINTER EnemyO@Default		; 3F	; 
	POINTER EnemyO@RobotBody		; 40	; Robot's body
	POINTER EnemyO@Default		; 41	; 
	POINTER EnemyO@Fishbone1		; 42	; Fishbone 1
	POINTER EnemyO@Fishbone2		; 43	; Fishbone 2
	POINTER EnemyO@BeeArrow		; 44	; Arrow down
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderF		; 47	; 
	POINTER BossO@Lion			; 48	; Lion Boss
	POINTER BossO@Lion2			; 49	; Lion Boss 2
	POINTER BossO@LionFire		; 4A	; Fireball A (lion's?)
	POINTER BossO@LionFire2		; 4B	; Fireball B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2	; 52	; 
	POINTER EnemyO@BulletBill3	; 53	; 
	POINTER BossO@Boulder1		; 54	; 
	POINTER BossO@Boulder2		; 55	; 
	POINTER EnemyO@FireFlower1	; 56
	POINTER EnemyO@FireFlower2	; 57
	POINTER EnemyO@Default		; 58	; 
	POINTER EnemyO@Default		; 59	; 
	POINTER EnemyO@Default		; 5A	; 
	POINTER EnemyO@Default		; 5B	; 
	POINTER EnemyO@Default		; 5C	; 
	POINTER EnemyO@Default		; 5D	; 
	POINTER EnemyO@Default		; 5E	; 
	POINTER EnemyO@Piranha1F		; 5F	; 
	POINTER EnemyO@Piranha2F		; 60	; 
	POINTER EnemyO@DeadlyStar1		; 61
	POINTER EnemyO@DeadlyStar2		; 62	; 
	POINTER BossO@Tatanga			; 63
	POINTER BossO@Ball		; 64
	POINTER EnemyO@Fist			; 65	; 
	POINTER BossO@Kinton1		; 66
	POINTER BossO@Kinton2		; 67
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69
	
 SprTableAlt4O:
	POINTER EnemyO@Goomba			; 00
	POINTER EnemyO@GoombaR		; 01
	POINTER EnemyO@DeadGoomba		; 02
	POINTER EnemyO@GoombaF		; 03
	POINTER EnemyO@Default		; 04
	POINTER EnemyO@Default		; 05
	POINTER EnemyO@Koopa1Ra		; *06
	POINTER EnemyO@Koopa2Ra		; *07
	POINTER EnemyO@KoopaShell1a 	; 08
	POINTER EnemyO@Koopa1Fa		; 09
	POINTER EnemyO@Default		; *0A
	POINTER EnemyO@Default		; *0B
	POINTER EnemyO@Default		; *0C
	POINTER EnemyO@Default		; 0D
	POINTER EnemyO@KoopaShell2 	; 0E
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER EnemyO@Default		; 11
	POINTER ItemO@Platform		; 12
	POINTER EnemyO@Default		; 13
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C
	POINTER EnemyO@Default		; 1D
	POINTER EnemyO@Default		; 1E
	POINTER EnemyO@Default		; 1F
	POINTER EnemyO@Stalactite		; 20
	POINTER EnemyO@Default		; 21
	POINTER ItemO@MidPlatform		; 22
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Zombie1R		; *28
	POINTER EnemyO@Zombie2R		; *29
	POINTER EnemyO@Snake1R		; *2A
	POINTER EnemyO@Snake2R		; *2B
	POINTER EnemyO@ZombieDeadR	; 2C
	POINTER EnemyO@ZombieDeadFR	; 2D
	POINTER EnemyO@SnakeDeadR	; *2E
	POINTER EnemyO@SnakeDeadF	; 2F
	POINTER EnemyO@Default		; *30
	POINTER EnemyO@BoulderR		; *31
	POINTER EnemyO@CeilSpider1	; *32
	POINTER EnemyO@CeilSpider2	; *33
	POINTER EnemyO@Default		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C
	POINTER EnemyO@Default		; 3D
	POINTER EnemyO@RobotHead		; 3E	
	POINTER EnemyO@Default		; 3F
	POINTER EnemyO@RobotBody		; 40
	POINTER EnemyO@Default		; 41
	POINTER EnemyO@Default		; 42
	POINTER EnemyO@Default		; 43
	POINTER EnemyO@Default		; 44
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderFR		; 47
	POINTER EnemyO@Default		; 48
	POINTER EnemyO@Default		; 49
	POINTER EnemyO@Default		; 4A
	POINTER EnemyO@Default		; 4B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2R	; *52	; 
	POINTER EnemyO@BulletBill3R	; *53	; 
	POINTER BossO@Boulder1		; 54
	POINTER BossO@Boulder2			; 55
	POINTER EnemyO@FireFlower1	; 56
	POINTER EnemyO@FireFlower2	; 57
	POINTER EnemyO@Default		; 58
	POINTER EnemyO@Default		; 59
	POINTER EnemyO@Default		; 5A
	POINTER EnemyO@Default		; 5B
	POINTER EnemyO@Default		; 5C
	POINTER EnemyO@Default		; 5D
	POINTER EnemyO@Default		; 5E
	POINTER EnemyO@Piranha1F		; 5F	; 
	POINTER EnemyO@Piranha2F		; 60
	POINTER EnemyO@DeadlyStar1		; 61
	POINTER EnemyO@DeadlyStar2		; 62
	POINTER BossO@Tatanga			; 63
	POINTER BossO@Ball		; 64
	POINTER EnemyO@Fist		; 65
	POINTER BossO@Kinton1		; 66
	POINTER BossO@Kinton2		; 67
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69

 SprTable4Ob:
	POINTER EnemyO@Goomba2			; 00
	POINTER EnemyO@GoombaR2		; 01
	POINTER EnemyO@DeadGoomba2		; 02
	POINTER EnemyO@GoombaF2		; 03	; Goomba flipped
	POINTER EnemyO@Piranha1b		; 04	; Piranha Plant closed mouth
	POINTER EnemyO@Piranha2b		; 05	; Piranha Plant open mouth
	POINTER EnemyO@Koopa1b			; 06
	POINTER EnemyO@Koopa2b			; 07
	POINTER EnemyO@KoopaShell1b	; 08
	POINTER EnemyO@Koopa1Fb		; 09
	POINTER EnemyO@Default		; 0A	; Part of the cloud?
	POINTER EnemyO@Default		; 0B	; Cannon?
	POINTER EnemyO@Default		; 0C	; Part of the cloud?
	POINTER EnemyO@Default		; 0D	; ""
	POINTER EnemyO@KoopaShell2 	; 0E	
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER ItemO@Platform		; 11	; Apparently repeated?
	POINTER ItemO@Platform		; 12
	POINTER ItemO@EgyptPlatformAlt; 13	; Solid platform (Egypt) / DD+DE
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15	; Circular explosion 2
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18	; Light colored star
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C	; Coin 1. Unused?
	POINTER EnemyO@Default		; 1D	; Coin 2 ""
	POINTER EnemyO@Default		; 1E	; Coin 3 ""
	POINTER ItemO@Nothing			; 1F	; Nothing? It uses tile FE
	POINTER EnemyO@Stalactite		; 20	; Stalactite 
	POINTER ItemO@Spring2	; 21	; Small platform (spring shaped)
	POINTER ItemO@MidPlatform		; 22	; Medium platform (two steps)
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26	
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Zombie1		; 28
	POINTER EnemyO@Zombie2		; 29
	POINTER EnemyO@Snake1		; 2A
	POINTER EnemyO@Snake2		; 2B		
	POINTER EnemyO@ZombieDead		; 2C
	POINTER EnemyO@ZombieDeadF	; 2D
	POINTER EnemyO@SnakeDead		; *2E	
	POINTER EnemyO@SnakeDeadF	; 2F
	POINTER EnemyO@Bee1			; *30
	POINTER EnemyO@Plane		; *31
	POINTER EnemyO@Chicken1	; *32
	POINTER EnemyO@Chicken2	; *33
	POINTER EnemyO@BeeDead		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37	
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C	; 
	POINTER EnemyO@Default		; 3D	; 
	POINTER EnemyO@RobotHead		; 3E	; Robot's head
	POINTER EnemyO@Default		; 3F	; 
	POINTER EnemyO@RobotBody		; 40	; Robot's body
	POINTER EnemyO@Default		; 41	; 
	POINTER EnemyO@Fishbone1		; 42	; Fishbone 1
	POINTER EnemyO@Fishbone2		; 43	; Fishbone 2
	POINTER EnemyO@BeeArrow		; 44	; Arrow down
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderF		; 47	; 
	POINTER BossO@Lion			; 48	; Lion Boss
	POINTER BossO@Lion2			; 49	; Lion Boss 2
	POINTER BossO@LionFire		; 4A	; Fireball A (lion's?)
	POINTER BossO@LionFire2		; 4B	; Fireball B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2	; 52	; 
	POINTER EnemyO@BulletBill3	; 53	; 
	POINTER BossO@Boulder1		; 54	; 
	POINTER BossO@Boulder2		; 55	; 
	POINTER EnemyO@FireFlower1	; 56
	POINTER EnemyO@FireFlower2	; 57
	POINTER EnemyO@Default		; 58	; 
	POINTER EnemyO@Default		; 59	; 
	POINTER EnemyO@Default		; 5A	; 
	POINTER EnemyO@Default		; 5B	; 
	POINTER EnemyO@Default		; 5C	; 
	POINTER EnemyO@Default		; 5D	; 
	POINTER EnemyO@Default		; 5E	; 
	POINTER EnemyO@Piranha1Fb		; 5F	; 
	POINTER EnemyO@Piranha2Fb		; 60	; 
	POINTER EnemyO@DeadlyStar1		; 61
	POINTER EnemyO@DeadlyStar2		; 62	; 
	POINTER BossO@Tatanga			; 63
	POINTER BossO@Ball		; 64
	POINTER EnemyO@Fist			; 65	; 
	POINTER BossO@Kinton1		; 66
	POINTER BossO@Kinton2		; 67
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69
	
 SprTableAlt4Ob:
	POINTER EnemyO@Goomba2			; 00
	POINTER EnemyO@GoombaR2		; 01
	POINTER EnemyO@DeadGoomba2		; 02
	POINTER EnemyO@GoombaF2		; 03
	POINTER EnemyO@Default		; 04
	POINTER EnemyO@Default		; 05
	POINTER EnemyO@Koopa1Rb		; *06
	POINTER EnemyO@Koopa2Rb		; *07
	POINTER EnemyO@KoopaShell1b 	; 08
	POINTER EnemyO@Koopa1Fb		; 09
	POINTER EnemyO@Default		; *0A
	POINTER EnemyO@Default		; *0B
	POINTER EnemyO@Default		; *0C
	POINTER EnemyO@Default		; 0D
	POINTER EnemyO@KoopaShell2 	; 0E
	POINTER EnemyO@Explosion1		; 0F
	POINTER EnemyO@Explosion2		; 10
	POINTER EnemyO@Default		; 11
	POINTER ItemO@Platform		; 12
	POINTER EnemyO@Default		; 13
	POINTER BossO@Explosion1		; 14	; Circular explosion 1
	POINTER BossO@Explosion2		; 15
	POINTER ItemO@Mushroom		; 16
	POINTER ItemO@Heart			; 17
	POINTER EnemyO@Default		; 18
	POINTER ItemO@Star			; 19
	POINTER ItemO@Flower			; 1A
	POINTER ItemO@FlowerAlt		; 1B
	POINTER EnemyO@Default		; 1C
	POINTER EnemyO@Default		; 1D
	POINTER EnemyO@Default		; 1E
	POINTER EnemyO@Default		; 1F
	POINTER EnemyO@Stalactite		; 20
	POINTER EnemyO@Default		; 21
	POINTER ItemO@MidPlatform		; 22
	POINTER EnemyO@Totem1			; 23	; Totem 1
	POINTER EnemyO@Totem2			; 24	; Totem 2
	POINTER EnemyO@Totem3			; 25	; Totem 3
	POINTER EnemyO@TotemDead		; 26
	POINTER EnemyO@TotemDeadF		; 27
	POINTER EnemyO@Zombie1R		; *28
	POINTER EnemyO@Zombie2R		; *29
	POINTER EnemyO@Snake1R		; *2A
	POINTER EnemyO@Snake2R		; *2B
	POINTER EnemyO@ZombieDeadR	; 2C
	POINTER EnemyO@ZombieDeadFR	; 2D
	POINTER EnemyO@SnakeDeadR	; *2E
	POINTER EnemyO@SnakeDeadF	; 2F
	POINTER EnemyO@Default		; *30
	POINTER EnemyO@BoulderR		; *31
	POINTER EnemyO@Chicken1	; *32
	POINTER EnemyO@Chicken2	; *33
	POINTER EnemyO@Default		; *34
	POINTER EnemyO@BeeDeadF		; 35
	POINTER EnemyO@CeilSpiderDead		; *36
	POINTER EnemyO@CeilSpiderDeadF		; 37
	POINTER EnemyO@Default		; 38
	POINTER EnemyO@Default		; 39
	POINTER EnemyO@Default		; 3A
	POINTER EnemyO@Default		; *3B
	POINTER EnemyO@Default		; 3C
	POINTER EnemyO@Default		; 3D
	POINTER EnemyO@RobotHead		; 3E	
	POINTER EnemyO@Default		; 3F
	POINTER EnemyO@RobotBody		; 40
	POINTER EnemyO@Default		; 41
	POINTER EnemyO@Default		; 42
	POINTER EnemyO@Default		; 43
	POINTER EnemyO@Default		; 44
	POINTER EnemyO@FireBall		; 45
	POINTER EnemyO@FireBall2		; 46
	POINTER EnemyO@BoulderFR		; 47
	POINTER EnemyO@Default		; 48
	POINTER EnemyO@Default		; 49
	POINTER EnemyO@Default		; 4A
	POINTER EnemyO@Default		; 4B
	POINTER BossO@DragonFire1		; 4C	
	POINTER BossO@DragonFire2		; 4D
	POINTER BossO@Dragon			; 4E
	POINTER BossO@Dragon2			; 4F
	POINTER EnemyO@Default		; 50 Platform?
	POINTER EnemyO@BulletBill1	; 51	; 
	POINTER EnemyO@BulletBill2R	; *52	; 
	POINTER EnemyO@BulletBill3R	; *53	; 
	POINTER BossO@Boulder1		; 54
	POINTER BossO@Boulder2			; 55
	POINTER EnemyO@FireFlower1	; 56
	POINTER EnemyO@FireFlower2	; 57
	POINTER EnemyO@Default		; 58
	POINTER EnemyO@Default		; 59
	POINTER EnemyO@Default		; 5A
	POINTER EnemyO@Default		; 5B
	POINTER EnemyO@Default		; 5C
	POINTER EnemyO@Default		; 5D
	POINTER EnemyO@Default		; 5E
	POINTER EnemyO@Piranha1Fb		; 5F	; 
	POINTER EnemyO@Piranha2Fb		; 60
	POINTER EnemyO@DeadlyStar1		; 61
	POINTER EnemyO@DeadlyStar2		; 62
	POINTER BossO@Tatanga			; 63
	POINTER BossO@Ball		; 64
	POINTER EnemyO@Fist		; 65
	POINTER BossO@Kinton1		; 66
	POINTER BossO@Kinton2		; 67
	POINTER ItemO@Elevator		; 68	; Elevator
	POINTER EnemyO@Default		; 69
.ENDS
