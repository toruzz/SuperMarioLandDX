SETREV1 9

	; Cleaning the OAM space used in the title screen:
	ld hl,OAM_Table
	xor a
	ld b,_sizeof_OAM_Table
	@Loop:
	ldi (hl),a
	dec b
	jr nz,@Loop

	; BG PAL to white to avoid artifacts:
	WAITBLANK
	ld b,PALSIZE/2
	ld a,PALINIT
	ldh (<BCPS),a

	@LoopWhite:
	WAITBLANK
	ld a,$FF			; $7FFF: White
	ldh (<BCPD),a		;
	ld a,$7F			;
	ldh (<BCPD),a		;
	dec b
	jr nz,@LoopWhite


	ldh a,(<Level)
	;add b
	cp $11
	call z,InitLevel11
	cp $12
	call z,InitLevel12
	cp $13
	call z,InitLevel13
	cp $21
	call z,InitLevel21
	cp $22
	call z,InitLevel22
	cp $23
	call z,InitLevel23
	cp $31
	call z,InitLevel31
	cp $32
	call z,InitLevel32
	cp $33
	call z,InitLevel33
	cp $41
	call z,InitLevel41
	cp $42
	call z,InitLevel42
	cp $43
	call z,InitLevel43

	call $2439+REVOFFSET		; Original replaced code

 InitLevel:
	WAITBLANK

	; Sprite table initialization:
	ldh a,(<Level)
	and $F0
	cp $10
	jr nz,@NotWorld1
	; World 1:
	ldh a,(<Level)
	cp $12
	jr nz,@NotLevel12
	ld hl,SprTable1b
	jr @TableLoaded
	@NotLevel12:
	ld hl,SprTable
	jr @TableLoaded

	@NotWorld1:
	cp $20
	jr nz,@NotWorld2
	; World 2:
	ld hl,SprTable2
	jr @TableLoaded

	@NotWorld2:
	cp $30
	jr nz,@NotWorld3
	; World 3:
	ldh a,(<Level)
	cp $31
	jr nz, @NotLevel31
	ld hl,SprTable3
	jr @TableLoaded
	@NotLevel31:
	cp $32
	jr nz, @NotLevel32
	ld hl,SprTable3b
	jr @TableLoaded
	@NotLevel32:
	ld hl,SprTable3c
	jr @TableLoaded

	@NotWorld3:
	; World 4:
	ldh a,(<Level)
	cp $41
	jr nz, @NotLevel41
	ld hl,SprTable4
	jr @TableLoaded

	@NotLevel41:
	ld hl,SprTable4b
	
	@TableLoaded:
	ld a,h
	ld (CurSprTable+1),a
	ld a,l
	ld (CurSprTable),a


	SETVRAM 1
	xor a
	ld hl,$9822		; This is lazy and silly
	ldi (hl),a
	ldi (hl),a
	ldi (hl),a

	ldh a,(<Level)
	and $F0
	cp $10
	jr nz,@NotW1

	WRITEDATASAFE Mario.FakeDaisy1GFX $84B0
	SETVRAM 0
	ret

	@NotW1:
	and $F0
	cp $20
	jr nz,@NotW2
	WRITEDATASAFE Mario.FakeDaisy2GFX $84B0
	SETVRAM 0
	ret

	@NotW2:
	WRITEDATASAFE Mario.FakeDaisy3GFX $84B0
	SETVRAM 0
	ret

	FakeDaisy1GFX:	.INCBIN "data\\graphics\\vram1\\fakedaisy_world1.2bpp"
	FakeDaisy2GFX:	.INCBIN "data\\graphics\\vram1\\fakedaisy_world2.2bpp"
	FakeDaisy3GFX:	.INCBIN "data\\graphics\\vram1\\fakedaisy_world3.2bpp"

   CopyDataSafe:
	WAITBLANK
	ldi a,(hl)
	ld (de),a
	inc e
	dec b
	ldi a,(hl)
	ld (de),a
	inc e
	dec b
	jr nz,CopyDataSafe
	ret


	InitLevel11:	BUFFERPALINIT Mario.Level11PAL
	@Attrs:			WRITEDATA Mario.Level11Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel12:	BUFFERPALINIT Mario.Level12PAL
	@Attrs:			WRITEDATA Mario.Level12Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel13:	BUFFERPALINIT Mario.Level13PAL
	@AnimatedTiles:	WRITEDATA AnimatedTiles+ANIMSIZE*0 ANIMSIZE AnimatedTilesBuffer
	@Attrs:			WRITEDATA Mario.Level13Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel21:	BUFFERPALINIT Mario.Level21PAL
	@AnimatedTiles:	WRITEDATA AnimatedTiles+ANIMSIZE*1 ANIMSIZE AnimatedTilesBuffer
	@Attrs:			WRITEDATA Mario.Level21Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel22:	BUFFERPALINIT Mario.Level22PAL
	@AnimatedTiles:	WRITEDATA AnimatedTiles+ANIMSIZE*1 ANIMSIZE AnimatedTilesBuffer
	@Attrs:			WRITEDATA Mario.Level22Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel23:	BUFFERPALINIT Mario.Level23PAL
	@Attrs:			WRITEDATA Mario.Level23Attrs ATTRIBUTES_MAP
	ret

	InitLevel31:	BUFFERPALINIT Mario.Level31PAL
	@Attrs:			WRITEDATA Mario.Level31Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel32:	BUFFERPALINIT Mario.Level32PAL
	@AnimatedTiles:	WRITEDATA AnimatedTiles+ANIMSIZE*2 ANIMSIZE AnimatedTilesBuffer
	@Attrs:			WRITEDATA Mario.Level32Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel33:	BUFFERPALINIT Mario.Level33PAL
	@AnimatedTiles:	WRITEDATA AnimatedTiles+ANIMSIZE*2 ANIMSIZE AnimatedTilesBuffer
	@Attrs:			WRITEDATA Mario.Level33Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel41:	BUFFERPALINIT Mario.Level41PAL
	@Attrs:			WRITEDATA Mario.Level41Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel42:	BUFFERPALINIT Mario.Level42PAL
	@AnimatedTiles:	WRITEDATA AnimatedTiles+ANIMSIZE*3 ANIMSIZE AnimatedTilesBuffer
	@Attrs:			WRITEDATA Mario.Level42Attrs ATTRIBUTES_MAP
	jp Mario.ExitLevelInit

	InitLevel43:	BUFFERPALINIT Mario.Level43PAL
	;@AnimatedTiles:	WRITEDATA AnimatedTiles+$40*1 $40 AnimatedTilesBuffer
	@Attrs:			WRITEDATA Mario.Level43Attrs ATTRIBUTES_MAP

	WRITEDATA Mario.Level11PAL+PALSIZE PALUNIT PAL_CHARBUFFER_UG
	jp Mario.ExitLevelInit

	AnimatedTiles:
	.INCBIN "data\\graphics\\AnimatedTiles.2bpp"

  ExitLevelInit:
	ld a,(GraphicsFlag)
	cp $01
	jr z,@NoFireFlower
	ldh a,(<FireFlower)
	cp $01
	jr nz,@NoFireFlower

	ldh a,(<Level)
	cp $43
	jr z,@NoFireFlower
	
	ld a,$05
	ldh (<DXEventsTrigger),a

	@NoFireFlower:
	ret

 PipePalettes:
	ldh a,(<GameStatus)
	cp $0E				; Game Over
	ret z
	cp $0B
	jr z,@Outside
	cp $02
	jr z,@Outside
	cp $29
	ret z				; Ending scene
	;cp $08
	;call z,UndergroundPAL
	call SetUndergroundPAL
	jr @Underground
	@Outside:
	call RestorePAL
	@Underground:

	ld hl,$FFE6			; $0808: $21 $e6 $ff
	xor a				; $080b: $af
	ld b,$06			; $080c: $06 $06
	@Loop:
	ldi (hl),a			; $080e: $22
	dec b				; $080f: $05
	jr nz,@Loop			; $0810: $20 $fc
	ldh ($A3),a			; $0812: $e0 $a3
	ld ($C0AA),a		; $0814: $ea $aa $c0
	ld a,$40			; $0817: $3e $40
	ldh (<CurDrawTile),a			; $0819: $e0 $e9
	ld b,$14			; $081b: $06 $14
	ret

	; To restore palettes use: WRITEPALS PAL_BUFFER@BG PAL_BUFFER@OBJ
	SetUndergroundPAL:
	WRITEDATA PAL_CHARBUFFER PALUNIT PAL_CHARBUFFER_UG

	ldh a,(<Level)
	cp $43
	jp z,DaisyPalettes@World4

	ld a,(GraphicsFlag)
	swap a
	ld b,a
	
	ld a,(PlayerFlag)
	add b
	cp $11
	jr z,@OldLuigi
	cp $10
	jr z,@OldMario
	cp $01
	jr z,@NewLuigi
	ldh a,(<FireFlower)
	cp $00
	jr nz,@FireMario
	ld hl,UndergroundPALMario
	jr @SetPal
	@NewLuigi:
	ldh a,(<FireFlower)
	cp $00
	jr nz,@FireLuigi
	ld hl,UndergroundPALLuigi
	jr @SetPal
	@OldMario:
	ld hl,UndergroundPALMarioOG
	jr @SetPal
	@OldLuigi:
	ld hl,UndergroundPALLuigiOG
	jr @SetPal
	@FireMario:
	WRITEDATA UndergroundPALMario+PALSIZE PALUNIT PAL_CHARBUFFER
	ld hl,UndergroundPALFireMario
	jr @SetPal
	@FireLuigi:
	WRITEDATA UndergroundPALLuigi+PALSIZE PALUNIT PAL_CHARBUFFER
	ld hl,UndergroundPALFireLuigi

	@SetPal:
	WRITEPALS
	WRITEDATA Mario.UndergroundAttrs ATTRIBUTES_MAP
	ret

	

	UndergroundAttrs:
	.INCBIN "data\\attributes\\UndergroundAttrs.bin"

	RestorePAL:
	ldh a,(<Level)
	cp $43
	jr z,@SkipRestore1
	WRITEDATA PAL_CHARBUFFER_UG PALUNIT PAL_CHARBUFFER
	@SkipRestore1:
	ld a,(GraphicsFlag)
	cp $01
	jr z,@SkipFireCheck
	ldh a,(<FireFlower)
	cp $01
	jr z,@SkipFireCheck

	ldh a,(<Level)
	cp $43
	jr z,@SkipRestore2
	WRITEDATA PAL_CHARBUFFER PALUNIT PAL_BUFFER@OBJ	; Restores player's palette if needed
	@SkipRestore2:

	@SkipFireCheck:
	WRITEPALS PAL_BUFFER
	ldh a,(<Level)
	cp $11
	call z,InitLevel11@Attrs
	cp $12
	call z,InitLevel12@Attrs
	cp $13
	call z,InitLevel13@Attrs
	cp $21
	call z,InitLevel21@Attrs
	cp $22
	call z,InitLevel22@Attrs
	/*cp $23
	call z,InitLevel23@Attrs*/
	cp $31
	call z,InitLevel31@Attrs
	cp $32
	call z,InitLevel32@Attrs
	cp $33
	call z,InitLevel33@Attrs
	cp $41
	call z,InitLevel41@Attrs
	cp $42
	call z,InitLevel42@Attrs

	ret

	UndergroundPALMario:	.INCBIN "data\\palettes\\UndergroundMario.pal"
	UndergroundPALLuigi:	.INCBIN "data\\palettes\\UndergroundLuigi.pal"
	UndergroundPALMarioOG:	.INCBIN "data\\palettes\\UndergroundMarioOG.pal"
	UndergroundPALLuigiOG:	.INCBIN "data\\palettes\\UndergroundLuigiOG.pal"
	UndergroundPALFireMario:
		.INCBIN "data\\palettes\\UndergroundMario.pal" READ PALSIZE
		.INCBIN "data\\palettes\\partials\\Player\\FireMario.pal" READ PALUNIT
		.INCBIN "data\\palettes\\UndergroundMario.pal" SKIP PALSIZE+PALUNIT READ PALUNIT*7
	UndergroundPALFireLuigi:
		.INCBIN "data\\palettes\\UndergroundLuigi.pal" READ PALSIZE
		.INCBIN "data\\palettes\\partials\\Player\\FireLuigi.pal" READ PALUNIT
		.INCBIN "data\\palettes\\UndergroundLuigi.pal" SKIP PALSIZE+PALUNIT READ PALUNIT*7



 MidLevelPals:
 	ldh a,(<GameStatus)		; $29 = ending scene
	cp $29					; 
	jp z,EndingPals

	ldh a,(<Level)
	ld hl,LevelPos+1
	cp $11
	jr nz,@NotLevel11
	; Level 1-1:
	ld a,(hl)
	cp $10
	jp z,@MidLevel11
	jp @Exit
	@NotLevel11:
	cp $12
	jr nz,@NotLevel12
	; Level 1-2:
	ld a,(hl)
	cp $10
	jp z,@MidLevel12
	jp @Exit
	
	@NotLevel12:
	cp $13
	jr nz,@NotLevel13
	; Level 1-3:
	ld a,(hl)
	cp $10
	jp z,@MidLevel13
	jp @Exit

	@NotLevel13:
	cp $21
	jr nz,@NotLevel21
	; Level 2-1:
	ld a,(hl)
	cp $03
	jp z,@MidLevel21Init
	ld a,(hl)
	cp $05
	jp z,@MidLevel21a
	ld a,(hl)
	cp $0D
	jp z,@MidLevel21b
	ld a,(hl)
	cp $10
	jp z,@MidLevel21c
	jp @Exit

	@NotLevel21:
	cp $22
	jr nz,@NotLevel22
	; Level 2-2:
	ld a,(hl)
	cp $03
	jp z,@MidLevel22Init
	ld a,(hl)
	cp $04
	jp z,@MidLevel22
	cp $0D
	jp z,@MidLevel22
	jp @Exit

	@NotLevel22:
	cp $23
	jr nz,@NotLevel23
	; Level 2-3:
	ld a,(hl)
	cp $14
	jp z,@MidLevel23
	jr @Exit

	@NotLevel23:
	cp $31
	jr nz,@NotLevel31
	; Level 3-1:
	ld a,(hl)
	cp $08
	jp z,@MidLevel31a
	cp $16
	jp z,@MidLevel31b
	jr @Exit

	@NotLevel31:
	cp $32
	jr nz,@NotLevel32
	; Level 3-2:
	ld a,(hl)
	cp $07
	jp z,@MidLevel32a
	cp $0F
	jp z,@MidLevel32b
	cp $10
	jp z,@MidLevel32c
	jr @Exit

	@NotLevel32:
	cp $33
	jr nz,@NotLevel33
	; Level 3-3:
	ld a,(hl)
	cp $11
	jp z,@MidLevel33
	jr @Exit

	@NotLevel33:
	cp $41
	jr nz,@NotLevel41
	; Level 4-1:
	ld a,(hl)
	cp $0E
	jp z,@MidLevel41a
	;cp $11
	;jp z,@MidLevel41b
	cp $14
	jp z,@MidLevel41c
	jr @Exit
	
	@NotLevel41:
	cp $42
	jr nz,@NotLevel42
	; Level 4-2:
	ld a,(hl)
	cp $0A
	jp z,@MidLevel42a
	cp $15
	jp z,@MidLevel42b
	jr @Exit

	@NotLevel42:
	cp $43
	jr nz,@Exit
	; Level 4-3:
	ld a,(hl)
	cp $13
	jp z,@MidLevel43a
	cp $14
	jp z,@MidLevel43b
	cp $15
	jp z,@MidLevel43c
	cp $16
	jp z,@MidLevel43d
	cp $17
	jp z,@MidLevel43e
	cp $18
	jp z,@MidLevel43f

	; Level other:
	; ...
	@Exit:
	ld hl,LevelPos+1
	ret

	@MidLevel11:		MIDLEVEL Mario.Level11PAL1
	@MidLevel12:		MIDLEVEL Mario.Level12PAL1
	@MidLevel13:		MIDLEVEL Mario.Level13PAL1

	@MidLevel21Init:	MIDLEVEL Mario.Level21PAL0
	@MidLevel21a:		MIDLEVEL Mario.Level21PAL1
	@MidLevel21b:		MIDLEVEL Mario.Level21PAL1 2
	@MidLevel21c:		MIDLEVEL Mario.Level21PAL2
	
	@MidLevel22Init:	MIDLEVEL Mario.Level22PAL0
	@MidLevel22:		MIDLEVEL Mario.Level22PAL1 2
	
	@MidLevel23:		MIDLEVEL Mario.Level23PAL1
	
	@MidLevel31a:		MIDLEVEL Mario.Level31PAL1
	@MidLevel31b:		MIDLEVEL Mario.Level31PAL2

	@MidLevel32a:		MIDLEVEL Mario.Level32PAL1
	@MidLevel32b:		MIDLEVEL Mario.Level32PAL2
	@MidLevel32c:		MIDLEVEL Mario.Level32PAL3
	
	@MidLevel33:		MIDLEVEL Mario.Level33PAL1
	
	@MidLevel41a:		MIDLEVEL Mario.Level41PAL1 5
	;@MidLevel41b:		MIDLEVEL Mario.Level41PAL2 5
	@MidLevel41c:		MIDLEVEL Mario.Level41PAL 5

	@MidLevel42a:		MIDLEVEL Mario.Level42PAL1
	@MidLevel42b:		MIDLEVEL Mario.Level42PAL2
	
	@MidLevel43a:		MIDLEVEL Mario.Level43PAL1 4
	@MidLevel43b:		MIDLEVEL Mario.Level43PAL2 4
	@MidLevel43c:		MIDLEVEL Mario.Level43PAL3 4
	@MidLevel43d:		MIDLEVEL Mario.Level43PAL4 4
	@MidLevel43e:		MIDLEVEL Mario.Level43PAL5 4
	@MidLevel43f:		MIDLEVEL Mario.Level43PAL6 4

 EndingPals:
	;BUFFERPARTIALPAL World4EndPAL
	;WRITEPARTIALPALS PAL_BUFFER
	ld a,(GraphicsFlag)
	cp $00
	jr z, @@IsNewGraphics
	ld a,(PlayerFlag)
	cp $01
	jr z, @@IsLuigiOG
  @@IsMarioOG:
	ld hl,EndingMarioOGPAL
	jr @@PlayerSet
  @@IsLuigiOG:
	ld hl,EndingLuigiOGPAL
	jr @@PlayerSet

  @@IsNewGraphics:
	ld a,(PlayerFlag)
	cp $01
	jr z, @@IsNotMario

	ldh a,(<FireFlower)
	cp $01
	jr z, @@IsFireMario
  @@IsMario:
	ld hl,EndingMarioPAL
	jr @@PlayerSet

  @@IsFireMario:
	ld hl,EndingFireMarioPAL
	jr @@PlayerSet

  @@IsNotMario:
	ldh a,(<FireFlower)
	cp $01
	jr z, @@IsFireLuigi
  @@IsLuigi:
	ld hl,EndingLuigiPAL
	jr @@PlayerSet

  @@IsFireLuigi:
	ld hl,EndingFireLuigiPAL
	jr @@PlayerSet

  @@PlayerSet:
	WRITEPALS
	WRITEDATA Mario.EndingAttrs ATTRIBUTES_MAP
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
	

 EndingAttrs:	.INCBIN "data\\attributes\\Ending.bin"

 EndingMarioOGPAL:
	.INCBIN "data\\palettes\\partials\\HUD.pal" READ PALUNIT
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALUNIT READ PALSIZE-PALUNIT
	.INCBIN "data\\palettes\\partials\\Player\\MarioOG.pal" READ PALUNIT+4
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALSIZE+PALUNIT+4 READ PALUNIT*7-4
 EndingLuigiOGPAL:
	.INCBIN "data\\palettes\\partials\\HUD.pal" READ PALUNIT
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALUNIT READ PALSIZE-PALUNIT
	.INCBIN "data\\palettes\\partials\\Player\\LuigiOG.pal" READ PALUNIT+4
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALSIZE+PALUNIT+4 READ PALUNIT*7-4
 EndingMarioPAL:
	.INCBIN "data\\palettes\\partials\\HUD.pal" READ PALUNIT
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALUNIT READ PALSIZE-PALUNIT
	.INCBIN "data\\palettes\\partials\\Player\\Mario.pal" READ PALUNIT+4
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALSIZE+PALUNIT+4 READ PALUNIT*7-4
 EndingFireMarioPAL:
	.INCBIN "data\\palettes\\partials\\HUD.pal" READ PALUNIT
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALUNIT READ PALSIZE-PALUNIT
	.INCBIN "data\\palettes\\partials\\Player\\FireMario.pal" READ PALUNIT+4
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALSIZE+PALUNIT+4 READ PALUNIT*7-4
 EndingLuigiPAL:
	.INCBIN "data\\palettes\\partials\\HUD.pal" READ PALUNIT
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALUNIT READ PALSIZE-PALUNIT
	.INCBIN "data\\palettes\\partials\\Player\\Luigi.pal" READ PALUNIT+4
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALSIZE+PALUNIT+4 READ PALUNIT*7-4
 EndingFireLuigiPAL:
	.INCBIN "data\\palettes\\partials\\HUD.pal" READ PALUNIT
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALUNIT READ PALSIZE-PALUNIT
	.INCBIN "data\\palettes\\partials\\Player\\FireLuigi.pal" READ PALUNIT+4
	.INCBIN "data\\palettes\\levels\\world4_end.pal" SKIP PALSIZE+PALUNIT+4 READ PALUNIT*7-4