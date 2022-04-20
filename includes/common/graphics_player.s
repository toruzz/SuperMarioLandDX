 GraphicsPlayer:
 	xor a			; $0568
	ld (Score),a
	ld (Score+1),a
	ld (Score+2),a
	ldh ($FA),a
  GraphicsPlayerDemo:
	call GFXWrites
	ret
