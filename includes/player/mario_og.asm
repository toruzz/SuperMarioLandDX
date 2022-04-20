.BANK BANK_MARIO_OG SLOT 1
.ORGA $4000
.SECTION "MarioOG sprite" SEMIFREE
   .INCLUDE "./includes/common/print_sprite.s" NAMESPACE "MarioOG"
   .INCLUDE "./includes/common/graphics_player.s" NAMESPACE "MarioOG"
.ENDS

.BANK BANK_MARIO_OG SLOT 1
.SECTION "MarioOG sprites - Pointers" SEMIFREE;FORCE;SIZE $23F OVERWRITE
 MarioOGPointers:
	; Sorry, I didn't feel like this needed a custom tool as it isn't that much data so 
	; I inserted the pointers and values manually. Look at the way GB's OAM works to edit this.

	; This is just the pointers table:
   @Default:
	POINTER MarioOG@Default@Standing		; 00 - Mario

	POINTER MarioOG@Default@Running1		; 01 - Mario running 1 (reversed order looks better with the new graphics)
	POINTER MarioOG@Default@Running2		; 02 - Mario running 2 ("")
	POINTER MarioOG@Default@Running3		; 03 - Mario running 3 ("")

	POINTER MarioOG@Default@Jumping			; 04 - Mario jumping
	POINTER MarioOG@Default@Skidding		; 05 - Mario skidding
	
	POINTER MarioOG@Default					; 06 - Daisy 1?
	POINTER MarioOG@Default					; 07 - Daisy 2?

	POINTER MarioOG@Default					; 08 - ""
	POINTER MarioOG@Default					; 09 - ""

	POINTER MarioOG@Default@MarinePop1		; 10 - Mario submarine 1	($B14C)
	POINTER MarioOG@Default@MarinePop2		; 11 - Mario submarine 2
	POINTER MarioOG@Default@SkyPop1			; 12 - Mario airplane 1
	POINTER MarioOG@Default@SkyPop2			; 13 - Mario airplane 2

	POINTER MarioOG@Default					; 14 - ""
	POINTER MarioOG.Misc@BlockPiece			; 15 - Block pieces?

	POINTER SuperMarioOG@Default@Standing	; 16 - Super Mario
	POINTER SuperMarioOG@Default@Running1	; 17 - Super Mario running 1
	POINTER SuperMarioOG@Default@Running2	; 18 - Super Mario running 2
	POINTER SuperMarioOG@Default@Running3	; 19 - Super Mario running 3
	POINTER SuperMarioOG@Default@Jumping	; 20 - Super Mario jumping
	POINTER SuperMarioOG@Default@Skidding	; 21 - Super Mario skidding	($D54C)

	POINTER MarioOG@Default					; 22 - Unused?
	POINTER MarioOG@Default					; 23 - Daisy
	POINTER SuperMarioOG@Default@Crouching	; 24 - Super Mario crouching
	POINTER SuperMarioOG@Default				; 25 - Super Mario looking up
	POINTER SuperMarioOG@Default@MarinePop1; 26 - Super Mario submarine 1
	POINTER SuperMarioOG@Default@MarinePop2; 27 - Super Mario submarine 2
	POINTER SuperMarioOG@Default@SkyPop1	; 28 - Super Mario airplane 1
	POINTER SuperMarioOG@Default@SkyPop2	; 29 - Super Mario airplane 2

	POINTER MarioOG@Default				; 30 - ""
	POINTER MarioOG@Default				; 31 - ""

	POINTER MarioOG.Daisy@Fly1			; 32 - Fly 1
	POINTER MarioOG.Daisy@Fly2			; 33 - Fly 2
	POINTER MarioOG.Daisy@Standing		; 34 - Daisy standing
	POINTER MarioOG.Daisy@Moving			; 35 - Daisy walking 1?
	POINTER MarioOG.Daisy@Moving1R		; 36 - Daisy walking 2?
	POINTER MarioOG.Daisy@Moving2R		; 37 - Daisy crouching
	POINTER MarioOG.Ending@Ship1			; 38 - Spaceship 1
	POINTER MarioOG.Ending@Ship2			; 39 - Spaceship 2
	POINTER MarioOG.Ending@Ship			; 40 - Spaceship 3
	POINTER MarioOG.Ending@Cloud			; 41 - Cloud
	POINTER MarioOG.Ending@BigCloud		; 42 - Big Cloud
	POINTER MarioOG.Daisy@Standing			; 43 - Removed
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default

	; $3x used for Super while entering a Pipe
	POINTER SuperMarioOG@Default@Standing	; 48=$30
	POINTER SuperMarioOG@Default@Running1
	POINTER SuperMarioOG@Default@Running2
	POINTER SuperMarioOG@Default@Running3
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default

	; $4x used for Super while shooting
	POINTER SuperMarioOG@Default@Shooting		 ; 64=$40
	POINTER SuperMarioOG@Default@Running1
	POINTER SuperMarioOG@Default@Running2
	POINTER SuperMarioOG@Default@Running3
	POINTER SuperMarioOG@Default@Jumping	
	POINTER SuperMarioOG@Default@Skidding	
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default@Crouching
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default@MarinePop1
	POINTER SuperMarioOG@Default@MarinePop2
	POINTER SuperMarioOG@Default@SkyPop1
	POINTER SuperMarioOG@Default@SkyPop2
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default

	; $5x unused. Pointers here just in case
	POINTER SuperMarioOG@Default@Standing	
	POINTER SuperMarioOG@Default@Running1	
	POINTER SuperMarioOG@Default@Running2	
	POINTER SuperMarioOG@Default@Running3	
	POINTER SuperMarioOG@Default@Jumping	
	POINTER SuperMarioOG@Default@Skidding	
	POINTER SuperMarioOG@Default			
	POINTER SuperMarioOG@Default			
	POINTER SuperMarioOG@Default@Crouching
	POINTER SuperMarioOG@Default@Standing
	POINTER SuperMarioOG@Default@MarinePop1
	POINTER SuperMarioOG@Default@MarinePop2
	POINTER SuperMarioOG@Default@SkyPop1	
	POINTER SuperMarioOG@Default@SkyPop2	
	POINTER SuperMarioOG@Default			
	POINTER SuperMarioOG@Default	

   @Reversed:
	POINTER MarioOG@Reversed@Standing		; 00 - Mario
	POINTER MarioOG@Reversed@Running3		; 01 - Mario running 1 (reversed order for new graphics)
	POINTER MarioOG@Reversed@Running2		; 02 - Mario running 2 ("")
	POINTER MarioOG@Reversed@Running1		; 03 - Mario running 3 ("")
	POINTER MarioOG@Reversed@Jumping		; 04 - Mario jumping
	POINTER MarioOG@Reversed@Skidding		; 05 - Mario skidding
	POINTER MarioOG@Reversed				; 06 - Daisy 1?
	POINTER MarioOG@Reversed				; 07 - Daisy 2?

	POINTER MarioOG@Reversed				; 08 - ""
	POINTER MarioOG@Reversed				; 09 - ""

	POINTER MarioOG@Reversed				; 10 - Mario submarine 1	($B14C)
	POINTER MarioOG@Reversed				; 11 - Mario submarine 2
	POINTER MarioOG@Default@SkyPop1				; 12 - Mario airplane 1
	POINTER MarioOG@Default@SkyPop2				; 13 - Mario airplane 2

	POINTER MarioOG@Reversed				; 14 - ""
	POINTER MarioOG.Misc@BlockPieceR				; 15 - ?

	POINTER SuperMarioOG@Reversed@Standing	; 16 - Super Mario
	POINTER SuperMarioOG@Reversed@Running1	; 17 - Super Mario running 1
	POINTER SuperMarioOG@Reversed@Running2	; 18 - Super Mario running 2
	POINTER SuperMarioOG@Reversed@Running3	; 19 - Super Mario running 3
	POINTER SuperMarioOG@Reversed@Jumping	; 20 - Super Mario jumping
	POINTER SuperMarioOG@Reversed@Skidding	; 21 - Super Mario skidding	($D54C)

	POINTER MarioOG@Reversed				; 22 - Unused?
	POINTER MarioOG@Reversed				; 23 - Daisy
	POINTER SuperMarioOG@Reversed@Crouching; 24 - Super Mario crouching

	POINTER SuperMarioOG@Reversed@Standing
	POINTER SuperMarioOG@Default				; $418F
	POINTER SuperMarioOG@Default				; $4191
	POINTER SuperMarioOG@Default				; $4193
	POINTER SuperMarioOG@Default				; $4195
	POINTER SuperMarioOG@Default				; $4197
	POINTER SuperMarioOG@Default				; $4199
				
	POINTER MarioOG.Daisy@Fake1				; $419B
	POINTER MarioOG.Daisy@Fake2				; $419D
	POINTER MarioOG.Daisy@Standing			; $419F - Daisy? (exec. $405C)
	POINTER MarioOG.Daisy@Moving				; 
	POINTER SuperMarioOG@Default@Shooting			; Shooting ball?
	POINTER SuperMarioOG@Default					; Unused
	POINTER SuperMarioOG@Default					; Unused
	POINTER SuperMarioOG@Default					; Unused
	POINTER SuperMarioOG@Default
	POINTER SuperMarioOG@Default@Skidding
	POINTER MarioOG.Ending@BigCloud
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed@Standing
	POINTER SuperMarioOG@Reversed@Running1
	POINTER SuperMarioOG@Reversed@Running2


	; $3x used for Super while entering a Pipe
	POINTER SuperMarioOG@Reversed@Standing
	POINTER SuperMarioOG@Reversed@Running1
	POINTER SuperMarioOG@Reversed@Running2
	POINTER SuperMarioOG@Reversed@Running3
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed

	; $4x used for Super while shooting
	POINTER SuperMarioOG@Reversed@Shooting		 ; 64=$40
	POINTER SuperMarioOG@Reversed@Running1
	POINTER SuperMarioOG@Reversed@Running2
	POINTER SuperMarioOG@Reversed@Running3
	POINTER SuperMarioOG@Reversed@Jumping	
	POINTER SuperMarioOG@Reversed@Skidding	
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed@Crouching
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed

	; $5x unused. Pointers here just in case
	POINTER SuperMarioOG@Reversed@Standing
	POINTER SuperMarioOG@Reversed@Running1
	POINTER SuperMarioOG@Reversed@Running2
	POINTER SuperMarioOG@Reversed@Running3
	POINTER SuperMarioOG@Reversed@Jumping	
	POINTER SuperMarioOG@Reversed@Skidding	
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed@Crouching
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed
	POINTER SuperMarioOG@Reversed

	; Useful link to edit this: http://bgb.bircd.org/pandocs.htm#vramspriteattributetableoam
	; This is the actual data. It works like this for each set of four bytes until it reads $80.
	; Byte 0: Y position
	; Byte 1: X position
	; Byte 2: Tile no. MSB indicates if it's located at VRAM0 or VRAM1
	; Byte 3: Attributes/Flags. Bits 2-0 = palette, Bit 3 = VRAM bank
	; R: flipped horizontally (reversed), F: flipped vertically (flipped)
	
	.INCLUDE "./includes/player/misc/og.s" NAMESPACE "MarioOG"

  MarioOG:
   @Default:
	@@Standing:		.db $FA,$F9,$00,$00, $FA,$01,$01,$00
					.db $02,$F9,$10,$00, $02,$01,$11,$00, END

	@@Running1:		.db $FA,$F9,$02,$00, $FA,$01,$03,$00
					.db $02,$F9,$12,$00, $02,$01,$13,$00, END

	@@Running2:		.db $FA,$F9,$04,$00, $FA,$01,$05,$00
					.db $02,$F9,$14,$00, $02,$01,$15,$00, END

	@@Running3:		.db $FA,$F9,$00,$00, $FA,$01,$01,$00
					.db $02,$F9,$16,$00, $02,$01,$17,$00, END

	@@Jumping:		.db $FB,$F9,$08,$00, $FB,$01,$09,$00
					.db $03,$F9,$18,$00, $03,$01,$19,$00, END

	@@Skidding:		.db $FA,$F9,$0A,$00, $FA,$01,$0B,$00
					.db $02,$F9,$1A,$00, $02,$01,$1B,$00, END

	@@MarinePop1:	.db $FA,$F9,$70,$00, $FA,$01,$71,$00
					.db $02,$F9,$72,$00, $02,$01,$73,$00, END
	@@MarinePop2:	.db $FA,$F9,$70,$00, $FA,$01,$71,$00
					.db $02,$F9,$74,$00, $02,$01,$73,$00, END

	@@SkyPop1:		.db $FA,$F8,$63,$00
					.db $FA,$00,$64,$00
					.db $02,$F8,$65,$00
					.db $02,$00,$66,$00, END


	@@SkyPop2:		.db $FA,$F8,$63,$00
					.db $FA,$00,$64,$00
					.db $02,$F8,$65,$00
					.db $02,$00,$67,$00, END

   @Reversed:
	@@Standing:		.db $FA,$F9,$01,$20, $FA,$01,$00,$20
					.db $02,$F9,$11,$20, $02,$01,$10,$20, END

	@@Running1:		.db $FA,$F9,$03,$20, $FA,$01,$02,$20
					.db $02,$F9,$13,$20, $02,$01,$12,$20, END

	@@Running2:		.db $FA,$F9,$05,$20, $FA,$01,$04,$20
					.db $02,$F9,$15,$20, $02,$01,$14,$20, END

	@@Running3:		.db $FA,$F9,$01,$20, $FA,$01,$00,$20
					.db $02,$F9,$17,$20, $02,$01,$16,$20, END

	@@Jumping:		.db $FB,$F9,$09,$20, $FB,$01,$08,$20
					.db $03,$F9,$19,$20, $03,$01,$18,$20, END

	@@Skidding:		.db $FA,$F9,$0B,$20, $FA,$01,$0A,$20
					.db $02,$F9,$1B,$20, $02,$01,$1A,$20, END

  SuperMarioOG:
   @Default:
	@@Standing:		.db $FA,$F9,$20,$00, $FA,$01,$21,$00,
					.db $02,$F9,$30,$00, $02,$01,$31,$00, END

	@@Jumping:		.db $FA,$F9,$28,$00, $FA,$01,$29,$00,
					.db $02,$F9,$38,$00, $02,$01,$39,$00, END

	@@Running1:		.db $FA,$F9,$22,$00, $FA,$01,$23,$00,
					.db $02,$F9,$32,$00, $02,$01,$33,$00, END

	@@Running2:		.db $FA,$F9,$24,$00, $FA,$01,$25,$00,
					.db $02,$F9,$34,$00, $02,$01,$35,$00, END

	@@Running3:		.db $FA,$F9,$22,$00, $FA,$01,$23,$00,
					.db $02,$F9,$36,$00, $02,$01,$37,$00, END

	@@Crouching:		.db $FA,$F9,$40,$00, $FA,$01,$41,$00,
					.db $02,$F9,$42,$00, $02,$01,$43,$00, END

	@@Skidding:		.db $FA,$F9,$2A,$00, $FA,$01,$2B,$00
					.db $02,$F9,$3A,$00, $02,$01,$3B,$00, END

	@@MarinePop1:	.db $FA,$F9,$75,$00, $FA,$01,$76,$00			;
					.db $02,$F9,$77,$00, $02,$01,$78,$00, END		;
	@@MarinePop2:	.db $FA,$F9,$75,$00, $FA,$01,$76,$00			;
					.db $02,$F9,$79,$00, $02,$01,$78,$00, END		;

	@@SkyPop1:		.db $FA,$F8,$68,$00
					.db $FA,$00,$69,$00
					.db $02,$F8,$6A,$00
					.db $02,$00,$6B,$00, END

	@@SkyPop2:		.db $FA,$F8,$68,$00
					.db $FA,$00,$6C,$00
					.db $02,$F8,$6A,$00
					.db $02,$00,$6D,$00, END

	@@Shooting:		.db $FA,$F9,$44,$00, $FA,$01,$45,$00,
					.db $02,$F9,$46,$00, $02,$01,$47,$00, END

   @Reversed:
	@@Standing:		.db $FA,$F7,$21,$20, $FA,$FF,$20,$20,
					.db $02,$F7,$31,$20, $02,$FF,$30,$20, END

	@@Jumping:		.db $FA,$F7,$29,$20, $FA,$FF,$28,$20,
					.db $02,$F7,$39,$20, $02,$FF,$38,$20, END

	@@Running1:		.db $FA,$F7,$23,$20, $FA,$FF,$22,$20,
					.db $02,$F7,$33,$20, $02,$FF,$32,$20, END

	@@Running2:		.db $FA,$F7,$25,$20, $FA,$FF,$24,$20,
					.db $02,$F7,$35,$20, $02,$FF,$34,$20, END

	@@Running3:		.db $FA,$F7,$23,$20, $FA,$FF,$22,$20,
					.db $02,$F7,$37,$20, $02,$FF,$36,$20, END

	@@Crouching:	.db $FA,$F8,$41,$20, $FA,$00,$40,$20,
					.db $02,$F8,$43,$20, $02,$00,$42,$20, END

	@@Skidding:		.db $FA,$F7,$2B,$20, $FA,$FF,$2A,$20
					.db $02,$F7,$3B,$20, $02,$FF,$3A,$20, END

	@@MarinePop1:	.db $FA,$F9,$75,$02, $FA,$01,$76,$02			;
					.db $02,$F9,$77,$01, $02,$01,$78,$01
					.db $FB,$FD,$24,$08, $F3,$FE,$25,$09, END		;
	@@MarinePop2:	.db $FA,$F9,$75,$02, $FA,$01,$76,$02			;
					.db $02,$F9,$79,$01, $02,$01,$78,$01
					.db $FB,$FD,$24,$08, $F3,$FE,$25,$09, END		;

	@@Shooting:		.db $FA,$F7,$45,$20, $FA,$FF,$44,$20,
					.db $02,$F7,$47,$20, $02,$FF,$46,$20, END


  
.ENDS