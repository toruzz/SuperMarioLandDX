SETREV1 9
.BANK 0 SLOT 0
.ORG $3DCE+REVOFFSET
.SECTION "BonusStage Hook" OVERWRITE SIZE 22
	FARCALL BonusStage
	ret
.ENDS

.IF REV == 0
	.UNBACKGROUND $3DE4 $3E9D	; Freed space
.ELSE
	.UNBACKGROUND $3DED $3EA6	; Freed space
.ENDIF

; Mostly original code reallocated. Not very well documented, sorry.
.BANK BANK_INIT SLOT 1
.SECTION "BonusStage" FREE
 BonusStage:
	xor a			; $3dce: $af
	ld ($ff00+$40),a	; $3dcf: $e0 $40
	ld hl,$9800		; $3dd1: $21 $00 $98
	ld a,$f5		; $3dd4: $3e $f5
	ldi (hl),a		; $3dd6: $22
	ld b,$12		; $3dd7: $06 $12
	ld a,$9f		; $3dd9: $3e $9f
	@label_00.462:
	ldi (hl),a		; $3ddb: $22
	dec b			; $3ddc: $05
	jr nz,@label_00.462	; $3ddd: $20 $fc
	ld a,$fc		; $3ddf: $3e $fc
	ld (hl),a		; $3de1: $77
	ld de,$0020		; $3de2: $11 $20 $00
	ld l,e			; $3de5: $6b
	ld b,$10		; $3de6: $06 $10
	ld c,$02		; $3de8: $0e $02
	ld a,$f8		; $3dea: $3e $f8
	@label_00.463:
	ld (hl),a		; $3dec: $77
	add hl,de		; $3ded: $19
	dec b			; $3dee: $05
	jr nz,@label_00.463	; $3def: $20 $fb
	ld l,$33		; $3df1: $2e $33
	dec h			; $3df3: $25
	dec h			; $3df4: $25
	ld b,$10		; $3df5: $06 $10
	dec c			; $3df7: $0d
	jr nz,@label_00.463	; $3df8: $20 $f2
	ld hl,$9a20		; $3dfa: $21 $20 $9a
	ld a,$ff		; $3dfd: $3e $ff
	ldi (hl),a		; $3dff: $22
	ld b,$12		; $3e00: $06 $12
	ld a,$9f		; $3e02: $3e $9f
	@label_00.464:
	ldi (hl),a		; $3e04: $22
	dec b			; $3e05: $05
	jr nz,@label_00.464	; $3e06: $20 $fc
	ld a,$e9		; $3e08: $3e $e9
	ld (hl),a		; $3e0a: $77
	ld hl,$9845		; $3e0b: $21 $45 $98
	ld a,$0b		; $3e0e: $3e $0b
	ldi (hl),a		; $3e10: $22
	ld a,$18		; $3e11: $3e $18
	ldi (hl),a		; $3e13: $22
	dec a			; $3e14: $3d
	ldi (hl),a		; $3e15: $22
	ld a,$1e		; $3e16: $3e $1e
	ldi (hl),a		; $3e18: $22
	ld a,$1c		; $3e19: $3e $1c
	ldi (hl),a		; $3e1b: $22
	inc l			; $3e1c: $2c
	ld a,$10		; $3e1d: $3e $10
	ldi (hl),a		; $3e1f: $22
	ld a,$0a		; $3e20: $3e $0a
	ldi (hl),a		; $3e22: $22
	ld a,$16		; $3e23: $3e $16
	ldi (hl),a		; $3e25: $22
	ld a,$0e		; $3e26: $3e $0e
	ld (hl),a		; $3e28: $77
	ld hl,$9887		; $3e29: $21 $87 $98
	ld a,$e4		; $3e2c: $3e $e4
	ldi (hl),a		; $3e2e: $22
	inc l			; $3e2f: $2c
	ld a,$2b		; $3e30: $3e $2b
	ld (hl),a		; $3e32: $77
	ld l,$e1		; $3e33: $2e $e1
	ld a,$2d		; $3e35: $3e $2d
	ld b,$12		; $3e37: $06 $12
	@label_00.465:
	ldi (hl),a		; $3e39: $22
	dec b			; $3e3a: $05
	jr nz,@label_00.465	; $3e3b: $20 $fc
	ld l,$d1		; $3e3d: $2e $d1
	ld a,$2b		; $3e3f: $3e $2b
	ldi (hl),a		; $3e41: $22
	ld l,$41		; $3e42: $2e $41
	inc h			; $3e44: $24
	ld a,$2d		; $3e45: $3e $2d
	ld b,$12		; $3e47: $06 $12
	@label_00.466:
	ldi (hl),a		; $3e49: $22
	dec b			; $3e4a: $05
	jr nz,@label_00.466	; $3e4b: $20 $fc
	ld l,$31		; $3e4d: $2e $31
	ld a,$2b		; $3e4f: $3e $2b
	ldi (hl),a		; $3e51: $22
	ld l,$a1		; $3e52: $2e $a1
	ld a,$2d		; $3e54: $3e $2d
	ld b,$12		; $3e56: $06 $12
	@label_00.467:
	ldi (hl),a		; $3e58: $22
	dec b			; $3e59: $05
	jr nz,@label_00.467	; $3e5a: $20 $fc
	ld l,$91		; $3e5c: $2e $91
	ld a,$2b		; $3e5e: $3e $2b
	ldi (hl),a		; $3e60: $22
	ld l,$01		; $3e61: $2e $01
	inc h			; $3e63: $24
	ld a,$2d		; $3e64: $3e $2d
	ld b,$12		; $3e66: $06 $12
	@label_00.468:
	ldi (hl),a		; $3e68: $22
	dec b			; $3e69: $05
	jr nz,@label_00.468	; $3e6a: $20 $fc
	ld l,$f1		; $3e6c: $2e $f1
	dec h			; $3e6e: $25
	ld a,$2b		; $3e6f: $3e $2b
	ldi (hl),a		; $3e71: There's probably a bug here. It should probably jump to a later point
	@label_3E72:
	nop			; $3e72: $00
	ld bc,$e502		; $3e73: $01 $02 $e5
	inc bc			; $3e76: $03
	ld bc,$e502		; $3e77: $01 $02 $e5
	ld de,@label_3E72		; $3e7a: $11 $72 $3e
	ld a,($ff00+$04)	; $3e7d: $f0 $04
	and $03			; $3e7f: $e6 $03
	inc a			; $3e81: $3c
	@label_00.469:
	inc de			; $3e82: $13
	dec a			; $3e83: $3d
	jr nz,@label_00.469	; $3e84: $20 $fc
	ld hl,$98d2		; $3e86: $21 $d2 $98
	ld bc,$0060		; $3e89: $01 $60 $00
	@label_00.470:
	ld a,(de)		; $3e8c: $1a
	ld (hl),a		; $3e8d: $77
	inc de			; $3e8e: $13
	add hl,bc		; $3e8f: $09
	ld a,l			; $3e90: $7d
	cp $52			; $3e91: $fe $52
	jr nz,@label_00.470	; $3e93: $20 $f7

	SETVRAM 1
	WRITEDATA BonusAttrs BonusAttrs@Size BGMAP
	ld a,(PlayerFlag)
	cp $01
	jr nz, @@NotLuigi
	ld a,$06
	ld ($9887), a	; Mario's icon position
	@@NotLuigi:
	SETVRAM 0

	call BonusFlowerFix

	BUFFERPAL BonusPAL

	ld a,(GraphicsFlag)
	cp $00
	jr z, @@IsNewGraphics
	ld a,(PlayerFlag)
	cp $01
	jr z, @@IsLuigiOG
  @@IsMarioOG:
	ld hl,BonusMarioOGPAL
	jr @@PlayerSet
  @@IsLuigiOG:
	ld hl,BonusLuigiOGPAL
	jr @@PlayerSet

  @@IsNewGraphics:
	ld a,(PlayerFlag)
	cp $01
	jr z, @@IsNotMario

	ldh a,(<FireFlower)
	cp $01
	jr z, @@IsFireMario
  @@IsMario:
	ld hl,BonusMarioPAL
	jr @@PlayerSet

  @@IsFireMario:
	ld hl,BonusFireMarioPAL
	jr @@PlayerSet

  @@IsNotMario:
	ldh a,(<FireFlower)
	cp $01
	jr z, @@IsFireLuigi
  @@IsLuigi:
	ld hl,BonusLuigiPAL
	jr @@PlayerSet

  @@IsFireLuigi:
	ld hl,BonusFireLuigiPAL
	jr @@PlayerSet

  @@PlayerSet:
	ld bc,$0006
	ld de,PAL_BUFFER@OBJ+2
	call CopyData

	WRITEPALS PAL_BUFFER

	ld a,$83		; $3e95: $3e $83
	ldh (<LCDC),a	; $3e97: $e0 $40
	ld a,$14		; $3e99: $3e $14
	ldh ($B3),a	; $3e9b: $e0 $b3
	ret			; $3e9d: $c9


	BonusFlowerFix:
	ld hl,$98D2
	call @FixFlowerColor
	ld hl,$9932
	call @FixFlowerColor
	ld hl,$9992
	call @FixFlowerColor
	ld hl,$99F2
	call @FixFlowerColor
	ret

	@FixFlowerColor:
	ld a,(hl)
	cp $E5
	ret nz

	push hl
	SETVRAM 1
	pop hl
	push hl
	ld a,$0D
	ld (hl),a
	SETVRAM 0
	pop hl
	ret

	BonusAttrs:
	.INCBIN "data\\attributes\\BonusAttrs.bin" FSIZE BonusAttrs@Size

	BonusPAL:
	.INCBIN "data\\palettes\\Bonus.pal"

	BonusMarioOGPAL:		.INCBIN "data\\palettes\\UndergroundMarioOG.pal" SKIP PALSIZE+2 READ PALUNIT-2
	BonusLuigiOGPAL:		.INCBIN "data\\palettes\\UndergroundLuigiOG.pal" SKIP PALSIZE+2 READ PALUNIT-2
	BonusMarioPAL:			.INCBIN "data\\palettes\\UndergroundMario.pal" SKIP PALSIZE+2 READ PALUNIT-2
	BonusFireMarioPAL:		.INCBIN "data\\palettes\\partials\\Player\\FireMario.pal" SKIP 2 READ PALUNIT-2
	BonusLuigiPAL:			.INCBIN "data\\palettes\\UndergroundLuigi.pal" SKIP PALSIZE+2 READ PALUNIT-2
	BonusFireLuigiPAL:		.INCBIN "data\\palettes\\partials\\Player\\FireLuigi.pal" SKIP 2 READ PALUNIT-2
.ENDS

SETREV1 13
.BANK 0 SLOT 0
.ORG $3EAC+REVOFFSET
.SECTION "BonusStage Ladder Fix Hook" OVERWRITE
	call BonusLadder
.ENDS

.SECTION "BonusLadder" FREE
 BonusLadder:
	ld a,(de)
	ld (hl),a
	inc de
	push hl
	SETVRAM 1
	cp $2E	; 2E/2F=Escalera ($04), 2C/2D=Vacío($03)
	jr z,@Ladder
	cp $2F
	jr z,@Ladder
	ld a,$03
	jr @ColorSet
	@Ladder:
	ld a,$04
	@ColorSet:
	pop hl
	push hl
	ld (hl),a
	SETVRAM 0
	pop hl
	ret
.ENDS



.BANK 2 SLOT 1
.ORGA $5A88
.SECTION "Initial OAM print" OVERWRITE SIZE 51
	call NewTileBonusFix@MarioStanding
	ld a,$15
	ldh (<GameStatus),a
	ret
.ENDS

.ORGA $5B07
.SECTION "Metasprite vertical position fix Hook" OVERWRITE
	call BonuxFixMetasprite
.ENDS
.SECTION "Metasprite vertical position fix" FREE
	BonuxFixMetasprite:
	call NewTileBonusFix@MarioStanding
	ld hl,$98EA	; Replaced code
	ret
.ENDS

.ORGA $5B65
.SECTION "Walking OAM Print" OVERWRITE ;SIZE 67
 WalkingOAMPrint:
	ld hl,BonusWalkingInit
	ld a,(hl)
	and a
	jr nz,@Initializated
	inc (hl)
	ld hl,MusicToPlay
	ld a,$0A		; Sets the bonus walking music
	ld (hl),a		;

   @Initializated:
	ld a,($DA14)	;
	and $0F
	cp $00
	call z,NewTileBonusFix

	ld b,$06
	ld hl,$C031
	@Loop:
	inc (hl)
	inc l
	inc l
	inc l
	inc l
	dec b
	jr nz,@Loop
	jr @Skip
	PADDING 28
	@Skip:

	ld a,($da14)		; $1ba8: $fa $14 $da
	add $04			; $1bab: $c6 $04
	ld ($da14),a		; $1bad: $ea $14 $da
	ld hl,$c031		; $1bb0: $21 $31 $c0
	ldd a,(hl)		; $1bb3: $3a
	cp $80			; $1bb4: $fe $80
	jr nc,label_02.214	; $1bb6: $30 $2a
	add $04			; $1bb8: $c6 $04
	ld ($ff00+$ae),a	; $1bba: $e0 $ae
	ld a,(hl)		; $1bbc: $7e
	add $10			; $1bbd: $c6 $10
	ld ($ff00+$ad),a	; $1bbf: $e0 $ad
	ld bc,$da16		; $1bc1: $01 $16 $da
	;ld a,(bc)		; $1bc4: $0a
	;dec a			; $1bc5: $3d
	;ld (bc),a		; $1bc6: $02
	call BonusOAMCheck
	ret nz			; $1bc7: $c0
	
	ld a,$01		; $1bc8: $3e $01
	ld (bc),a		; $1bca: $02
	call $0153		; $1bcb: $cd $53 $01
	ld a,(hl)		; $1bce: $7e
	cp $2e			; $1bcf: $fe $2e
	jr z,label_02.212	; $1bd1: $28 $05
	cp $30			; $1bd3: $fe $30
	jr z,label_02.213	; $1bd5: $28 $06
	ret			; $1bd7: $c9
label_02.212:
	ld a,$18		; $1bd8: $3e $18
	ld ($ff00+$b3),a	; $1bda: $e0 $b3
	ret			; $1bdc: $c9
label_02.213:
	ld a,$19		; $1bdd: $3e $19
	ld ($ff00+$b3),a	; $1bdf: $e0 $b3
	ret			; $1be1: $c9
label_02.214:
	xor a			; $1be2: $af
	ld ($da1c),a		; $1be3: $ea $1c $da
	ld a,$1a		; $1be6: $3e $1a
	ld ($ff00+$b3),a	; $1be8: $e0 $b3
	ret			; $1bea: $c9
.ENDS

.SECTION "BonusOAMCheck" FREE
	BonusOAMCheck:
	ld a,(bc)
	dec a
	ld (bc),a
	and $7F
	ret
.ENDS

.ORGA $5E15
.SECTION "Jumping animation - Init" OVERWRITE SIZE 41
 ; Small Mario, Luigi, OG
	; Properly reimplement (...)
	BonusStandingJumpingAnimationInit:
	ld a,$38
	ld ($C030),a
	ld a,$58
	ld ($C031),a
	ld a,$01
	ld ($DA20),a
	;ld hl,BonusOAM@SuperMarioStanding
	;call ApplyBonusAttrs
	call NewTileBonusFix@MarioStanding
	ret
.ENDS
.ORGA $5EDA
.SECTION "Jumping animation - Standing" OVERWRITE SIZE 59
	BonusStandingJumpingAnimation:
	call BonusStandingJumpingAnimationInit
	xor a
	ld ($DA20),a
	ld ($DA21),a
	ld a,($DA17)
	dec a
	ld ($DA17),a
	ret
.ENDS

.SECTION "BonusStage OAM Fix Transformation" FREE
	TransformationBonusFix:
	inc l
	inc l
	inc l
	ld a,b
	cp $01
	call z,NewTileBonusFix
	ret

	TransformationBonusFix2:
	call NewTileBonusFix
	ld a,($da20)
	ret

	TransformationBonusFix3:
	ld ($da20),a
	call NewTileBonusFix
	ret


	; I can't believe how lazy this is. Not changing it though.
	NewTileBonusFix:

	ld a,($DA14)
	cp $00
	jr z,@Mario1
	cp $10
	jp z,@Mario2
	cp $20
	jp z,@Mario3
	cp $30
	jr z,@Mario1
	cp $40
	jp z,@Mario2
	cp $50
	jp z,@Mario3
	cp $60
	jr z,@Mario1
	cp $70
	jp z,@Mario2
	cp $80
	jp z,@Mario3
	cp $90
	jr z,@Mario1
	cp $A0
	jp z,@Mario2
	cp $B0
	jp z,@Mario3
	cp $C0
	jr z,@Mario1
	cp $D0
	jp z,@Mario2
	cp $E0
	jp z,@Mario3
	cp $F0
	jp z,@Mario1

	@MarioStanding:
	ld hl,BonusOAM@MarioStanding
	jr @Exit
	@Mario1:
	ld hl,BonusOAM@Mario1
	jr @Exit
	@Mario2:
	ld hl,BonusOAM@Mario2
	jr @Exit
	@Mario3:
	ld hl,BonusOAM@Mario3
	jr @Exit
	@MarioJumping:
	ld hl,BonusOAM@MarioJumping
	jr @Exit
	@SuperMarioStanding:
	ld hl,BonusOAM@SuperMarioStanding
	jr @Exit
	@SuperMario1:
	ld hl,BonusOAM@SuperMario1
	jr @Exit
	@SuperMario2:
	ld hl,BonusOAM@SuperMario2
	jr @Exit
	@SuperMario3:
	ld hl,BonusOAM@SuperMario3
	jr @Exit
	@SuperMarioJumping:
	ld hl,BonusOAM@SuperMarioJumping
	@Exit:
	@ApplyRelative:

	ld a,(MarioCurStatus)
	and $F0
	cp $00
	jr z,@NotSuperMario
	ld de,BonusOAM@SuperMario1 - BonusOAM@Mario1
	add hl,de
 @NotSuperMario:
	ld a,(PlayerFlag)
	cp $01
	jr nz,@NotLuigi
	ld de,BonusOAM@Luigi1 - BonusOAM@Mario1
	add hl,de
 @NotLuigi:
	ld a,(GraphicsFlag)
	cp $01
	jr nz,@NewGraphics
	ld de,BonusOAM@OGMarioStanding - BonusOAM@MarioStanding
	add hl,de
 @NewGraphics:
	push de
 	push hl
	pop de
	GOTO ApplyBonusAttrs
	ApplyBonusAttrsEnded:
	pop de
	ret
.ENDS

.BANK BANK_ROUTINES SLOT 1
.SECTION "BonusStage OAM Fix Transformation Data" FREE

 ApplyBonusAttrs:
	push de
	pop hl

	push bc
	ld de,OAM_Misc
	ld a,(de)
	ld b,a
	ld a,(OAM_Misc+1)
	ld c,a

  @Loop:
	ldi a,(hl)
	cp $80
	jr z,@Exit
	add b
	ld (de),a
	inc de
	ldi a,(hl)
	add c
	ld (de),a
	inc de
	ldi a,(hl)
	ld (de),a
	inc de
	ldi a,(hl)
	ld (de),a
	inc de
	jr @Loop
   @Exit:
	pop bc

	GOTO ApplyBonusAttrsEnded


 BonusOAM:
  @MarioStanding:
	.db $00,$00,$00,$00
	.db $00,$08,$01,$00
	.db $08,$00,$10,$00
	.db $08,$08,$11,$00
	.db $06,$05,$00,$09
	.db $00,$00,$6D,$09, END
  @Mario1:
	.db $00,$00,$02,$00
	.db $00,$08,$03,$00
	.db $08,$00,$12,$00
	.db $08,$08,$13,$00
	.db $05,$05,$00,$09
	.db $00,$00,$6D,$09, END
  @Mario2:
	.db $00,$00,$04,$00
	.db $00,$08,$05,$00
	.db $08,$00,$14,$00
	.db $08,$08,$15,$00
	.db $05,$04,$00,$09
	.db $00,$00,$6D,$09, END
  @Mario3:
	.db $00,$00,$1C,$00
	.db $00,$08,$1D,$00
	.db $08,$00,$16,$00
	.db $08,$08,$17,$00
	.db $06,$05,$00,$09
	.db $00,$00,$6D,$09, END
  @MarioJumping:
	.db $00,$00,$08,$00
	.db $00,$08,$09,$00
	.db $08,$00,$18,$00
	.db $08,$08,$19,$00
	.db $05,$04,$00,$09
	.db $00,$00,$6D,$09, END

  @SuperMarioStanding:
	.db $00,$00,$20,$00
	.db $00,$08,$21,$00
	.db $08,$00,$30,$00
	.db $08,$08,$31,$00
	.db $03,$04,$04,$09
	.db $00,$00,$6D,$00, END
  @SuperMario1:
	.db $00,$00,$22,$00
	.db $00,$08,$23,$00
	.db $08,$00,$32,$00
	.db $08,$08,$33,$00
	.db $04,$05,$04,$09
	.db $00,$00,$6D,$00, END
  @SuperMario2:
	.db $00,$00,$24,$00
	.db $00,$08,$25,$00
	.db $08,$00,$34,$00
	.db $08,$08,$35,$00
	.db $03,$04,$04,$09
	.db $00,$00,$6D,$00, END
  @SuperMario3:
	.db $00,$00,$22,$00
	.db $00,$08,$23,$00
	.db $08,$00,$36,$00
	.db $08,$08,$37,$00
	.db $04,$05,$04,$09
	.db $00,$00,$6D,$00, END
  @SuperMarioJumping:
	.db $00,$00,$28,$00
	.db $00,$08,$29,$00
	.db $08,$00,$38,$00
	.db $08,$08,$39,$00
	.db $03,$04,$04,$09
	.db $00,$00,$6D,$00, END


  @LuigiStanding:
	.db $00,$00,$00,$00
	.db $00,$08,$01,$00
	.db $08,$00,$10,$00
	.db $08,$08,$11,$00
	.db $05,$05,$00,$09
	.db $00,$00,$6D,$09, END
  @Luigi1:
	.db $00,$00,$02,$00
	.db $00,$08,$03,$00
	.db $08,$00,$12,$00
	.db $08,$08,$13,$00
	.db $04,$05,$00,$09
	.db $00,$00,$6D,$09, END
  @Luigi2:
	.db $00,$00,$04,$00
	.db $00,$08,$05,$00
	.db $08,$00,$14,$00
	.db $08,$08,$15,$00
	.db $04,$04,$00,$09
	.db $00,$00,$6D,$09, END
  @Luigi3:
	.db $00,$00,$1C,$00
	.db $00,$08,$1D,$00
	.db $08,$00,$16,$00
	.db $08,$08,$17,$00
	.db $05,$05,$00,$09
	.db $00,$00,$6D,$09, END
  @LuigiJumping:
	.db $00,$00,$08,$00
	.db $00,$08,$09,$00
	.db $08,$00,$18,$00
	.db $08,$08,$19,$00
	.db $04,$04,$00,$09
	.db $00,$00,$6D,$09, END

  @SuperLuigiStanding:
	.db $00,$00,$20,$00
	.db $00,$08,$21,$00
	.db $08,$00,$30,$00
	.db $08,$08,$31,$00
	.db $02,$04,$04,$09
	.db $F8,$07,$6D,$00, END
  @SuperLuigi1:
	.db $00,$00,$22,$00
	.db $00,$08,$23,$00
	.db $08,$00,$32,$00
	.db $08,$08,$33,$00
	.db $03,$05,$04,$09
	.db $00,$00,$6D,$09, END
  @SuperLuigi2:
	.db $00,$00,$24,$00
	.db $00,$08,$25,$00
	.db $08,$00,$34,$00
	.db $08,$08,$35,$00
	.db $02,$04,$04,$09
	.db $F8,$07,$6D,$00, END
  @SuperLuigi3:
	.db $00,$00,$22,$00
	.db $00,$08,$23,$00
	.db $08,$00,$36,$00
	.db $08,$08,$37,$00
	.db $03,$05,$04,$09
	.db $00,$00,$6D,$09, END
  @SuperLuigiJumping:
	.db $00,$00,$28,$00
	.db $00,$08,$29,$00
	.db $08,$00,$38,$00
	.db $08,$08,$39,$00
	.db $02,$04,$04,$09
	.db $F8,$07,$6D,$00, END



  @OGMarioStanding:
	.db $00,$00,$00,$00
	.db $00,$08,$01,$00
	.db $08,$00,$10,$00
	.db $08,$08,$11,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGMario1:
	.db $00,$00,$02,$00
	.db $00,$08,$03,$00
	.db $08,$00,$12,$00
	.db $08,$08,$13,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGMario2:
	.db $00,$00,$04,$00
	.db $00,$08,$05,$00
	.db $08,$00,$14,$00
	.db $08,$08,$15,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGMario3:
	.db $00,$00,$00,$00
	.db $00,$08,$01,$00
	.db $08,$00,$16,$00
	.db $08,$08,$17,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGMarioJumping:
	.db $00,$00,$08,$00
	.db $00,$08,$09,$00
	.db $08,$00,$18,$00
	.db $08,$08,$19,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END

  @OGSuperMarioStanding:
	.db $00,$00,$20,$00
	.db $00,$08,$21,$00
	.db $08,$00,$30,$00
	.db $08,$08,$31,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGSuperMario1:
	.db $00,$00,$22,$00
	.db $00,$08,$23,$00
	.db $08,$00,$32,$00
	.db $08,$08,$33,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGSuperMario2:
	.db $00,$00,$24,$00
	.db $00,$08,$25,$00
	.db $08,$00,$34,$00
	.db $08,$08,$35,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGSuperMario3:
	.db $00,$00,$22,$00
	.db $00,$08,$23,$00
	.db $08,$00,$36,$00
	.db $08,$08,$37,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGSuperMarioJumping:
	.db $00,$00,$28,$00
	.db $00,$08,$29,$00
	.db $08,$00,$38,$00
	.db $08,$08,$39,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END


  @OGLuigiStanding:
	.db $00,$00,$00,$00
	.db $00,$08,$01,$00
	.db $08,$00,$10,$00
	.db $08,$08,$11,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGLuigi1:
	.db $00,$00,$02,$00
	.db $00,$08,$03,$00
	.db $08,$00,$12,$00
	.db $08,$08,$13,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGLuigi2:
	.db $00,$00,$04,$00
	.db $00,$08,$05,$00
	.db $08,$00,$14,$00
	.db $08,$08,$15,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGLuigi3:
	.db $00,$00,$00,$00
	.db $00,$08,$01,$00
	.db $08,$00,$16,$00
	.db $08,$08,$17,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGLuigiJumping:
	.db $00,$00,$08,$00
	.db $00,$08,$09,$00
	.db $08,$00,$18,$00
	.db $08,$08,$19,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END

  @OGSuperLuigiStanding:
	.db $00,$00,$20,$00
	.db $00,$08,$21,$00
	.db $08,$00,$30,$00
	.db $08,$08,$31,$00
	.db $F8,$03,$84,$08
	.db $00,$00,$6D,$09, END
  @OGSuperLuigi1:
	.db $00,$00,$22,$00
	.db $00,$08,$23,$00
	.db $08,$00,$32,$00
	.db $08,$08,$33,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGSuperLuigi2:
	.db $00,$00,$24,$00
	.db $00,$08,$25,$00
	.db $08,$00,$34,$00
	.db $08,$08,$35,$00
	.db $F8,$03,$84,$08
	.db $00,$00,$6D,$09, END
  @OGSuperLuigi3:
	.db $00,$00,$22,$00
	.db $00,$08,$23,$00
	.db $08,$00,$36,$00
	.db $08,$08,$37,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
  @OGSuperLuigiJumping:
	.db $00,$00,$28,$00
	.db $00,$08,$29,$00
	.db $08,$00,$38,$00
	.db $08,$08,$39,$00
	.db $00,$00,$6D,$09
	.db $00,$00,$6D,$09, END
.ENDS


.BANK $02 SLOT 1
.ORGA $5CED
.SECTION "BonusStage BG Clear Fix Hook" OVERWRITE
	call BonusBGClearFix
.ENDS
.SECTION "BonusStage BG Clear Fix" FREE
 BonusBGClearFix:
	WAITBLANK
	ld a,(OAM_Misc)
	ret
.ENDS
.ORGA $5CF5
.SECTION "BonusStage BG Clear Fix 1" OVERWRITE
	ld a,$27
.ENDS
.ORGA $5CFF
.SECTION "BonusStage BG Clear Fix 2" OVERWRITE
	ld a,$27
.ENDS
.ORGA $5D09
.SECTION "BonusStage BG Clear Fix 3" OVERWRITE
	ld a,$27
.ENDS
.ORGA $5D13
.SECTION "BonusStage BG Clear Fix 4" OVERWRITE
	ld a,$27
.ENDS

.BANK $02 SLOT 1
.ORGA $5BEB
.SECTION "Ladder down metasprite fix" OVERWRITE SIZE 54
	LadderDownFix:
	ld a,($DA14)	;
	and $0F
	cp $00
	call z,NewTileBonusFix

	ld b,$06
	ld hl,$C030
	@Loop:
	inc (hl)
	inc l
	inc l
	inc l
	inc l
	dec b
	jr nz,@Loop
	jr @Skip
	PADDING 29
	@Skip:
.ENDS

.ORGA $5C44
.SECTION "Ladder up metasprite fix" OVERWRITE SIZE 54
	LadderUpFix:
	ld a,($DA14)	;
	and $0F
	cp $00
	call z,NewTileBonusFix

	ld b,$06
	ld hl,$C030
	@Loop:
	dec (hl)
	inc l
	inc l
	inc l
	inc l
	dec b
	jr nz,@Loop
	jr @Skip
	PADDING 29
	@Skip:
.ENDS

.ORGA $5E3F
.SECTION "Jumping animation metasprite fix" OVERWRITE SIZE 59
	JumpingFix:
	ld a,($DA21)	;
	cp $02
	jp z,BonusStandingJumpingAnimation
	ld a,($DA21)
	and a
	;jp nz,$5EB2
	jp nz,@GoingDown

	;ld b,$06
	ld hl,$C030
	@Loop:
	dec (hl)

	ld hl,BonusOAM@MarioJumping
	call NewTileBonusFix@ApplyRelative

	jr @Skip

	@GoingDown:
	ld hl,$C030
	inc (hl)

	ld hl,BonusOAM@MarioJumping
	call NewTileBonusFix@ApplyRelative

	ld a,($DA20)
	inc a
	ld ($DA20),a
	cp $05
	ret nz

	ld hl,$DFE0
	ld a,$02
	ld ($DA21),a
	ret

	@Skip:
.ENDS


.BANK $02 SLOT 1
.ORGA $5DA0
.SECTION "Flower transformation" OVERWRITE SIZE 87
 FlowerTransformation:
	ld a,($DA1F)
	dec a
	ld ($DA1F),a
	ret nz

	ld a,$03
	ld ($DA1F),a
	ld a,($DA17)
	inc a
	ld ($DA17),a
	cp $28
	jr z,@Exit
	ld a,(BonusWalkingInit)
	and a
	jr nz,@Init
	inc a
	ld (BonusWalkingInit),a

	ld a,(GraphicsFlag)
	cp $01
	jr z,@NoPaletteChange

	ld a,$02
	ldh (<DXEventsTrigger),a

  @NoPaletteChange:
	ld hl,$DFE0
	ld a,$04
	ld (hl),a
	ldh a,(<CurrPower)
	cp $02
	jr z,@Exit

 @Init:
	ld hl,$C032
	ld b,$04
	ld a,($DA1E)
	and a
	jr nz,@SuperMario
@SmallMario:
	inc a
	ld ($DA1E),a

	call NewTileBonusFix@SuperMario3
	ret

@SuperMario:
	dec a
	ld ($DA1E),a

	call NewTileBonusFix@Mario3
	ret

 @Exit:
.ENDS