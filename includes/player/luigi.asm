.BANK BANK_LUIGI SLOT 1
.ORGA $4000
.SECTION "Luigi sprite" SEMIFREE
   .INCLUDE "./includes/common/print_sprite.s" NAMESPACE "Luigi"
   .INCLUDE "./includes/common/graphics_player.s" NAMESPACE "Luigi"
.ENDS

.BANK BANK_LUIGI SLOT 1
.SECTION "Luigi sprites - Pointers" SEMIFREE;SIZE $23F OVERWRITE
  LuigiPointers:
	; Sorry, I didn't feel like this needed a custom tool as it isn't that much data so 
	; I inserted the pointers and values manually. Look at the way GB's OAM works to edit this.

	; This is just the pointers table:
   @Default:
	POINTER Luigi@Default@Standing			; 00 - Luigi
	POINTER Luigi@Default@Running1			; 01 - Luigi running 1 (reversed order looks better with the new graphics)
	POINTER Luigi@Default@Running3			; 03 - Luigi running 3 ("")
	POINTER Luigi@Default@Running2			; 02 - Luigi running 2 ("")
	POINTER Luigi@Default@Jumping			; 04 - Luigi jumping
	POINTER Luigi@Default@Skidding			; 05 - Luigi skidding
	POINTER Luigi@Default					; 06 - Daisy 1?
	POINTER Luigi@Default					; 07 - Daisy 2?
	POINTER Luigi@Default					; 08 - ""
	POINTER Luigi@Default					; 09 - ""
	POINTER Luigi@Default@MarinePop1		; 10 - Luigi submarine 1	($B14C)
	POINTER Luigi@Default@MarinePop2		; 11 - Luigi submarine 2
	POINTER Luigi@Default@SkyPop1			; 12 - Luigi airplane 1
	POINTER Luigi@Default@SkyPop2			; 13 - Luigi airplane 2
	POINTER Luigi@Default					; 14 - ""
	POINTER Luigi.Misc@BlockPiece			; 15 - Block pieces?

	POINTER SuperLuigi@Default@Standing		; 16 - Super Luigi
	POINTER SuperLuigi@Default@Running1		; 17 - Super Luigi running 1
	POINTER SuperLuigi@Default@Running2		; 18 - Super Luigi running 2
	POINTER SuperLuigi@Default@Running3		; 19 - Super Luigi running 3
	POINTER SuperLuigi@Default@Jumping		; 20 - Super Luigi jumping
	POINTER SuperLuigi@Default@Skidding		; 21 - Super Luigi skidding	($D54C)
	POINTER SuperLuigi@Default				; 22 - Unused?
	POINTER SuperLuigi@Default				; 23 - Daisy
	POINTER SuperLuigi@Default@Crouching	; 24 - Super Luigi crouching
	POINTER SuperLuigi@Default@LookingUp	; 25 - Super Luigi looking up
	POINTER SuperLuigi@Default@MarinePop1	; 26 - Super Luigi submarine 1
	POINTER SuperLuigi@Default@MarinePop2	; 27 - Super Luigi submarine 2
	POINTER SuperLuigi@Default@SkyPop1		; 28 - Super Luigi airplane 1
	POINTER SuperLuigi@Default@SkyPop2		; 29 - Super Luigi airplane 2
	POINTER SuperLuigi@Default				; 30 - ""
	POINTER SuperLuigi@Default				; 31 - ""

	POINTER Luigi.Daisy@Fly1				; 32 - Fly 1
	POINTER Luigi.Daisy@Fly2				; 33 - Fly 2
	POINTER Luigi.Daisy@Standing			; 34 - Daisy standing
	POINTER Luigi.Daisy@Moving				; 35 - Daisy walking 1?
	POINTER Luigi.Daisy@Moving1RL			; 36 - Daisy walking 2?
	POINTER Luigi.Daisy@Moving2RL			; 37 - Daisy crouching
	POINTER Luigi.Ending@Ship1				; 38 - Spaceship 1
	POINTER Luigi.Ending@Ship2				; 39 - Spaceship 2
	POINTER Luigi.Ending@Ship				; 40 - Spaceship 3
	POINTER Luigi.Ending@Cloud				; 41 - Cloud
	POINTER Luigi.Ending@BigCloud			; 42 - Big Cloud
	POINTER Luigi.Daisy@Standing			; 43 - Removed
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default

	; $3x used for Super while entering a Pipe
	POINTER SuperLuigi@Default@PipeStanding	; 48=$30
	POINTER SuperLuigi@Default@PipeRunning1
	POINTER SuperLuigi@Default@PipeRunning2
	POINTER SuperLuigi@Default@PipeRunning3
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default

	; $4x used for Super while shooting
	POINTER SuperLuigi@Default@Shooting		 ; 64=$40
	POINTER SuperLuigi@Default@Running1
	POINTER SuperLuigi@Default@Running2
	POINTER SuperLuigi@Default@Running3
	POINTER SuperLuigi@Default@Jumping	
	POINTER SuperLuigi@Default@Skidding	
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default@Crouching
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default@MarinePop1
	POINTER SuperLuigi@Default@MarinePop2
	POINTER SuperLuigi@Default@SkyPop1
	POINTER SuperLuigi@Default@SkyPop2
	POINTER SuperLuigi@Default
	POINTER SuperLuigi@Default

	; $5x used only during the ending for a fixed length running animation
	POINTER SuperLuigi@Default@Standing
	POINTER SuperLuigi@Default@Running1
	POINTER SuperLuigi@Default@Running2
	POINTER SuperLuigi@Default@Running3
	POINTER SuperLuigi@Default@Jumping	
	POINTER SuperLuigi@Default@Skidding	
	POINTER SuperLuigi@Default			
	POINTER SuperLuigi@Default			
	POINTER SuperLuigi@Default@Crouching
	POINTER SuperLuigi@Default@LookingUp
	POINTER SuperLuigi@Default@MarinePop1
	POINTER SuperLuigi@Default@MarinePop2
	POINTER SuperLuigi@Default@SkyPop1	
	POINTER SuperLuigi@Default@SkyPop2	
	POINTER SuperLuigi@Default			
	POINTER SuperLuigi@Default			

   @Reversed:
	POINTER Luigi@Reversed@Standing			; 00 - Luigi
	POINTER Luigi@Reversed@Running1			; 01 - Luigi running 1 (reversed order for new graphics)
	POINTER Luigi@Reversed@Running3			; 02 - Luigi running 2 ("")
	POINTER Luigi@Reversed@Running2			; 03 - Luigi running 3 ("")
	POINTER Luigi@Reversed@Jumping			; 04 - Luigi jumping
	POINTER Luigi@Reversed@Skidding			; 05 - Luigi skidding
	POINTER Luigi@Reversed					; 06 - Daisy 1?
	POINTER Luigi@Reversed					; 07 - Daisy 2?
	POINTER Luigi@Reversed					; 08 - ""
	POINTER Luigi@Reversed					; 09 - ""
	POINTER Luigi@Reversed					; 10 - Luigi submarine 1	($B14C)
	POINTER Luigi@Reversed					; 11 - Luigi submarine 2
	POINTER Luigi@Default@SkyPop1			; 12 - Luigi airplane 1
	POINTER Luigi@Default@SkyPop2			; 13 - Luigi airplane 2
	POINTER Luigi@Reversed					; 14 - ""
	POINTER Luigi.Misc@BlockPieceR			; 15 - ?

	POINTER SuperLuigi@Reversed@Standing	; 16 - Super Luigi
	POINTER SuperLuigi@Reversed@Running1	; 17 - Super Luigi running 1
	POINTER SuperLuigi@Reversed@Running2	; 18 - Super Luigi running 2
	POINTER SuperLuigi@Reversed@Running3	; 19 - Super Luigi running 3
	POINTER SuperLuigi@Reversed@Jumping		; 20 - Super Luigi jumping
	POINTER SuperLuigi@Reversed@Skidding	; 21 - Super Luigi skidding	($D54C)
	POINTER SuperLuigi@Reversed				; 22 - Unused?
	POINTER SuperLuigi@Reversed				; 23 - Daisy
	POINTER SuperLuigi@Reversed@Crouching	; 24 - Super Luigi crouching
	POINTER SuperLuigi@Reversed@LookingUp
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed

	POINTER Luigi.Daisy@Fake1				; $419B	- Actually octopus?
	POINTER Luigi.Daisy@Fake2				; $419D
	POINTER Luigi.Daisy@Standing			; $419F - Daisy? (exec. $405C)
	POINTER Luigi.Daisy@Moving
	POINTER SuperLuigi@Reversed@Shooting		; Shooting ball?
	POINTER SuperLuigi@Reversed				; Unused
	POINTER SuperLuigi@Reversed				; Unused
	POINTER SuperLuigi@Reversed				; Unused
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed@Skidding
	POINTER Luigi.Ending@BigCloud
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed@Standing
	POINTER SuperLuigi@Reversed@Running1
	POINTER SuperLuigi@Reversed@Running2

	; $3x used for Super while entering a Pipe
	POINTER SuperLuigi@Reversed@Standing
	POINTER SuperLuigi@Reversed@Running1
	POINTER SuperLuigi@Reversed@Running2
	POINTER SuperLuigi@Reversed@Running3
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed

	; $4x used for Super while shooting
	POINTER SuperLuigi@Reversed@Shooting		 ; 64=$40
	POINTER SuperLuigi@Reversed@Running1
	POINTER SuperLuigi@Reversed@Running2
	POINTER SuperLuigi@Reversed@Running3
	POINTER SuperLuigi@Reversed@Jumping	
	POINTER SuperLuigi@Reversed@Skidding	
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed@Crouching
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed

	; $5x unused. Pointers here just in case
	POINTER SuperLuigi@Reversed@Standing
	POINTER SuperLuigi@Reversed@Running1
	POINTER SuperLuigi@Reversed@Running2
	POINTER SuperLuigi@Reversed@Running3
	POINTER SuperLuigi@Reversed@Jumping	
	POINTER SuperLuigi@Reversed@Skidding	
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed@Crouching
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed
	POINTER SuperLuigi@Reversed


	; Useful link to understand this: http://bgb.bircd.org/pandocs.htm#vramspriteattributetableoam
	; This is the actual data. It works like this for each set of four bytes until it reads END.
	; Byte 0: Y position
	; Byte 1: X position
	; Byte 2: Tile no
	; Byte 3: Attributes/Flags. Bits 2-0 = palette, Bit 3 = VRAM bank
	; R: flipped horizontally (reversed), F: flipped vertically (flipped)

	.INCLUDE "./includes/player/misc/dx.s" NAMESPACE "Luigi"

  Luigi:
   @Default:
	@@Standing:		.db $FA,$F9,$00,$00, $FA,$01,$01,$00
					.db $02,$F9,$10,$00, $02,$01,$11,$00
					.db $FF,$FE,$00,$09, END

	@@Running1:		.db $FA,$F9,$02,$00, $FA,$01,$03,$00
					.db $02,$F9,$12,$00, $02,$01,$13,$00
					.db $FE,$FE,$00,$09, END
	
	@@Running2:		.db $FA,$F9,$04,$00, $FA,$01,$05,$00
					.db $02,$F9,$14,$00, $02,$01,$15,$00
					.db $FE,$FD,$00,$09, END

	@@Running3:		.db $FA,$F9,$1C,$00, $FA,$01,$1D,$00
					.db $02,$F9,$16,$00, $02,$01,$17,$00
					.db $FF,$FE,$00,$09, END

	@@Jumping:		.db $FB,$F9,$08,$00, $FB,$01,$09,$00
					.db $03,$F9,$18,$00, $03,$01,$19,$00
					.db $FF,$FD,$00,$09, END
	
	@@Skidding:		.db $FA,$F9,$0A,$00, $FA,$01,$0B,$00
					.db $02,$F9,$1A,$00, $02,$01,$1B,$00
					.db $FF,$FC,$01,$09, END

	@@MarinePop1:	.db $FA,$F9,$70,$00, $FA,$01,$71,$00
					.db $02,$F9,$72,$00, $02,$01,$73,$00
					.db $FE,$FF,$00,$09, END
	@@MarinePop2:	.db $FA,$F9,$70,$00, $FA,$01,$71,$00
					.db $02,$F9,$74,$00, $02,$01,$73,$00
					.db $FE,$FF,$00,$09, END

	@@SkyPop1:		.db $F8,$FA,$A7,$0B
					.db $F8,$02,$A8,$0B
					.db $00,$F9,$65,$07
					.db $00,$01,$66,$07
					.db $F9,$FE,$A9,$08, END

	@@SkyPop2:		.db $F8,$FA,$A7,$0B
					.db $F8,$02,$A8,$0B
					.db $00,$F9,$65,$07
					.db $00,$01,$68,$07
					.db $F9,$FE,$A9,$08, END
   @Reversed:
	@@Standing:		.db $FA,$F9,$01,$20, $FA,$01,$00,$20
					.db $02,$F9,$11,$20, $02,$01,$10,$20
					.db $FF,$FC,$00,$29, END

	@@Running1:		.db $FA,$F9,$03,$20, $FA,$01,$02,$20
					.db $02,$F9,$13,$20, $02,$01,$12,$20
					.db $FE,$FC,$00,$29, END

	@@Running2:		.db $FA,$F9,$05,$20, $FA,$01,$04,$20
					.db $02,$F9,$15,$20, $02,$01,$14,$20
					.db $FE,$FD,$00,$29, END
					
	@@Running3:		.db $FA,$F9,$1D,$20, $FA,$01,$1C,$20
					.db $02,$F9,$17,$20, $02,$01,$16,$20
					.db $FF,$FC,$00,$29, END

	@@Jumping:		.db $FB,$F9,$09,$20, $FB,$01,$08,$20
					.db $03,$F9,$19,$20, $03,$01,$18,$20
					.db $FF,$FD,$00,$29, END
	
	@@Skidding:		.db $FA,$F9,$0B,$20, $FA,$01,$0A,$20
					.db $02,$F9,$1B,$20, $02,$01,$1A,$20
					.db $FF,$FE,$01,$29, END

  SuperLuigi:
   @Default:
	@@Standing:		.db $FA,$F9,$20,$00, $FA,$01,$21,$00
					.db $02,$F9,$30,$00, $02,$01,$31,$00
					.db $FC,$FD,$04,$09, $F2,$00,$6D,$00, END

	@@Jumping:		.db $FA,$F9,$28,$00, $FA,$01,$29,$00
					.db $02,$F9,$38,$00, $02,$01,$39,$00
					.db $FC,$FD,$04,$09, $F2,$00,$6D,$00, END

	@@Running1:		.db $FA,$F9,$22,$00, $FA,$01,$23,$00
					.db $02,$F9,$32,$00, $02,$01,$33,$00
					.db $FD,$FE,$04,$09, END

	@@Running2:		.db $FA,$F9,$24,$00, $FA,$01,$25,$00
					.db $02,$F9,$34,$00, $02,$01,$35,$00
					.db $FC,$FD,$04,$09, $F2,$00,$6D,$00, END

	@@Running3:		.db $FA,$F9,$22,$00, $FA,$01,$23,$00
					.db $02,$F9,$36,$00, $02,$01,$37,$00
					.db $FD,$FE,$04,$09, END

	@@Crouching:	.db $FA,$F8,$40,$00, $FA,$00,$41,$00
					.db $02,$F8,$42,$00, $02,$00,$43,$00
					.db $00,$FE,$04,$09, END

	@@Skidding:		.db $FA,$FA,$2A,$00, $FA,$02,$2B,$00
					.db $02,$FA,$3A,$00, $02,$02,$3B,$00
					.db $FD,$FD,$2C,$29, $F2,$FE,$6D,$00, END

	@@MarinePop1:	.db $FA,$F9,$75,$00, $FA,$01,$76,$00
					.db $02,$F9,$77,$00, $02,$01,$78,$00
					.db $FC,$FE,$04,$09, $F2,$FE,$44,$08, END
	@@MarinePop2:	.db $FA,$F9,$75,$00, $FA,$01,$76,$00
					.db $02,$F9,$79,$00, $02,$01,$78,$00
					.db $FC,$FE,$04,$09, $F2,$FE,$44,$08, END

	@@SkyPop1:		.db $F8,$FA,$AE,$0B
					.db $F6,$FF,$AB,$0B
					.db $00,$F9,$65,$07
					.db $00,$01,$66,$07
					.db $FA,$FE,$AF,$08
					.db $F0,$F7,$AD,$0B, END

	@@SkyPop2:		.db $F8,$FA,$AE,$0B
					.db $F6,$FF,$AB,$0B
					.db $00,$F9,$65,$07
					.db $00,$01,$68,$07
					.db $FA,$FE,$AF,$08
					.db $F0,$F7,$AD,$0B, END

	@@LookingUp:	.db $FA,$F8,$2E,$08, $FA,$00,$2F,$08
					.db $02,$F8,$3E,$08, $02,$00,$3F,$08
					.db $FC,$FD,$30,$09, $F2,$FB,$31,$08, END

	@@Shooting:		.db $FA,$F9,$44,$00, $FA,$01,$45,$00
					.db $02,$F9,$46,$00, $02,$01,$47,$00
					.db $FC,$FC,$04,$09, $F2,$FF,$6D,$00, END


	@@PipeStanding:	.db $FE,$FE,$04,$09
					.db $02,$F9,$30,$00, $02,$01,$31,$00
					.db $FC,$FA,$20,$00, $FC,$02,$21,$00
					.db $F4,$01,$6D,$00, END

	@@PipeRunning1:	.db $FF,$FF,$04,$09
					.db $02,$F9,$32,$00, $02,$01,$33,$00
					.db $FC,$FA,$22,$00, $FC,$02,$23,$00, END
					

	@@PipeRunning2:	.db $FE,$FE,$04,$09, $02,$F9,$34,$00, $02,$01,$35,$00
					.db $FC,$FA,$24,$00, $FC,$02,$25,$00
					.db $F4,$00,$6D,$00, END

	@@PipeRunning3:	.db $FF,$FF,$04,$09, $02,$F9,$36,$00, $02,$01,$37,$00
					.db $FC,$FA,$22,$00, $FC,$02,$23,$00, END

   @Reversed:
	@@Standing:		.db $FA,$F7,$21,$20, $FA,$FF,$20,$20
					.db $02,$F7,$31,$20, $02,$FF,$30,$20
					.db $FC,$FB,$04,$29, $F2,$FC,$6D,$00, END

	@@Jumping:		.db $FA,$F7,$29,$20, $FA,$FF,$28,$20
					.db $02,$F7,$39,$20, $02,$FF,$38,$20
					.db $FC,$FB,$04,$29, $F2,$FC,$6D,$00, END

	@@Running1:		.db $FA,$F7,$23,$20, $FA,$FF,$22,$20
					.db $02,$F7,$33,$20, $02,$FF,$32,$20
					.db $FD,$FA,$04,$29, END

	@@Running2:		.db $FA,$F7,$25,$20, $FA,$FF,$24,$20
					.db $02,$F7,$35,$20, $02,$FF,$34,$20
					.db $FC,$FB,$04,$29, $F2,$FC,$6D,$00, END
					
	@@Running3:		.db $FA,$F7,$23,$20, $FA,$FF,$22,$20
					.db $02,$F7,$37,$20, $02,$FF,$36,$20
					.db $FD,$FA,$04,$29, END

	@@Crouching:	.db $FA,$F9,$41,$20, $FA,$01,$40,$20
					.db $02,$F9,$43,$20, $02,$01,$42,$20
					.db $00,$FB,$04,$29, END

	@@Skidding:		.db $FA,$F6,$2B,$20, $FA,$FE,$2A,$20
					.db $02,$F6,$3B,$20, $02,$FE,$3A,$20
					.db $FD,$FB,$2C,$09, $F2,$FE,$6D,$00, END

	@@LookingUp:	.db $FA,$F7,$2F,$28, $FA,$FF,$2E,$28
					.db $02,$F7,$3F,$28, $02,$FF,$3E,$28
					.db $FC,$FA,$30,$29, $F2,$FC,$31,$28, END

	@@Shooting:		.db $FA,$F7,$45,$20, $FA,$FF,$44,$20
					.db $02,$F7,$47,$20, $02,$FF,$46,$20
					.db $FC,$FC,$04,$29, $F2,$FD,$6D,$00, END

.ENDS