	ldh a,(<DXEventsTrigger)
	cp $00
	ret z

	cp $02
	jr z,@@FlowerTrigger

	cp $01
	jp z,RAMCode@DXEvents@FlowerTransformation
	
	cp $03
	jr z,@@FlowerRemoval

	cp $04
	jp z,RAMCode@DXEvents@ActiveSuperstar
	
	cp $05
	jp z,RAMCode@DXEvents@FlowerActivation

	cp $06
	jp z,RAMCode@DXEvents@EnterPipe

	ret
	;cp $07
	;jp z,RAMCode@DXEvents@ExitPipe
	;ret
	;cp $08
	;jp z,RAMCode@DXEvents@HiddenPlayer
	;ret

 @@FlowerRemoval: ; RAMCode@DXEvents@FlowerRemoval
 	ldh a,(<Level)
	cp $43
	ret z

 	WRITEDATA PAL_CHARBUFFER+2 $0006 PAL_BUFFER@OBJ+2

	xor a
	ldh (<DXEventsTrigger),a
	ldh (<FireFlower),a
	
	ld hl,PAL_BUFFER@OBJ+2
	jr @@SetPal

 @@FlowerActivation:
 	ldh a,(<Level)
	cp $43
	ret z

	xor a
	ldh (<DXEventsTrigger),a
	ld a,$01
	ldh (<FireFlower),a

	jr @@ResetPal

 @@FlowerTrigger:
 	ldh a,(<Level)
	cp $43
	ret z

 	ldh a,(<DXEventsCounter)
	cp $00
	ret nz

	ld a,$01
	ldh (<DXEventsTrigger),a
	ld a,60
	ldh (<DXEventsCounter),a
	
  @@ResetPal:
	ld a,(PlayerFlag)
	cp $01
	jr z, @@IsFireLuigi
	ld hl,RAMCode@DXEvents@FireMario+2
	jr @@SetPal
  @@IsFireLuigi:
	ld hl,RAMCode@DXEvents@FireLuigi+2
 
  @@SetPal:
	ld a, PALINIT+2			; OBJ0 + autoincrement
	ldh (<OCPS),a
	ld b,PALUNIT-2
	
	@@Loop:
	WAITBLANK
	ldi a,(hl)
	ldh (<OCPD),a
	dec b
	jr nz,@@Loop

	ret

	@@FireMario:		.INCBIN "data\\palettes\\partials\\Player\\FireMario.pal" READ PALUNIT
	@@FireLuigi:		.INCBIN "data\\palettes\\partials\\Player\\FireLuigi.pal" READ PALUNIT


 @@FlowerTransformation:
 	ldh a,(<Level)
	cp $43
	ret z

	ldh a,(<DXEventsCounter)
	cp $00
	jr nz,@@NotFinished
	ret

	@@Step0:
		

		ld a,(PlayerFlag)
		cp $01
		jr z, @@IsFireLuigi2
		ld hl,RAMCode@DXEvents@FireMario+2
		jr @@SetPalBuffer
	@@IsFireLuigi2:
		ld hl,RAMCode@DXEvents@FireLuigi+2
	@@SetPalBuffer:
		ld bc,$0006
		ld de,PAL_BUFFER@OBJ+2
		call CopyData

		call RAMCode@DXEvents@ResetPal

		xor a
		ldh (<DXEventsTrigger),a
		ld a,$01
		ldh (<FireFlower),a

		ret
	@@Step1:
		ld hl, RAMCode@DXEvents@PALStep1+2
		jr @@SetPal
	@@Step2:
		ld hl, RAMCode@DXEvents@PALStep2+2
		jr @@SetPal
	@@Step3:
		ld hl, RAMCode@DXEvents@PALStep3+2
		jr @@SetPal
	@@Step4:
		ld hl, RAMCode@DXEvents@PALStep4+2
		jr @@SetPal

	@@NotFinished:
	dec a
	ldh (<DXEventsCounter),a
	cp 55
	jr z,@@Step4
	cp 50
	jr z,@@Step4
	cp 45
	jr z,@@Step4
	cp 40
	jr z,@@Step3
	cp 35
	jr z,@@Step2
	cp 30
	jr z,@@Step1
	cp 25
	jr z,@@Step4
	cp 20
	jr z,@@Step3
	cp 15
	jr z,@@Step2
	cp 10
	jr z,@@Step1
	cp 5
	jr z,@@Step4
	cp 0
	jr z,@@Step0
	ret

	@@PALStep1:	.db $77,$77,$BE,$7B,$BE,$22,$FE,$00
	@@PALStep2:	.db $77,$77,$9F,$22,$FF,$7F,$00,$00
	@@PALStep3:	.db $77,$77,$FF,$7F,$03,$1E,$A3,$0C
	@@PALStep4:	.db $F7,$76,$FF,$7F,$9F,$0E,$CD,$00

 @@ActiveSuperstar:
	ld a,($D190)
	cp $FF
	jr nz,@@StarIsActive
	xor a
	ldh (<DXEventsTrigger),a
	ret
	@@StarIsActive:
	ldh a,(<Counter)
	and $07
	cp $02
	jr z,@@Star1
	cp $06
	jr z,@@Star2
	ret
	@@Star1:
		ld hl, RAMCode@DXEvents@Superstar+2
		jp RAMCode@DXEvents@SetPalItem
	@@Star2:
		ld hl, RAMCode@DXEvents@Superstar2+2
		jp RAMCode@DXEvents@SetPalItem

	@@Superstar:		.INCBIN "data\\palettes\\partials\\Superstar.pal"
	@@Superstar2:	.INCBIN "data\\palettes\\partials\\Superstar2.pal"

	@@SetPalItem:
	ld a, PALINIT+PALUNIT*2+2		; OBJ2 + autoincrement
	ldh (<OCPS),a
	ld b,PALUNIT-2
	
	@@Loop2:
	ldi a,(hl)
	ldh (<OCPD),a
	dec b
	jr nz,@@Loop2

	ret


 @@EnterPipe:
	ld a,(MarioCurStatus)
	and $F0
	cp $00
	jr z,@@Exit
	ld a,(MarioCurStatus)
	cp $14
	jr c,@@Safe
	ld a,$10
   @@Safe:
	and $F0
	add $20
	ld (MarioCurStatus),a
   @@Exit:
	xor a
	ldh (<DXEventsTrigger),a
	ret

/*
 @@ExitPipe:
	xor a
	ld ($C201),a
	;ld a,$08
	;ldh (<DXEventsCounter),a
	ldh (<DXEventsTrigger),a
	ret

 @@HiddenPlayer:
	ldh a,(<DXEventsCounter)
	dec a
	ldh (<DXEventsCounter),a
	cp $00
	ret nz
	
	ld a,$08
	ldh (<DXEventsTrigger),a
	ret
*/