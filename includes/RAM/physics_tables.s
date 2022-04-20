	@@Vertical:
	ld a,(PlayerFlag)
	cp $01
	jr z,@@VLuigi
	ld hl,VTableMario
	ret
	@@VLuigi:
	ld hl,VTableLuigi
	ret

	@@Horizontal:
	ld a,(PlayerFlag)
	cp $01
	jr z,@@XLuigi
	ld hl,XTableMario
	ret
	@@XLuigi:
	ld hl,XTableLuigi
	ret