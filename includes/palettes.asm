
.INCLUDE "includes/palettes/mario.asm" NAMESPACE "Mario"
.INCLUDE "includes/palettes/mario_og.asm" NAMESPACE "MarioOG"
.INCLUDE "includes/palettes/luigi.asm" NAMESPACE "Luigi"
.INCLUDE "includes/palettes/luigi_og.asm" NAMESPACE "LuigiOG"


SETREV1 9

.BANK 0 SLOT 0
.ORG $0DE0+REVOFFSET
.SECTION "InitLevelPal Hook0" OVERWRITE
	call InitLevelPalHook
.ENDS
.SECTION "InitLevelPal Hook" FREE
 InitLevelPalHook:
	ldh a,(<BANK_CURRENT)
	ldh (<BANK_BUFFER),a

	ldh a,(<CurPlayerBank)
	add BANK_LV_MARIO-BANK_MARIO

	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	call Mario.InitLevelPal

	ldh a,(<BANK_BUFFER)
	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	ret
.ENDS


.BANK 0 SLOT 0
.ORG $2234+REVOFFSET
.SECTION "Midlevel Pals Hook0" OVERWRITE
	call MidLevelPalsHook
.ENDS

.SECTION "Midlevel Pals Hook" FREE
 MidLevelPalsHook:
	;FARCALL Mario.MidLevelPals
	ldh a,(<BANK_CURRENT)
	ldh (<BANK_BUFFER),a

	ldh a,(<CurPlayerBank)
	add BANK_LV_MARIO-BANK_MARIO

	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	call Mario.MidLevelPals

	ldh a,(<BANK_BUFFER)
	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	ret
.ENDS



SETREV1 23
.BANK 0 SLOT 0
.ORG $0808+REVOFFSET
.SECTION "PipePals Hook" OVERWRITE SIZE 21
	;FARCALL Mario.PipePalettes
	
	ldh a,(<BANK_CURRENT)
	ldh (<BANK_BUFFER),a

	ldh a,(<CurPlayerBank)
	add BANK_LV_MARIO-BANK_MARIO

	;ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	call Mario.PipePalettes

	ldh a,(<BANK_BUFFER)
	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	
.ENDS


SETREV1 9
.BANK 0 SLOT 0
.ORG $2544+REVOFFSET
.SECTION "ItemPalettes Hook" OVERWRITE
 ItemPalettesHook:
	ldh (<DXAux), a
	FARCALL ItemPalettes
	call $2CB2+REVOFFSET
	ret
.ENDS

.BANK BANK_ROUTINES SLOT 1
.SECTION "ItemPalettes" FREE
; Intercepts the item spawning routine to set the corresponding OBJ2 palette
 ItemPalettes:
	ld hl,$D190
	ldh a,(<DXAux)
	ld (hl),a
	cp $28
	jr z, @Mushroom
	cp $2A
	jr z, @Life
	cp $2C
	jr z, @Superstar
	cp $2D
	jr z, @Flower
  @PalSet:
  	ld hl,$D190
	ldh a,($C2)
	and $F8
	add $07
	ld ($D192),a
	ldh a,($C3)
	ld ($D193),a
	ld a,$0B
	ld ($DFE0),a
	ret

  @Mushroom:
	ld hl,ItemPal@Mushroom+2
	jr @SetPal
  @Life:
	ld hl,ItemPal@Life+2
	jr @SetPal
  @Superstar:
	ld hl,ItemPal@Superstar+2
	ld a,$04
	ldh (<DXEventsTrigger),a
	
	jr @SetPal
  @Flower:
	ld hl,ItemPal@Flower+2
  @SetPal:
	ld a, $90+2			; OBJ2 + autoincrement
	ldh (<OCPS),a
	ld b,PALUNIT-2
	
	@@Loop:
	WAITBLANK
	ldi a,(hl)
	ldh (<OCPD),a
	dec b
	jr nz,@@Loop

	jr @PalSet

 ItemPal:
  @Mushroom:	.INCBIN "data\\palettes\\partials\\Mushroom.pal"
  @Life:		.INCBIN "data\\palettes\\partials\\1UP.pal"
  @Superstar:	.INCBIN "data\\palettes\\partials\\Superstar.pal"
  @Flower:		.INCBIN "data\\palettes\\partials\\Flower.pal"
.ENDS


SETREV1 9
.BANK 0 SLOT 0
.ORG $0E7E+REVOFFSET
.SECTION "Daisy Palettes Hook" OVERWRITE
	ld a,BANK_ROUTINES	;$03
	ldh (<BANK_CURRENT),a;ldh ($FA),a
	ld (SWITCH_BANK),a
	call DaisyPalettes
.ENDS

SETREV1 -$F3
.BANK BANK_ROUTINES SLOT 1
.SECTION "Daisy Palettes" FREE
 DaisyPalettes:
	ld a,($C203)
	and $F0
	cp $00
	jr z,@IsSmallMario
	ld a,$10
	ld ($C203),a
	@IsSmallMario:
	ldh a,(<Level)
	; Level 1-3:
	cp $13
	jr z,@World1
	; Level 2-3:
	cp $23
	jr z,@World2
	; Level 3-3:
	cp $33
	jp z,@World3
	; Level 2-3:
	cp $43
	jp z,@World4

	@Exit:
	GOTO $03 $6B26+REVOFFSET ; Jumps to the original code

	@World1:
	BUFFERPARTIALPAL World1EndPAL 2
	WRITEPARTIALPALS PAL_BUFFER 2
	jr @Exit

	@World2:
	BUFFERPARTIALPAL World2EndPAL 2
	WRITEPARTIALPALS PAL_BUFFER 2
	jp @Exit

	@World3:
	BUFFERPARTIALPAL World3EndPAL 2
	WRITEPARTIALPALS PAL_BUFFER 2
	jp @Exit

	@World4:
	ret
	/*
	BUFFERPARTIALPAL World4EndPAL
	WRITEPARTIALPALS PAL_BUFFER
	;WRITEDATA EndingAttrs EndingAttrs@Size ATTRIBUTES_MAP
	WRITEDATA Mario.Level11Attrs ATTRIBUTES_MAP
	ld hl,$9A40
	ld bc,$138
	@@Loop:
	ld a,$27
	ldi (hl),a
	dec bc
	ld a,b
	or c
	jr nz,@@Loop

	SETVRAM 1
	ld hl,$9A40
	ld bc,$138
	@@Loop2:
	ld a,$07
	ldi (hl),a
	dec bc
	ld a,b
	or c
	jr nz,@@Loop2
	SETVRAM 0
	ret
	*/

	;EndingAttrs:
	;.INCBIN "data\\attributes\\Level11Attrs.bin" FSIZE EndingAttrs@Size


	World1EndPAL:	.INCBIN "data\\palettes\\levels\\world1_end.pal"
	World2EndPAL:	.INCBIN "data\\palettes\\levels\\world2_end.pal"
	World3EndPAL:	.INCBIN "data\\palettes\\levels\\world3_end.pal"
	;World4EndPAL:	.INCBIN "data\\palettes\\levels\\world4_end.pal"
.ENDS


SETREV1 9
.BANK 0 SLOT 0
.ORG $285B+REVOFFSET
.SECTION "Tatanga palettes Hook" OVERWRITE
	jp TatangaPalettes0
.ENDS
.SECTION "Tatanga palettes Bank 0" FREE
 TatangaPalettes0:
 	push hl
	GOTO TatangaPalettes
	TatangaPalettesEnded:
	pop hl
	jp $26AC+REVOFFSET
.ENDS
.BANK BANK_ROUTINES SLOT 1
.SECTION "Tatanga palettes" FREE
 TatangaPalettes:
	BUFFERPARTIALPAL TatangaPals 4
	WRITEPARTIALPALS PAL_BUFFER 4
	GOTO $01 TatangaPalettesEnded

	TatangaPals:	.INCBIN "data\\palettes\\TatangaFight.pal"
.ENDS