	;ldh a,($80)
	;bit 7,a
	;jp nz,$1D7E
	bit 6,a
	;jp z,$1D49
	jr z,@@Exit
	push af
	ldh a,(<CurrPower)
	cp a,$02
	;jp nz,$1D9A
	jr nz,@@PopExit
	ld a,(de)
	and a
	;jp nz,$1D9A
	jr nz,@@PopExit
	ld a,$19			; Pointer position
	ld ($C203),a
	ldh a,($80)
	and a,$30
	jp nz,$1D9D
	ld a,($C20C)
	and a
	jr z,@@Skip
	pop af
	;jp $1D49
	jr @@PopExit
   @@Skip:
	xor a
	ld ($C20C),a
	pop af
	ret
   @@PopExit:
	pop af
   @@Exit:


	; Fix for added graphics (e.g. shooting Mario):
	ld hl,$C203
	ld a,(ShooterCounter)
	cp $00
	jr z,@@AddedGraphicsEnded
	dec a
	ld (ShooterCounter),a
	cp $00
	jr nz,@@AddedGraphicsEnded
	jr @@ResetGraphic

	@@AddedGraphicsEnded:
	ld a,(hl)
	cp $51
	jr c,@@NoOverflow
	@@ResetGraphic:
	ld a,(hl)
	and a,$0F
	add $10
	ld (hl),a
*
	@@NoOverflow:
	ld hl,$C20C			; Replaced code
	jp LookUpEnded