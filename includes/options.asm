
.BANK 0 SLOT 0
.ORG $03F0
.SECTION "OptionsMenuPrint Hook" OVERWRITE
	call OptionsMenuPrint
.ENDS
.BANK 2 SLOT 1
.SECTION "OptionsMenuPrint" FREE
	OptionsMenuPrint:
	ld a,(Continues)
	and a
	ret nz
	push hl
	ld b,$07
	ld hl,$99C6
	ld de,OptionsText
	jr @Loop
	@Continue:
	
	@Loop:
	ld a,(de)
	ldi (hl),a
	inc de
	dec b
	jr nz,@Loop

	ld a,(PlayerFlag)
	cp $01
	jr z,@Luigi
	@Mario:
	WRITEDATA Init.MarioSpriteData OAM_Enemies-4
	jr @SetPlayerFlag
	@Luigi:
	WRITEDATA Init.LuigiSpriteData OAM_Enemies-4

  @SetPlayerFlag:
	call ApplyOptionsAttrsInit
	pop hl
	ld a,(Continues)
	ret
.ENDS
.SECTION "OptionsMenuPrint Data" FREE
	OptionsText:	.ASC "OPTIONS"

  ApplyOptionsAttrsInit:
	.INCLUDE "./includes/common/apply_options_attrs.s" NAMESPACE "Init"
.ENDS


.BANK 0 SLOT 0
.ORG $0446
.SECTION "Continue Text" OVERWRITE
	ContinueText:	.ASC "CONTINUE x"
.ENDS
.BANK 0 SLOT 0
.ORG $04B8
.SECTION "Allow OptionsMenuSelection" OVERWRITE
	jp SelectPressed
	PADDING 2
	SelectPressedContinue:
.ENDS
.ORG $0450
.SECTION "Press Start on MenuSelection" OVERWRITE
 StartPressed:
	ld a,(OAM_Table.2)
	//cp $78				; Cursor on START position
	//jr z,@NewGame
	jp CheckIfOptions
	@Continue:
	ld a,(Continues)
	dec a
	ld (Continues),a
	ld a,(LastLevel)
	ldh (<Level),a
	ld e,$00
	cp $11
	jr z,@SetLevel
	inc e
	cp $12
	jr z,@SetLevel
	inc e
	cp $13
	jr z,@SetLevel
	inc e
	cp $21
	jr z,@SetLevel
	inc e
	cp $22
	jr z,@SetLevel
	inc e
	cp $23
	jr z,@SetLevel
	inc e
	cp $31
	jr z,@SetLevel
	inc e
	cp $32
	jr z,@SetLevel
	inc e
	cp $33
	jr z,@SetLevel
	inc e
	cp $41
	jr z,@SetLevel
	inc e
	cp $42
	jr z,@SetLevel
	inc e
 @SetLevel:
	ld a,e
 @SetLevel_A:
	ldh (<LevelPos),a
	jp LevelStart
 @NewGame:
	xor a
	ld (Continues),a
	ldh a,(<HardMode)
	cp $02
	jp nc,LevelStart
	ld a,$11
	ldh (<Level),a
	xor a
	jr @SetLevel_A
.ENDS

.SECTION "Checks if continue or options" FREE
 CheckIfOptions:
	cp a,$78				; Cursor on START position
	jp z,StartPressed@NewGame
	ld a,(Continues)
	cp $00					; Check if no continues
	jp nz,StartPressed@Continue
	ld a,$30
	ld (DemoPlayTimer),a
	ld a,(OptionsFlag)
	cp $00
	jr z,@OpenOptions
	@CloseOptions:
	xor a
	jr @SetFlag
	@OpenOptions:
	ld a,$FF
	@SetFlag:
	ld (OptionsFlag),a
	FARCALL OptionsMenu
	ret
.ENDS

.BANK BANK_INIT SLOT 1
.SECTION "OptionsMenu" FREE

 OptionsMenu:
	ld a,(OptionsFlag)
	cp $00
	jp z,@Close

 	push hl
	ld de,OptionsGFX@RowInit
	ld hl,$9901
	call @CopyRow
	ld de,OptionsGFX@RowGraphics
	ld hl,$9921
	call @CopyRow
	ld de,OptionsGFX@RowEmpty
	ld hl,$9941
	call @CopyRow
	ld de,OptionsGFX@RowPlayer
	ld hl,$9961
	call @CopyRow
	ld de,OptionsGFX@RowEmpty
	ld hl,$9981
	call @CopyRow
	ld de,OptionsGFX@RowMode
	ld hl,$99A1
	call @CopyRow
	ld de,OptionsGFX@RowFinal
	ld hl,$99C1
	call @CopyRow

	call DrawOptions1
	call DrawOptions2
	call DrawOptions3

	SETVRAM 1
	WAITBLANK

	ld hl,$9901
	call @ApplyAttr06
	ld hl,$9921
	call @ApplyAttr06
	ld hl,$9941
	call @ApplyAttr06
	ld hl,$9961
	call @ApplyAttr06
	ld hl,$9981
	call @ApplyAttr06
	ld hl,$99A1
	call @ApplyAttr06
	ld hl,$99C1
	call @ApplyAttr06
	WAITBLANK ; WAITVBLANK

	; Fixes BG priority so the arrow can be seen:
	ld a,$06
	ld ($9924),a
	ld ($9925),a
	ld ($9964),a
	ld ($9965),a
	ld ($99A4),a
	ld ($99A5),a
	
	SETVRAM 0
	WAITBLANK
	
	ld a,(OAM_Table.2.attrs)
	ldh (<DXAux),a

	; Moves pointer, hides other sprites:
	ld a,$57
	ld (OAM_Table.2.posY),a
	ld a,$2D
	ld (OAM_Table.2.posX),a
	ld a,$AF
	ld (OAM_Table.2.tile),a
	xor a
	ld (OAM_Table.2.attrs),a

	ld a,(OAM_Table.3.posY)
	cp $00
	jr nz,@PlayerInitialized

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

	;ld hl,@MarioSprite
	@NewMario:
	ld a,(ModeFlag)
	cp $01
	jr z,@NewMarioHard
	ld hl,@MarioData@Sprite
	jr @GFXset
	@NewMarioHard:
	ld hl,@MarioData@Sprite2
	jr @GFXset

	@NewLuigi:
	ld a,(ModeFlag)
	cp $01
	jr z,@LuigiDataHard
	ld hl,@LuigiData@Sprite
	jr @GFXset
	@LuigiDataHard:
	ld hl,@LuigiData@Sprite2
	jr @GFXset

	@OldMario:
	ld a,(ModeFlag)
	cp $01
	jr z,@OldMarioHard
	ld hl,@MarioOGData@Sprite
	jr @GFXset
	@OldMarioHard:
	ld hl,@MarioOGData@Sprite2
	jr @GFXset

	@OldLuigi:
	ld a,(ModeFlag)
	cp $01
	jr z,@OldLuigiHard
	ld hl,@LuigiOGData@Sprite
	jr @GFXset
	@OldLuigiHard:
	ld hl,@LuigiOGData@Sprite2

	@GFXset:
	ld de,OAM_Table.3.posY
	ld b,$1C
	@@Loop:
	ldi a,(hl)
	ld (de),a
	inc de
	dec b
	jr nz,@@Loop
	@PlayerInitialized:

	pop hl
	ret



 @MarioData:
	@@Palette:
	.INCBIN "data\\palettes\\partials\\Titlescreen\\Mario.pal"
	@@Sprite:
	.db $64,$16,$60,$06
	.db $64,$1E,$61,$06
	.db $6C,$16,$70,$06
	.db $6C,$1E,$71,$06
	.db $66,$19,$68,$00
	.db $6E,$19,$78,$00
	.db $6E,$21,$79,$00
	@@Sprite2:
	.db $64,$16,$64,$06
	.db $64,$1E,$65,$06
	.db $6C,$16,$74,$06
	.db $6C,$1E,$75,$06
	.db $66,$19,$68,$00
	.db $6E,$19,$78,$00
	.db $6E,$21,$79,$00

  @MarioOGData:
	@@Palette:
	.db         $BF,$3A,$5A,$08,$ED,$00
	.db $BF,$62,$1D,$10,$84,$61,$35,$05

	@@Sprite:
	.db $64,$16,$6E,$06
	.db $64,$1E,$6F,$06
	.db $6C,$16,$7E,$06
	.db $6C,$1E,$7F,$06
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00
	@@Sprite2:
	.db $64,$16,$6C,$06
	.db $64,$1E,$6D,$06
	.db $6C,$16,$7C,$06
	.db $6C,$1E,$7D,$06
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00

  @LuigiData:
	@@Palette:
	.INCBIN "data\\palettes\\partials\\Titlescreen\\Luigi.pal"
	@@Sprite:
	.db $64,$16,$62,$06
	.db $64,$1E,$63,$06
	.db $6C,$16,$72,$06
	.db $6C,$1E,$73,$06
	.db $65,$19,$68,$00
	.db $6E,$19,$7A,$00
	.db $61,$1D,$69,$00
	@@Sprite2:
	.db $64,$16,$66,$06
	.db $64,$1E,$67,$06
	.db $6C,$16,$76,$06
	.db $6C,$1E,$77,$06
	.db $65,$19,$68,$00
	.db $6E,$19,$7A,$00
	.db $61,$1D,$69,$00
  
  @LuigiOGData:
	@@Palette:
	.db         $7C,$32,$80,$02,$2A,$01
	.db $BF,$62,$A2,$26,$45,$49,$35,$09

	@@Sprite:
	.db $64,$16,$4E,$06
	.db $64,$1E,$4F,$06
	.db $6C,$16,$5E,$06
	.db $6C,$1E,$5F,$06
	.db $5C,$16,$3E,$06
	.db $5C,$1E,$3F,$06
	.db $00,$00,$00,$00
	@@Sprite2:
	.db $64,$16,$40,$0E
	.db $64,$1E,$41,$0E
	.db $6C,$16,$42,$0E
	.db $6C,$1E,$43,$0E
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00
	.db $00,$00,$00,$00



   @Close:
	push hl
	ld de,TitleScreenTiles+$101
	ld hl,$9901
	call @CopyRow
	ld de,TitleScreenTiles+$121
	ld hl,$9921
	call @CopyRow
	ld de,TitleScreenTiles+$141
	ld hl,$9941
	call @CopyRow
	ld de,TitleScreenTiles+$161
	ld hl,$9961
	call @CopyRow
	ld de,TitleScreenTiles+$181
	ld hl,$9981
	call @CopyRow
	ld de,TitleScreenTiles+$1A1
	ld hl,$99A1
	call @CopyRow
	ld de,OptionsGFX@InitLastRow
	ld hl,$99C1
	call @CopyRow

	SETVRAM 1
	ld de,TitleScreenAttrs+$101
	ld hl,$9901
	call @ApplyAttr
	ld de,TitleScreenAttrs+$121
	ld hl,$9921
	call @ApplyAttr
	ld de,TitleScreenAttrs+$141
	ld hl,$9941
	call @ApplyAttr
	ld de,TitleScreenAttrs+$161
	ld hl,$9961
	call @ApplyAttr
	ld de,TitleScreenAttrs+$181
	ld hl,$9981
	call @ApplyAttr
	ld de,TitleScreenAttrs+$1A1
	ld hl,$99A1
	call @ApplyAttr
	ld de,TitleScreenAttrs+$1C1
	ld hl,$99C1
	call @ApplyAttr
	SETVRAM 0
	
	ld a,$80
	ld (OAM_Table.2.posY),a
	ld a,$28
	ld (OAM_Table.2.posX),a
	ld a,$AC
	ld (OAM_Table.2.tile),a

	ldh a,(<DXAux)
	ld (OAM_Table.2.attrs),a

	;ld a,$04
	;ld (OAM_Table.2.attrs),a

	;ld a,($8AC0)	; Reading the actual graphic. Not the best way, but it works
	;cp $3C
	;jr nz,@@MarioPointer
	;ld a,$01
	;jr @@MushroomPointer
	;@@MarioPointer:
	;ld a,$04
	;@@MushroomPointer:
	;ld (OAM_Table.2.attrs),a

	;xor a
	;ld hl,OAM_Table.3.posY
	;ld b,$1C
	;@@Loop:
	;ldi (hl),a
	;dec b
	;jr nz,@@Loop

	ld a,(SavedScore)
	ld b,a
	ld a,(SavedScore+1)
	add b
	ld b,a
	ld a,(SavedScore+2)
	add b
	cp $00
	jr z,@EmptyTopScore

	WAITBLANK
	ld c,$03
	ld a,($A408)
	ld de,$A408
	ld hl,$996A
	call $3F75			; +REVOFFSET = $3F63?

	@EmptyTopScore:
	
	pop hl
	ret


 @CopyRow:
 	ld b,$12
	@Loop:
	WAITBLANK
	ld a,(de)
	ldi (hl),a
	inc de
	dec b
	jr nz,@Loop
	ret
 @ApplyAttr06:
	ld b,$12
	@@Loop:
 	WAITBLANK
	ld a,$86
	ldi (hl),a
	dec b
	jr nz,@@Loop
	ret
 @ApplyAttr:
	ld b,$12
	@@Loop:
 	WAITBLANK
	ld a,(de)
	ldi (hl),a
	inc de
	dec b
	jr nz,@@Loop
	ret


  DrawOptions1:
  	WAITBLANK ; WAITVBLANK
	ld a,(GraphicsFlag)
	cp $00
	jr nz,@OldGraphics
   @NewGraphics:
	ld a,$DD
	jr @SetGraphicsFlag
   @OldGraphics:
	ld a,$EC
   @SetGraphicsFlag:
	ld hl,$992E
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	ret

  DrawOptions2:
  	WAITBLANK ; WAITVBLANK
	ld hl,$996C
	ld a,(PlayerFlag)
	cp $00
	jr nz,@Luigi
   @Mario:
	ld a,$F0
	ldi (hl),a
	inc a
	jr @SetPlayerFlag
   @Luigi:
	ld a,$FF
	ldi (hl),a
	inc a
	ld a,$FB
   @SetPlayerFlag:
	
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	ret


  DrawOptions3:
  	WAITBLANK ; WAITVBLANK
  	
	ld hl,$99AB
	ld a,(ModeFlag)
	cp $00
	jr nz,@Hard
   @Normal:
	ld a,$F5
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	jr @SetPlayerFlag
   @Hard:
   	ld a,$FF
	ldi (hl),a
	ldi (hl),a
	ld a,$E8
   @SetPlayerFlag:
	
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	ret

 OptionsGFX:
  @RowInit:
	.db $BA,$BB,$BB,$BC,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BE
  @RowEmpty:
	.db $BF,$C7,$C7,$C6,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$C5
  @RowFinal:
	.db $C0,$C1,$C1,$C2,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C4

  @RowGraphics:
	;.db $BF,$C7,$C7,$C6,$FF,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$FF,$DD,$DE,$DF,$FF,$C5
	.db $BF,$C7,$C7,$C6,$FF,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$FF,$FF,$FF,$FF,$FF,$C5
  ;@RowGraphics2:
	;.db $BF,$C7,$C7,$C6,$FF,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$FF,$EC,$ED,$EF,$FF,$C5
	;.db $BF,$C7,$C7,$C6,$FF,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$FF,$EC,$ED,$EF,$FF,$C5
  @RowPlayer:
	;.db $BF,$C7,$C7,$C6,$FF,$D7,$D8,$D9,$DA,$DB,$DC,$F0,$F1,$F2,$F3,$F4,$FF,$C5
	.db $BF,$C7,$C7,$C6,$FF,$D7,$D8,$D9,$DA,$DB,$DC,$FF,$FF,$FF,$FF,$FF,$FF,$C5
  ;@RowPlayer2:
	;.db $BF,$C7,$C7,$C6,$FF,$D7,$D8,$D9,$DA,$DB,$DC,$FF,$FB,$FC,$FD,$FE,$FF,$C5
  @RowMode:
	;.db $BF,$C7,$C7,$C6,$FF,$E0,$E1,$E2,$E3,$FF,$F5,$F6,$F7,$F8,$F9,$FA,$FF,$C5
	.db $BF,$C7,$C7,$C6,$FF,$E0,$E1,$E2,$E3,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$C5

  @InitLastRow:
	.db $2C,$2C,$2C,$2C,$2C,$D8,$D9,$DD,$D2,$D8,$D7,$DC,$2C,$2C,$2C,$2C,$2C,$2C
.ENDS

.BANK 0 SLOT 0
.ORG $051E
.SECTION "Prevent demo on options menu hook0" OVERWRITE
	ld a,(OptionsFlag)
	cp $FF
	ret z
	call PreventDemoHook
	ld d,$00
.ENDS
SETREV1 23
.BANK 2 SLOT 1
.SECTION "Prevent demo on options menu hook" FREE
	PreventDemoHook:
	GOTO PreventDemo
	PreventDemoEnded:
	ld hl,$0552+REVOFFSET
	ret
.ENDS
.BANK BANK_ROUTINES SLOT 1
.SECTION "Prevent demo on options menu" FREE
	PreventDemo:
	ld a,($C0DC)
	sla a
	ld e,a

	ld a,(GraphicsFlag)
	ld (GraphicsFlagDemo),a
	ld a,(PlayerFlag)
	ld (PlayerFlagDemo),a
	ld a,(ModeFlag)
	ld (ModeFlagDemo),a
	ldh a,(<CurPlayerBank)
	ld (CurPlayerBankDemo),a

	xor a
	ld (GraphicsFlag),a
	ld (PlayerFlag),a
	ld (ModeFlag),a

	ld a,$08
	ldh (<CurPlayerBank),a

	GOTO PreventDemoEnded
.ENDS
.BANK 0 SLOT 0
.ORG $0288
.SECTION "Restore options after demo ended hook" OVERWRITE SIZE 11
	GOTO RestoreDemo
	PADDING 3
	RestoreDemoEnded:
.ENDS
.BANK BANK_ROUTINES SLOT 1
.SECTION "Restore options after demo ended" FREE
	RestoreDemo:
	
	ld a,(GraphicsFlagDemo)
	ld (GraphicsFlag),a
	ld a,(PlayerFlagDemo)
	ld (PlayerFlag),a
	ld a,(ModeFlagDemo)
	ld (ModeFlag),a
	ld a,(CurPlayerBankDemo)
	ldh (<CurPlayerBank),a

	xor a
	ld (GraphicsFlagDemo),a
	ld (PlayerFlagDemo),a
	ld (ModeFlagDemo),a

	ld a,$0E
	ldh (<GameStatus),a

	GOTO 2 RestoreDemoEnded
.ENDS

.BANK 2 SLOT 1
.SECTION "Select Pressed on options menu" FREE
 SelectPressed:
	ld hl,OAM_Table.2.posY
	ld a,(OptionsFlag)
	cp $FF
	jp nz,SelectPressedContinue
	
	ld a,(hl)
	cp $57
	jp z,@Option2
	cp $67
	jp z,@Option3

	@Option1:
	ld a,$57
	ld (OAM_Table.2.posY),a
	ret
	@Option2:
	ld a,$67
	ld (OAM_Table.2.posY),a
	ret
	@Option3:
	ld a,$77
	ld (OAM_Table.2.posY),a
	ret
.ENDS

.BANK 0 SLOT 0
.ORG $04CE
.SECTION "Press B on Selection Menu Hook" OVERWRITE SIZE $2A
	PressBButtonHook:
	push bc
	FARCALL PressBButton
	pop bc
	@Continue:
	ldh a,(<HardMode)
	cp $02
	jp c,$0519
	bit 0,b
	jr z,@SkipPaddingNoLevelPos

	PADDING 3
	@SkipPadding:
	;ldh (<LevelPos),a
	PADDING 2
	@SkipPaddingNoLevelPos:
	ld hl,$C094		; Level selection numbers GFX realloc
.ENDS

;.BANK 2 SLOT 1
.BANK BANK_INIT SLOT 1
.SECTION "Press B on Selection Menu" FREE
 PressBButton:
	bit 1,b
	ret z			; Not pressing B Button

	ld a,$28
	ld (DemoPlayTimer),a

	ld a,(OptionsFlag)
	cp $00
	jp z,MenuChangeLevel
	ld a,(OAM_Table.2.posY)
	cp $57
	jp z,MenuChangeGraphicsMode
	cp $67
	jp z,MenuChangePlayer
	cp $77
	jp z,MenuChangeDifficulty
	ret

.ENDS
.SECTION "Press B on Selection Menu 2" FREE
 MenuChangeLevel:
 	ld a,(SaveTimesCompleted)
	cp $02
	ret c
	;jp c,$0519

	ldh a,(<Level)
	inc a
	ld b,a
	and $0F
	cp $04
	ld a,b
	jr nz,@NextWorld
	add $0D
  @NextWorld:
	ldh (<Level),a
	ldh a,(<LevelPos)
	inc a
	ldh (<LevelPos),a
	cp $0C
	;jr nz,@NoOverflow
	ret nz
	ld a,$11
	ldh (<Level),a
	xor a
	ldh (<LevelPos),a
	ret

 MenuChangeGraphicsMode:
	ld a,(OptionsFlag)
	cp $FF
	ret nz

	WAITBLANK
	ld a,(GraphicsFlag)
	cp $00
	jr z,@OldGraphics
  @NewGraphics:
  	xor a
	ld (GraphicsFlag),a
	ld a,$DD
	jr @SetGraphicsFlag
  @OldGraphics:
	ld a,$01
	ld (GraphicsFlag),a
	ld a,$EC
  @SetGraphicsFlag:
	ld hl,$992E
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	call ApplyOptionsAttrs
	ret

 MenuChangePlayer:
	ld a,(OptionsFlag)
	cp $FF
	ret nz

	ld a,(PlayerFlag)
	cp $00
	jr z,@Luigi
  @Mario:
  	xor a
	ld (PlayerFlag),a


	WRITEDATA MarioSpriteData OAM_Enemies-4
	WAITBLANK ; WAITVBLANK

	ld a,$F0
	ld hl,$996C
	ldi (hl),a
	inc a
	jr @SetPlayerFlag
  @Luigi:
	ld a,$01
	ld (PlayerFlag),a
   
	WRITEDATA LuigiSpriteData OAM_Enemies-4
	WAITBLANK ; WAITVBLANK
	
	ld a,$FF
	ld hl,$996C
	ldi (hl),a
	inc a
	ld a,$FB
  @SetPlayerFlag:
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	call ApplyOptionsAttrs
	ret
	
 MenuChangeDifficulty:
	ld a,(OptionsFlag)
	cp $FF
	ret nz

	WAITBLANK
	ld hl,$99AB
	ld a,(ModeFlag)
	cp $00
	jr z,@Hard
  @Normal:
  	xor a
	ld (ModeFlag),a
	;ld (TimesCompleted),a
	;ldh (<HardMode),a
	ld a,$F5
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	jr @SetModeFlag
  @Hard:
	ld a,$01
	ld (ModeFlag),a
	;ld (TimesCompleted),a
	;ldh (<HardMode),a
	ld a,$FF
	ldi (hl),a
	ldi (hl),a
	ld a,$E8
  @SetModeFlag:
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	inc a
	ldi (hl),a
	call ApplyOptionsAttrs
	ret

 ApplyOptionsAttrs:
	.INCLUDE "./includes/common/apply_options_attrs.s"
.ENDS

.BANK 0 SLOT 0
.ORG $04F5
.SECTION "Level selection numbers GFX realloc" OVERWRITE
	ld hl,$C094
.ENDS

SETREV1 9
.BANK 0 SLOT 0
.ORG $24BB+REVOFFSET
.SECTION "Difficulty mode check" OVERWRITE
	call DifficultyCheck
.ENDS

.BANK 0 SLOT 0
.SECTION "Difficulty mode check realloc" FREE
 DifficultyCheck:
	ld a,(ModeFlag)
	and a
	jr nz,@Exit
	bit 7,(hl)
	ret nz
	@Exit:
	jp $24EE+REVOFFSET
.ENDS