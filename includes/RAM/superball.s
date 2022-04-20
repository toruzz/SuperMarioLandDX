  @@On:
	ld ($DFE0),a

	ldh a,($B5)
	cp $00
	ret z

	ld a,(GraphicsFlag)
	cp $01
	ret z

	ld a,$02
	ldh (<DXEventsTrigger),a
	xor a
	ldh (<DXEventsCounter),a
	ret

  @@Off:
	xor a
	ldh ($B5),a

	ld a,(GraphicsFlag)
	cp $01
	ret z

	ld a,$03
	ldh (<DXEventsTrigger),a
	ret
