.INCLUDE "includes/player/mario.asm"
.INCLUDE "includes/player/mario_og.asm"
.INCLUDE "includes/player/luigi.asm"
.INCLUDE "includes/player/luigi_og.asm"

SETREV1 9
.BANK 0 SLOT 0
.ORG $172D+REVOFFSET
.SECTION "Player sprite hook" OVERWRITE SIZE $25
 PlayerSpriteHook:
	ldh a,(<BANK_CURRENT)
	ldh (<BANK_BUFFER),a

	ldh a,(<CurPlayerBank)
	
	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	call Mario.PlayerSprite

	ldh a,(<BANK_BUFFER)
	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	
	ret
.ENDS


SETREV1 9
.BANK 0 SLOT 0
.ORG $1ECB+REVOFFSET
.SECTION "Player Death Clean Routine" OVERWRITE
	CleanDeath:
	push hl
	push bc
	push de
	ld hl,OAM_Player2
	ld b,$2C
.ENDS

SETREV1 9

.ORG $0BF0+REVOFFSET
.SECTION "Dead Player number of moving tiles fix" OVERWRITE
	ld c,$06
.ENDS

.ORG $0B84+REVOFFSET
.SECTION "Player Death Routine Hook" OVERWRITE
	PlayerDeadHook:
	FARCALL PlayerDead
	call CleanDeath
	ret
.ENDS

.BANK BANK_ROUTINES SLOT 1
.SECTION "Player Death Routine" FREE
; Original dev hardcoded this for some reason. I'm doing the same.
 PlayerDead:
	ld hl,OAM_Player
	ld a,($C0DD)
	ld c,a
	sub $08
	ld d,a
	ld (hl),a
	inc l
	ld a,($C202)
	add $F8
	ld b,a
	ldi (hl),a
	ld (hl),$0F				; Tile 1
	inc l
	ld (hl),$00				; Attr 1
	inc l
	ld (hl),c
	inc l
	ld (hl),b
	inc l
	ld (hl),$1F				; Tile 2
	inc l
	ld (hl),$00				; Attr 2
	inc l
	ld (hl),d
	inc l
	ld a,b
	add $07
	ld b,a
	ldi (hl),a
	ld (hl),$0F				; Tile 3
	inc l
	ld (hl),$20				; Attr 3
	inc l
	ld (hl),c
	inc l
	ld (hl),b
	inc l
	ld (hl),$1F				; Tile 4
	inc l
	ld (hl),$20				; Attr 4
	inc l

	ld a,(OAM_Player.1.posY)
	inc a
	inc a
	inc a
	ldi (hl),a
	ld a,(OAM_Player.1.posX)
	ldi (hl),a
	ld (hl),$0A				; Tile 1
	inc l
	ld (hl),$09				; Attr 1
	inc l
	ld a,(OAM_Player.5.posY)
	ldi (hl),a
	ld a,(OAM_Player.3.posX)
	ldi (hl),a
	ld (hl),$0A				; Tile 2
	inc l
	ld (hl),$29				; Attr 2
	inc l
	ld (hl),d

	ld a,$04
	ldh (<GameStatus),a
	xor a
	ld ($C0AC),a
	ldh (<CurrPower),a
	ldh ($F4),a

	ldh a,(<Level)
	cp $43
	jr nz,@NotEndLevel

	ld hl,PAL_CHARBUFFER_UG
	ld a,PALINIT
	ldh (<OCPS),a	; 
	ld b,PALUNIT

	@@Loop:
	WAITBLANK
	ldi a,(hl)
	ldh (<OCPD),a
	dec b
	jr nz,@@Loop
	
	ret

 @NotEndLevel:
	ld a,$03
	ldh (<DXEventsTrigger),a
	ret
.ENDS

