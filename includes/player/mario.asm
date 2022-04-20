.BANK BANK_MARIO SLOT 1
.ORGA $4000
.SECTION "Mario sprite" SEMIFREE
   .INCLUDE "./includes/common/print_sprite.s" NAMESPACE "Mario"
   .INCLUDE "./includes/common/graphics_player.s" NAMESPACE "Mario"
.ENDS

.BANK BANK_MARIO SLOT 1
.SECTION "Mario sprites - Pointers" SEMIFREE;SIZE $23F OVERWRITE
  MarioPointers:
	; Sorry, I didn't feel like this needed a custom tool as it isn't that much data so 
	; I inserted the pointers and values manually. Look at the way GB's OAM works to edit this.

	; This is just the pointers table:
   @Default:
	POINTER Mario@Default@Standing		; 00 - Mario
	POINTER Mario@Default@Running1		; 03 - Mario running 3 ("")
	POINTER Mario@Default@Running3		; 01 - Mario running 1 (reversed order looks better with the new graphics)
	POINTER Mario@Default@Running2		; 02 - Mario running 2 ("")
	POINTER Mario@Default@Jumping		; 04 - Mario jumping
	POINTER Mario@Default@Skidding		; 05 - Mario skidding
	POINTER Mario@Default				; 06 - Daisy 1?
	POINTER Mario@Default				; 07 - Daisy 2?
	POINTER Mario@Default				; 08 - ""
	POINTER Mario@Default				; 09 - ""
	POINTER Mario@Default@MarinePop1	; 10 - Mario submarine 1	($B14C)
	POINTER Mario@Default@MarinePop2	; 11 - Mario submarine 2
	POINTER Mario@Default@SkyPop1		; 12 - Mario airplane 1
	POINTER Mario@Default@SkyPop2		; 13 - Mario airplane 2
	POINTER Mario@Default				; 14 - ""
	POINTER Mario.Misc@BlockPiece		; 15 - Block pieces?
	
	POINTER SuperMario@Default@Standing	; 16 - Super Mario
	POINTER SuperMario@Default@Running1	; 17 - Super Mario running 1
	POINTER SuperMario@Default@Running2	; 18 - Super Mario running 2
	POINTER SuperMario@Default@Running3	; 19 - Super Mario running 3
	POINTER SuperMario@Default@Jumping	; 20 - Super Mario jumping
	POINTER SuperMario@Default@Skidding	; 21 - Super Mario skidding	($D54C)
	POINTER Mario@Default				; 22 - Unused?
	POINTER Mario@Default				; 23 - Daisy
	POINTER SuperMario@Default@Crouching	; 24 - Super Mario crouching
	POINTER SuperMario@Default@LookingUp	; 25 - Super Mario looking up
	POINTER SuperMario@Default@MarinePop1; 26 - Super Mario submarine 1
	POINTER SuperMario@Default@MarinePop2; 27 - Super Mario submarine 2
	POINTER SuperMario@Default@SkyPop1	; 28 - Super Mario airplane 1
	POINTER SuperMario@Default@SkyPop2	; 29 - Super Mario airplane 2
	POINTER Mario@Default				; 30 - ""
	POINTER Mario@Default				; 31 - ""

	POINTER Mario.Daisy@Fly1			; 32 - Fly 1
	POINTER Mario.Daisy@Fly2			; 33 - Fly 2
	POINTER Mario.Daisy@Standing		; 34 - Daisy standing
	POINTER Mario.Daisy@Moving			; 35 - Daisy walking 1?
	POINTER Mario.Daisy@Moving1R		; 36 - Daisy walking 2?
	POINTER Mario.Daisy@Moving2R		; 37 - Daisy crouching
	POINTER Mario.Ending@Ship1			; 38 - Spaceship 1
	POINTER Mario.Ending@Ship2			; 39 - Spaceship 2
	POINTER Mario.Ending@Ship			; 40 - Spaceship 3
	POINTER Mario.Ending@Cloud			; 41 - Cloud
	POINTER Mario.Ending@BigCloud		; 42 - Big Cloud
	POINTER Mario.Daisy@Standing			; 43 - Removed
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default

	; $3x used for Super while entering a Pipe
	POINTER SuperMario@Default@PipeStanding	; 48=$30
	POINTER SuperMario@Default@PipeRunning1
	POINTER SuperMario@Default@PipeRunning2
	POINTER SuperMario@Default@PipeRunning3
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default

	; $4x used for Super while shooting
	POINTER SuperMario@Default@Shooting		 ; 64=$40
	POINTER SuperMario@Default@Running1
	POINTER SuperMario@Default@Running2
	POINTER SuperMario@Default@Running3
	POINTER SuperMario@Default@Jumping	
	POINTER SuperMario@Default@Skidding	
	POINTER SuperMario@Default
	POINTER SuperMario@Default
	POINTER SuperMario@Default@Crouching
	POINTER SuperMario@Default
	POINTER SuperMario@Default@MarinePop1
	POINTER SuperMario@Default@MarinePop2
	POINTER SuperMario@Default@SkyPop1
	POINTER SuperMario@Default@SkyPop2
	POINTER SuperMario@Default
	POINTER SuperMario@Default

	; $5x unused. Pointers here just in case
	POINTER SuperMario@Default@Standing	
	POINTER SuperMario@Default@Running1	
	POINTER SuperMario@Default@Running2	
	POINTER SuperMario@Default@Running3	
	POINTER SuperMario@Default@Jumping	
	POINTER SuperMario@Default@Skidding	
	POINTER SuperMario@Default			
	POINTER SuperMario@Default			
	POINTER SuperMario@Default@Crouching
	POINTER SuperMario@Default@LookingUp
	POINTER SuperMario@Default@MarinePop1
	POINTER SuperMario@Default@MarinePop2
	POINTER SuperMario@Default@SkyPop1	
	POINTER SuperMario@Default@SkyPop2	
	POINTER SuperMario@Default			
	POINTER SuperMario@Default	

   @Reversed:
	POINTER Mario@Reversed@Standing		; 00 - Mario
	POINTER Mario@Reversed@Running1		; 03 - Mario running 3 ("")
	POINTER Mario@Reversed@Running3		; 01 - Mario running 1 (reversed order for new graphics)
	POINTER Mario@Reversed@Running2		; 02 - Mario running 2 ("")
	POINTER Mario@Reversed@Jumping		; 04 - Mario jumping
	POINTER Mario@Reversed@Skidding		; 05 - Mario skidding
	POINTER Mario@Reversed				; 06 - Daisy 1?
	POINTER Mario@Reversed				; 07 - Daisy 2?
	POINTER Mario@Reversed				; 08 - ""
	POINTER Mario@Reversed				; 09 - ""
	POINTER Mario@Reversed				; 10 - Mario submarine 1	($B14C)
	POINTER Mario@Reversed				; 11 - Mario submarine 2
	POINTER Mario@Default@SkyPop1		; 12 - Mario airplane 1
	POINTER Mario@Default@SkyPop2		; 13 - Mario airplane 2
	POINTER Mario@Reversed				; 14 - ""
	POINTER Mario.Misc@BlockPieceR			; 15 - ?

	POINTER SuperMario@Reversed@Standing	; 16 - Super Mario
	POINTER SuperMario@Reversed@Running1	; 17 - Super Mario running 1
	POINTER SuperMario@Reversed@Running2	; 18 - Super Mario running 2
	POINTER SuperMario@Reversed@Running3	; 19 - Super Mario running 3
	POINTER SuperMario@Reversed@Jumping		; 20 - Super Mario jumping
	POINTER SuperMario@Reversed@Skidding	; 21 - Super Mario skidding	($D54C)
	POINTER SuperMario@Reversed				; 22 - Unused?
	POINTER SuperMario@Reversed				; 23 - Daisy
	POINTER SuperMario@Reversed@Crouching	; 24 - Super Mario crouching
	POINTER SuperMario@Reversed@LookingUp
	POINTER SuperMario@Default				; $418F
	POINTER SuperMario@Default				; $4191
	POINTER SuperMario@Default				; $4193
	POINTER SuperMario@Default				; $4195
	POINTER SuperMario@Default				; $4197
	POINTER SuperMario@Default				; $4199
				
	POINTER Mario.Daisy@Fake1				; $419B
	POINTER Mario.Daisy@Fake2				; $419D
	POINTER Mario.Daisy@Standing			; $419F - Daisy? (exec. $405C)
	POINTER Mario.Daisy@Moving				; 
	POINTER SuperMario@Default@Shooting			; Shooting ball?
	POINTER SuperMario@Default					; Unused
	POINTER SuperMario@Default					; Unused
	POINTER SuperMario@Default					; Unused
	POINTER SuperMario@Default
	POINTER SuperMario@Default@Skidding
	POINTER Mario.Ending@BigCloud				; 42
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed@Standing
	POINTER SuperMario@Reversed@Running1
	POINTER SuperMario@Reversed@Running2


	; $3x used for Super while entering a Pipe
	POINTER SuperMario@Reversed@Standing
	POINTER SuperMario@Reversed@Running1
	POINTER SuperMario@Reversed@Running2
	POINTER SuperMario@Reversed@Running3
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed

	; $4x used for Super while shooting
	POINTER SuperMario@Reversed@Shooting		 ; 64=$40
	POINTER SuperMario@Reversed@Running1
	POINTER SuperMario@Reversed@Running2
	POINTER SuperMario@Reversed@Running3
	POINTER SuperMario@Reversed@Jumping	
	POINTER SuperMario@Reversed@Skidding	
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed@Crouching
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed

	; $5x unused. Pointers here just in case
	POINTER SuperMario@Reversed@Standing
	POINTER SuperMario@Reversed@Running1
	POINTER SuperMario@Reversed@Running2
	POINTER SuperMario@Reversed@Running3
	POINTER SuperMario@Reversed@Jumping	
	POINTER SuperMario@Reversed@Skidding	
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed@Crouching
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed
	POINTER SuperMario@Reversed

	; Useful link to edit this: http://bgb.bircd.org/pandocs.htm#vramspriteattributetableoam
	; This is the actual data. It works like this for each set of four bytes until it reads END.
	; Byte 0: Y position
	; Byte 1: X position
	; Byte 2: Tile no. MSB indicates if it's located at VRAM0 or VRAM1
	; Byte 3: Attributes/Flags. Bits 2-0 = palette, Bit 3 = VRAM bank
	; R: flipped horizontally (reversed), F: flipped vertically (flipped)

	.INCLUDE "./includes/player/misc/dx.s" NAMESPACE "Mario"
	
  Mario:
   @Default:
	@@Standing:		.db $FA,$F9,$00,$00, $FA,$01,$01,$00
					.db $02,$F9,$10,$00, $02,$01,$11,$00
					.db $00,$FE,$00,$09, END

	@@Running1:		.db $FA,$F9,$02,$00, $FA,$01,$03,$00
					.db $02,$F9,$12,$00, $02,$01,$13,$00
					.db $FF,$FE,$00,$09, END
	
	@@Running2:		.db $FA,$F9,$04,$00, $FA,$01,$05,$00
					.db $02,$F9,$14,$00, $02,$01,$15,$00
					.db $FF,$FD,$00,$09, END

	@@Running3:		.db $FA,$F9,$1C,$00, $FA,$01,$1D,$00
					.db $02,$F9,$16,$00, $02,$01,$17,$00
					.db $00,$FE,$00,$09, END

	@@Jumping:		.db $FB,$F9,$08,$00, $FB,$01,$09,$00
					.db $03,$F9,$18,$00, $03,$01,$19,$00
					.db $00,$FD,$00,$09, END
	
	@@Skidding:		.db $FA,$F9,$0A,$00, $FA,$01,$0B,$00
					.db $02,$F9,$1A,$00, $02,$01,$1B,$00
					.db $00,$FC,$01,$09, END

	@@MarinePop1:	.db $FA,$F9,$70,$00, $FA,$01,$71,$00
					.db $02,$F9,$72,$00, $02,$01,$73,$00
					.db $FF,$FF,$00,$09, END
	@@MarinePop2:	.db $FA,$F9,$70,$00, $FA,$01,$71,$00
					.db $02,$F9,$74,$00, $02,$01,$73,$00
					.db $FF,$FF,$00,$09, END

	@@SkyPop1:		.db $F9,$FA,$A4,$0B
					.db $F9,$02,$A5,$0B
					.db $00,$F9,$65,$07
					.db $00,$01,$66,$07
					.db $F9,$FE,$A6,$08, END

	@@SkyPop2:		.db $F9,$FA,$A4,$0B
					.db $F9,$02,$A5,$0B
					.db $00,$F9,$65,$07
					.db $00,$01,$68,$07
					.db $F9,$FE,$A6,$08, END

   @Reversed:
	@@Standing:		.db $FA,$F9,$01,$20, $FA,$01,$00,$20
					.db $02,$F9,$11,$20, $02,$01,$10,$20
					.db $00,$FC,$00,$29, END

	@@Running1:		.db $FA,$F9,$03,$20, $FA,$01,$02,$20
					.db $02,$F9,$13,$20, $02,$01,$12,$20
					.db $FF,$FC,$00,$29, END
	@@Running2:		.db $FA,$F9,$05,$20, $FA,$01,$04,$20
					.db $02,$F9,$15,$20, $02,$01,$14,$20
					.db $FF,$FD,$00,$29, END
	@@Running3:		.db $FA,$F9,$1D,$20, $FA,$01,$1C,$20
					.db $02,$F9,$17,$20, $02,$01,$16,$20
					.db $00,$FC,$00,$29, END

	@@Jumping:		.db $FB,$F9,$09,$20, $FB,$01,$08,$20
					.db $03,$F9,$19,$20, $03,$01,$18,$20
					.db $00,$FD,$00,$29, END
	
	@@Skidding:		.db $FA,$F9,$0B,$20, $FA,$01,$0A,$20
					.db $02,$F9,$1B,$20, $02,$01,$1A,$20
					.db $00,$FE,$01,$29, END

  SuperMario:
   @Default:
	@@Standing:		.db $FA,$F9,$20,$00, $FA,$01,$21,$00
					.db $02,$F9,$30,$00, $02,$01,$31,$00
					.db $FD,$FD,$04,$09, END

	@@Jumping:		.db $FA,$F9,$28,$00, $FA,$01,$29,$00
					.db $02,$F9,$38,$00, $02,$01,$39,$00
					.db $FD,$FD,$04,$09, END

	@@Running1:		.db $FA,$F9,$22,$00, $FA,$01,$23,$00
					.db $02,$F9,$32,$00, $02,$01,$33,$00
					.db $FE,$FE,$04,$09, END

	@@Running2:		.db $FA,$F9,$24,$00, $FA,$01,$25,$00
					.db $02,$F9,$34,$00, $02,$01,$35,$00
					.db $FD,$FD,$04,$09, END

	@@Running3:		.db $FA,$F9,$22,$00, $FA,$01,$23,$00
					.db $02,$F9,$36,$00, $02,$01,$37,$00
					.db $FE,$FE,$04,$09, END

	@@Crouching:	.db $FA,$F8,$40,$00, $FA,$00,$41,$00
					.db $02,$F8,$42,$00, $02,$00,$43,$00
					.db $00,$FE,$04,$09, END

	@@Skidding:		.db $FA,$FA,$2A,$00, $FA,$02,$2B,$00
					.db $02,$FA,$3A,$00, $02,$02,$3B,$00
					.db $FE,$FC,$2C,$29, END

	@@MarinePop1:	.db $FA,$F9,$75,$00, $FA,$01,$76,$00
					.db $02,$F9,$77,$00, $02,$01,$78,$00
					.db $FD,$FE,$04,$09, $F3,$FE,$25,$08, END
	@@MarinePop2:	.db $FA,$F9,$75,$00, $FA,$01,$76,$00
					.db $02,$F9,$79,$00, $02,$01,$78,$00
					.db $FD,$FE,$04,$09, $F3,$FE,$25,$08, END

	@@SkyPop1:		.db $F8,$FA,$AA,$0B
					.db $F7,$FF,$AB,$0B
					.db $00,$F9,$65,$07
					.db $00,$01,$66,$07
					.db $FB,$FE,$AC,$08, END

	@@SkyPop2:		.db $F8,$FA,$AA,$0B
					.db $F7,$FF,$AB,$0B
					.db $00,$F9,$65,$07
					.db $00,$01,$68,$07
					.db $FB,$FE,$AC,$08, END

	@@LookingUp:	.db $FA,$F9,$29,$08, $FA,$01,$2A,$08,
					.db $02,$F9,$27,$08, $02,$01,$28,$08,
					.db $FC,$FD,$2B,$09, END

	@@Shooting:		.db $FA,$F9,$44,$00, $FA,$01,$45,$00
					.db $02,$F9,$46,$00, $02,$01,$47,$00
					.db $FD,$FE,$04,$09, END


	@@PipeStanding:	.db $FE,$FF,$04,$09, $FB,$FB,$20,$00, $FB,$03,$21,$00
					.db $02,$FA,$30,$00, $02,$02,$31,$00
					.db END

	@@PipeRunning1:		.db $FF,$00,$04,$09, $FB,$FB,$22,$00, $FB,$03,$23,$00
					.db $02,$F9,$32,$00, $02,$01,$33,$00
					.db END

	@@PipeRunning2:		.db $FE,$FF,$04,$09, $FB,$FB,$24,$00, $FB,$03,$25,$00
					.db $02,$F9,$34,$00, $02,$01,$35,$00
					.db END

	@@PipeRunning3:		.db $FF,$00,$04,$09, $FB,$FB,$22,$00, $FB,$03,$23,$00
					.db $02,$F9,$36,$00, $02,$01,$37,$00
					.db END


   @Reversed:
	@@Standing:		.db $FA,$F7,$21,$20, $FA,$FF,$20,$20
					.db $02,$F7,$31,$20, $02,$FF,$30,$20
					.db $FD,$FB,$04,$29, END

	@@Jumping:		.db $FA,$F7,$29,$20, $FA,$FF,$28,$20
					.db $02,$F7,$39,$20, $02,$FF,$38,$20
					.db $FD,$FB,$04,$29, END

	@@Running1:		.db $FA,$F7,$23,$20, $FA,$FF,$22,$20
					.db $02,$F7,$33,$20, $02,$FF,$32,$20
					.db $FE,$FA,$04,$29, END
	@@Running2:		.db $FA,$F7,$25,$20, $FA,$FF,$24,$20
					.db $02,$F7,$35,$20, $02,$FF,$34,$20
					.db $FD,$FB,$04,$29, END
	@@Running3:		.db $FA,$F7,$23,$20, $FA,$FF,$22,$20
					.db $02,$F7,$37,$20, $02,$FF,$36,$20
					.db $FE,$FA,$04,$29, END

	@@Crouching:	.db $FA,$F9,$41,$20, $FA,$01,$40,$20
					.db $02,$F9,$43,$20, $02,$01,$42,$20
					.db $00,$FB,$04,$29, END

	@@Skidding:		.db $FA,$F6,$2B,$20, $FA,$FE,$2A,$20
					.db $02,$F6,$3B,$20, $02,$FE,$3A,$20
					.db $FE,$FC,$2C,$09, END

	@@LookingUp:	.db $FA,$F7,$2A,$28, $FA,$FF,$29,$28
					.db $02,$F7,$28,$28, $02,$FF,$27,$28
					.db $FC,$FB,$2B,$29, END

	@@Shooting:		.db $FA,$F7,$45,$20, $FA,$FF,$44,$20
					.db $02,$F7,$47,$20, $02,$FF,$46,$20
					.db $FD,$FA,$04,$29, END

.ENDS