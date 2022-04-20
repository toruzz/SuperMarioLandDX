.BANK BANK_LUIGI_OG SLOT 1
.ORGA $4000
.SECTION "LuigiOG sprite" SEMIFREE
   .INCLUDE "./includes/common/print_sprite.s" NAMESPACE "LuigiOG"
   .INCLUDE "./includes/common/graphics_player.s" NAMESPACE "LuigiOG"
.ENDS

.BANK BANK_LUIGI_OG SLOT 1
.SECTION "LuigiOG sprites - Pointers" SEMIFREE;FORCE;SIZE $23F OVERWRITE
 LuigiOGPointers:
	; Sorry, I didn't feel like this needed a custom tool as it isn't that much data so 
	; I inserted the pointers and values manually. Look at the way GB's OAM works to edit this.

	; This is just the pointers table:
   @Default:
	POINTER LuigiOG@Default@Standing		; 00 - Luigi

	POINTER LuigiOG@Default@Running1		; 01 - Luigi running 1 (reversed order looks better with the new graphics)
	POINTER LuigiOG@Default@Running2		; 02 - Luigi running 2 ("")
	POINTER LuigiOG@Default@Running3		; 03 - Luigi running 3 ("")

	POINTER LuigiOG@Default@Jumping			; 04 - Luigi jumping
	POINTER LuigiOG@Default@Skidding		; 05 - Luigi skidding
	
	POINTER LuigiOG@Default					; 06 - Daisy 1?
	POINTER LuigiOG@Default					; 07 - Daisy 2?

	POINTER LuigiOG@Default					; 08 - ""
	POINTER LuigiOG@Default					; 09 - ""

	POINTER LuigiOG@Default@MarinePop1		; 10 - Luigi submarine 1	($B14C)
	POINTER LuigiOG@Default@MarinePop2		; 11 - Luigi submarine 2
	POINTER LuigiOG@Default@SkyPop1			; 12 - Luigi airplane 1
	POINTER LuigiOG@Default@SkyPop2			; 13 - Luigi airplane 2

	POINTER LuigiOG@Default					; 14 - ""
	POINTER LuigiOG.Misc@BlockPiece			; 15 - Block pieces?

	POINTER SuperLuigiOG@Default@Standing	; 16 - Super Luigi
	POINTER SuperLuigiOG@Default@Running1	; 17 - Super Luigi running 1
	POINTER SuperLuigiOG@Default@Running2	; 18 - Super Luigi running 2
	POINTER SuperLuigiOG@Default@Running3	; 19 - Super Luigi running 3
	POINTER SuperLuigiOG@Default@Jumping	; 20 - Super Luigi jumping
	POINTER SuperLuigiOG@Default@Skidding	; 21 - Super Luigi skidding	($D54C)

	POINTER LuigiOG@Default					; 22 - Unused?
	POINTER LuigiOG@Default					; 23 - Daisy
	POINTER SuperLuigiOG@Default@Crouching	; 24 - Super Luigi crouching
	POINTER SuperLuigiOG@Default				; 25 - Super Luigi looking up
	POINTER SuperLuigiOG@Default@MarinePop1; 26 - Super Luigi submarine 1
	POINTER SuperLuigiOG@Default@MarinePop2; 27 - Super Luigi submarine 2
	POINTER SuperLuigiOG@Default@SkyPop1	; 28 - Super Luigi airplane 1
	POINTER SuperLuigiOG@Default@SkyPop2	; 29 - Super Luigi airplane 2

	POINTER LuigiOG@Default		; 30 - ""
	POINTER LuigiOG@Default		; 31 - ""

	POINTER LuigiOG.Daisy@Fly1			; 32 - Fly 1
	POINTER LuigiOG.Daisy@Fly2			; 33 - Fly 2
	POINTER LuigiOG.Daisy@Standing		; 34 - Daisy standing

	POINTER LuigiOG.Daisy@Moving			; 35 - Daisy walking 1?
	POINTER LuigiOG.Daisy@Moving1R		; 36 - Daisy walking 2?
	POINTER LuigiOG.Daisy@Moving2R		; 37 - Daisy crouching
	
	POINTER LuigiOG.Ending@Ship1			; 38 - Spaceship 1
	POINTER LuigiOG.Ending@Ship2			; 39 - Spaceship 2
	POINTER LuigiOG.Ending@Ship			; 40 - Spaceship 3

	POINTER LuigiOG.Ending@Cloud			; 41 - Cloud
	POINTER LuigiOG.Ending@BigCloud		; 42 - Big Cloud

	POINTER LuigiOG.Daisy@Standing			; 43 - Removed
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default

	; $3x used for Super while entering a Pipe
	POINTER SuperLuigiOG@Default@Crouching	; 48=$30
	POINTER SuperLuigiOG@Default@Crouching
	POINTER SuperLuigiOG@Default@Crouching
	POINTER SuperLuigiOG@Default@Crouching
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default

	; $4x used for Super while shooting
	POINTER SuperLuigiOG@Default@Shooting		 ; 64=$40
	POINTER SuperLuigiOG@Default@Running1
	POINTER SuperLuigiOG@Default@Running2
	POINTER SuperLuigiOG@Default@Running3
	POINTER SuperLuigiOG@Default@Jumping	
	POINTER SuperLuigiOG@Default@Skidding	
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default@Crouching
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default@MarinePop1
	POINTER SuperLuigiOG@Default@MarinePop2
	POINTER SuperLuigiOG@Default@SkyPop1
	POINTER SuperLuigiOG@Default@SkyPop2
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default

	; $5x unused. Pointers here just in case
	POINTER SuperLuigiOG@Default@Standing	
	POINTER SuperLuigiOG@Default@Running1	
	POINTER SuperLuigiOG@Default@Running2	
	POINTER SuperLuigiOG@Default@Running3	
	POINTER SuperLuigiOG@Default@Jumping	
	POINTER SuperLuigiOG@Default@Skidding	
	POINTER SuperLuigiOG@Default			
	POINTER SuperLuigiOG@Default			
	POINTER SuperLuigiOG@Default@Crouching
	POINTER SuperLuigiOG@Default@Standing
	POINTER SuperLuigiOG@Default@MarinePop1
	POINTER SuperLuigiOG@Default@MarinePop2
	POINTER SuperLuigiOG@Default@SkyPop1	
	POINTER SuperLuigiOG@Default@SkyPop2	
	POINTER SuperLuigiOG@Default			
	POINTER SuperLuigiOG@Default	

   @Reversed:
	POINTER LuigiOG@Reversed@Standing		; 00 - Luigi
	POINTER LuigiOG@Reversed@Running3		; 01 - Luigi running 1 (reversed order for new graphics)
	POINTER LuigiOG@Reversed@Running2		; 02 - Luigi running 2 ("")
	POINTER LuigiOG@Reversed@Running1		; 03 - Luigi running 3 ("")
	POINTER LuigiOG@Reversed@Jumping		; 04 - Luigi jumping
	POINTER LuigiOG@Reversed@Skidding		; 05 - Luigi skidding
	POINTER LuigiOG@Reversed				; 06 - Daisy 1?
	POINTER LuigiOG@Reversed				; 07 - Daisy 2?

	POINTER LuigiOG@Reversed				; 08 - ""
	POINTER LuigiOG@Reversed				; 09 - ""

	POINTER LuigiOG@Reversed				; 10 - Luigi submarine 1	($B14C)
	POINTER LuigiOG@Reversed				; 11 - Luigi submarine 2
	POINTER LuigiOG@Default@SkyPop1				; 12 - Luigi airplane 1
	POINTER LuigiOG@Default@SkyPop2				; 13 - Luigi airplane 2

	POINTER LuigiOG@Reversed				; 14 - ""
	POINTER LuigiOG.Misc@BlockPieceR				; 15 - ?

	POINTER SuperLuigiOG@Reversed@Standing	; 16 - Super Luigi
	POINTER SuperLuigiOG@Reversed@Running1	; 17 - Super Luigi running 1
	POINTER SuperLuigiOG@Reversed@Running2	; 18 - Super Luigi running 2
	POINTER SuperLuigiOG@Reversed@Running3	; 19 - Super Luigi running 3
	POINTER SuperLuigiOG@Reversed@Jumping	; 20 - Super Luigi jumping
	POINTER SuperLuigiOG@Reversed@Skidding	; 21 - Super Luigi skidding	($D54C)

	POINTER LuigiOG@Reversed				; 22 - Unused?
	POINTER LuigiOG@Reversed				; 23 - Daisy
	POINTER SuperLuigiOG@Reversed@Crouching; 24 - Super Luigi crouching

	POINTER SuperLuigiOG@Reversed@Standing
	POINTER SuperLuigiOG@Default				; $418F
	POINTER SuperLuigiOG@Default				; $4191
	POINTER SuperLuigiOG@Default				; $4193
	POINTER SuperLuigiOG@Default				; $4195
	POINTER SuperLuigiOG@Default				; $4197
	POINTER SuperLuigiOG@Default				; $4199
				
	POINTER LuigiOG.Daisy@Fake1				; $419B
	POINTER LuigiOG.Daisy@Fake2				; $419D
	POINTER LuigiOG.Daisy@Standing			; $419F - Daisy? (exec. $405C)
	POINTER LuigiOG.Daisy@Moving				; 
	POINTER SuperLuigiOG@Default@Shooting			; Shooting ball?
	POINTER SuperLuigiOG@Default					; Unused
	POINTER SuperLuigiOG@Default					; Unused
	POINTER SuperLuigiOG@Default					; Unused
	POINTER SuperLuigiOG@Default
	POINTER SuperLuigiOG@Default@Skidding
	POINTER LuigiOG.Ending@BigCloud
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed@Standing
	POINTER SuperLuigiOG@Reversed@Running1
	POINTER SuperLuigiOG@Reversed@Running2


	; $3x used for Super while entering a Pipe
	POINTER SuperLuigiOG@Reversed@Standing
	POINTER SuperLuigiOG@Reversed@Running1
	POINTER SuperLuigiOG@Reversed@Running2
	POINTER SuperLuigiOG@Reversed@Running3
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed

	; $4x used for Super while shooting
	POINTER SuperLuigiOG@Reversed@Shooting		 ; 64=$40
	POINTER SuperLuigiOG@Reversed@Running1
	POINTER SuperLuigiOG@Reversed@Running2
	POINTER SuperLuigiOG@Reversed@Running3
	POINTER SuperLuigiOG@Reversed@Jumping	
	POINTER SuperLuigiOG@Reversed@Skidding	
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed@Crouching
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed

	; $5x unused. Pointers here just in case
	POINTER SuperLuigiOG@Reversed@Standing
	POINTER SuperLuigiOG@Reversed@Running1
	POINTER SuperLuigiOG@Reversed@Running2
	POINTER SuperLuigiOG@Reversed@Running3
	POINTER SuperLuigiOG@Reversed@Jumping	
	POINTER SuperLuigiOG@Reversed@Skidding	
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed@Crouching
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed
	POINTER SuperLuigiOG@Reversed

	; Useful link to edit this: http://bgb.bircd.org/pandocs.htm#vramspriteattributetableoam
	; This is the actual data. It works like this for each set of four bytes until it reads $80.
	; Byte 0: Y position
	; Byte 1: X position
	; Byte 2: Tile no. MSB indicates if it's located at VRAM0 or VRAM1
	; Byte 3: Attributes/Flags. Bits 2-0 = palette, Bit 3 = VRAM bank
	; R: flipped horizontally (reversed), F: flipped vertically (flipped)
	
	.INCLUDE "./includes/player/misc/og.s" NAMESPACE "LuigiOG"

  LuigiOG:
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

  SuperLuigiOG:
   @Default:
	@@Standing:		.db $FA,$F9,$20,$00, $FA,$01,$21,$00,
					.db $02,$F9,$30,$00, $02,$01,$31,$00
					.db $F2,$FC,$84,$08, END

	@@Jumping:		.db $FA,$F9,$28,$00, $FA,$01,$29,$00,
					.db $02,$F9,$38,$00, $02,$01,$39,$00, END

	@@Running1:		.db $FA,$F9,$22,$00, $FA,$01,$23,$00,
					.db $02,$F9,$32,$00, $02,$01,$33,$00, END

	@@Running2:		.db $FA,$F9,$24,$00, $FA,$01,$25,$00,
					.db $02,$F9,$34,$00, $02,$01,$35,$00
					.db $F2,$FC,$84,$08, END

	@@Running3:		.db $FA,$F9,$22,$00, $FA,$01,$23,$00,
					.db $02,$F9,$36,$00, $02,$01,$37,$00, END

	@@Crouching:	.db $FA,$F9,$40,$00, $FA,$01,$41,$00,
					.db $02,$F9,$42,$00, $02,$01,$43,$00, END

	@@Skidding:		.db $FA,$F9,$2A,$00, $FA,$01,$2B,$00
					.db $02,$F9,$3A,$00, $02,$01,$3B,$00
					.db $F2,$FC,$84,$08, END

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
					.db $02,$F7,$31,$20, $02,$FF,$30,$20
					.db $F2,$FB,$84,$08, END

	@@Jumping:		.db $FA,$F7,$29,$20, $FA,$FF,$28,$20,
					.db $02,$F7,$39,$20, $02,$FF,$38,$20, END

	@@Running1:		.db $FA,$F7,$23,$20, $FA,$FF,$22,$20,
					.db $02,$F7,$33,$20, $02,$FF,$32,$20, END

	@@Running2:		.db $FA,$F7,$25,$20, $FA,$FF,$24,$20,
					.db $02,$F7,$35,$20, $02,$FF,$34,$20
					.db $F2,$FB,$84,$08, END

	@@Running3:		.db $FA,$F7,$23,$20, $FA,$FF,$22,$20,
					.db $02,$F7,$37,$20, $02,$FF,$36,$20, END

	@@Crouching:	.db $FA,$F8,$41,$20, $FA,$00,$40,$20,
					.db $02,$F8,$43,$20, $02,$00,$42,$20, END

	@@Skidding:		.db $FA,$F7,$2B,$20, $FA,$FF,$2A,$20
					.db $02,$F7,$3B,$20, $02,$FF,$3A,$20
					.db $F2,$FB,$84,$08, END

	@@MarinePop1:	.db $FA,$F9,$75,$02, $FA,$01,$76,$02			;
					.db $02,$F9,$77,$01, $02,$01,$78,$01
					.db $FB,$FD,$24,$08, $F3,$FE,$25,$09, END		;
	@@MarinePop2:	.db $FA,$F9,$75,$02, $FA,$01,$76,$02			;
					.db $02,$F9,$79,$01, $02,$01,$78,$01
					.db $FB,$FD,$24,$08, $F3,$FE,$25,$09, END		;

	@@Shooting:		.db $FA,$F7,$45,$20, $FA,$FF,$44,$20,
					.db $02,$F7,$47,$20, $02,$FF,$46,$20, END


  
.ENDS