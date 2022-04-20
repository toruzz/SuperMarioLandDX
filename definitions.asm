; ** HARDWARE DEFINITIONS & CONSTANTS **
.DEFINE	LCDC		$FF40		; LCD Control
.DEFINE	STAT		$FF41		; LCDC Status
.DEFINE	SCY			$FF42		; Scroll Y
.DEFINE	SCX			$FF43		; Scroll X
.DEFINE	LY			$FF44		; 
.DEFINE	LYC			$FF45		; LY Compare
.DEFINE	WY			$FF4A		; Window Y Position
.DEFINE	WX			$FF4B		; Window X Position
.DEFINE	VBK			$FF4F		; VRAM Bank
.DEFINE	BCPS		$FF68		; Background Palette Index (GBC)
.DEFINE	BCPD		$FF69		; Background Palette Data (GBC)
.DEFINE	OCPS		$FF6A		; Sprite Palette Index (GBC)
.DEFINE	OCPD		$FF6B		; Sprite Palette Data (GBC)
.DEFINE	SVBK		$FF70		; WRAM Bank
.DEFINE VRAMTABLE0	$8000
.DEFINE VRAMTABLE1	$8800
.DEFINE VRAMTABLE2	$9000
.DEFINE BGMAP		$9800
.DEFINE BGMAP2		$9C00
.DEFINE	SWITCH_BANK	$2100		; Writing to this value changes the ROM Bank
.DEFINE	PALUNIT		$08			; 1 palette: 8 bytes
.DEFINE	PALSIZE		PALUNIT*8	; 8 palettes set
.DEFINE ANIMSIZE	$40
.DEFINE STAR_STATE	$81
.define END			$80
.DEFINE PALINIT		$80			; Used to set index to first color + auto-increment

.ASCIITABLE
	MAP "0" TO "9" = $C0
	MAP "A" TO "Z" = $CA
	MAP "." = $E4
	MAP ":" = $E5
	MAP "," = $E6
	MAP "!" = $E7
	MAP "-" = $E8
	MAP " " = $E9
	MAP "x" = $EB
	MAP "*" = $FE
	MAP "/" = $FF
.ENDA


; ** FREE SPACE **
.IF REV == 0
	.UNBACKGROUND $000B $0027		; Bank $00 [! Make sure this is safe]
	.UNBACKGROUND $3FCF $3FFF		; Bank $00
	.UNBACKGROUND $B91A $BFFF		; Bank $02 ($B91A-$BF90 is for the Title graphics, moved to BANK_ROUTINES)
	.UNBACKGROUND $E420 $E50F		; Bank $03
	
	.UNBACKGROUND $10000 $1FFFF		; Added banks are blank (for the time being), obviously
	.UNBACKGROUND $25D0 $263D		; Bank $00 - Freed by SetSpriteHook ($25B7).
	.UNBACKGROUND $0B9D $0BCC		; Bank $00 - Freed by Mario Death Routine ($0B84).
.ELSE
	.UNBACKGROUND $000B $0027		; Bank $00 [! Make sure this is safe]
	.UNBACKGROUND $0034 $003F		; Bank $00 [! Make sure this is safe]
	.UNBACKGROUND $3FE4 $3FFF		; Bank $00
	.UNBACKGROUND $B91A $BFFF		; [?]Bank $02 ($B91A-$BF90 is for the Title graphics, moved to BANK_ROUTINES)
	.UNBACKGROUND $E420 $E50F		; Bank $03

	.UNBACKGROUND $10000 $1FFFF		; Added banks are blank (for the time being), obviously
	.UNBACKGROUND $25D9 $2646		; Bank $00 - This is what remains of SetSpriteHook ($25B7>$25C0)
	.UNBACKGROUND $0BA6 $0BD5       ; Bank $00 - Freed by Mario Death Routine
.ENDIF

; ** BANKS **
.DEFINE	BANK_INIT		$04		; 
.DEFINE	BANK_ROUTINES	$05		; 
.DEFINE	BANK_SPRITES	$06		; 
.DEFINE	BANK_SPRITES_OG	$07		; 
.DEFINE BANK_MARIO 		$08
.DEFINE BANK_MARIO_OG 	$09
.DEFINE BANK_LUIGI 		$0A
.DEFINE BANK_LUIGI_OG 	$0B
.DEFINE BANK_LV_MARIO 	$0C
.DEFINE BANK_LV_MARIO_OG $0D
.DEFINE BANK_LV_LUIGI 	$0E
.DEFINE BANK_LV_LUIGI_OG $0F

; ** RAM VALUES **
.STRUCT OAM_Block
    posY	db
    posX	db
    tile	db
	attrs	db
.ENDST

.ENUM $C000 EXPORT
	.UNION
        OAM_Table	INSTANCEOF	OAM_Block	40
    .NEXTU
       	OAM_Bullets	INSTANCEOF	OAM_Block	3	; $C000	- Used for projectiles
		OAM_Player	INSTANCEOF	OAM_Block	6	; $C00C - Used for Mario's sprite
		OAM_Player2	INSTANCEOF	OAM_Block	2	; $C024 - Unused? Can be used for Mario's bigger sprites
		OAM_Blocks	INSTANCEOF	OAM_Block	1	; $C02C - ? blocks and bricks
		OAM_Misc	INSTANCEOF	OAM_Block	8	; $C030 - Coins, points, etc. This moves with Mario
		OAM_Enemies	INSTANCEOF	OAM_Block	8	; $C050 - Also hearts, flowers, mushrooms, etc.
    .ENDU
.ENDE

.STRUCT PortraitBlocks
	Block: instanceof OAM_Block 20
.ENDST


.DEFINE	GFXOffset			$4032 EXPORT	; Originally used in banks $01, $02 & $03
.DEFINE Score				$C0A0 EXPORT	; $C0A0-$C0A2
.DEFINE PreventBGScroll		$C0A5 EXPORT
.DEFINE Continues			$C0A6 EXPORT
.DEFINE LastLevel			$C0A8 EXPORT
.DEFINE GameOverFinished	$C0AD EXPORT
.DEFINE SuperstarTimer		$C0D3 EXPORT
.DEFINE DemoPlayTimer		$C0D7 EXPORT
.DEFINE IsPosYLocked		$C0DE EXPORT
.DEFINE PosYOffset			$C0DF EXPORT
.DEFINE TimesCompleted		$C0E1 EXPORT
.DEFINE	OAMAuxData			$C200 EXPORT
.DEFINE	MarioCurStatus		$C203 EXPORT	; 00: Mario, 10: Super Mario
.DEFINE CurTileCol			$C0B0 EXPORT
.DEFINE TopScore			$C0C0 EXPORT	; $C0A0-$C0A2
.DEFINE AnimatedTilesBuffer	$C600 EXPORT
.DEFINE	SprAttrMask			$D000 EXPORT
.DEFINE	SprIteration		$D013 EXPORT
.DEFINE CurPalCol			$D2B0 EXPORT
.DEFINE	Lives				$DA15 EXPORT
.DEFINE	BonusWalkingInit	$DA1C EXPORT
.DEFINE	MusicToPlay			$DFE8 EXPORT

.ENUM $D6A0 EXPORT
	CurSprTable			DW	; Current pointer table for the enemies' sprites
.ENDE

.ENUM $A400 EXPORT		; Check if this block is safe to use as flags
	OptionsFlag			DB	; Options menu is open
	GraphicsFlag		DB	; 00=New,	01=Old
	PlayerFlag			DB	; 00=Mario,	01=Luigi
	ModeFlag			DB	; 00=Normal,01=Hard,	02=Expert
	ShooterCounter		DB	; Counts the no. of frame the shooting gfx shows
	MemoryInitialized	DB
	SavedScore			DS 3; $A406-$A408
	GraphicsFlagDemo	DB
	PlayerFlagDemo		DB
	ModeFlagDemo		DB
	CurPlayerBankDemo	DB
	SaveTimesCompleted	DB	; A40D
.ENDE
.DEFINE VTableMario			$A500 EXPORT
.DEFINE VTableLuigi			$A520 EXPORT
.DEFINE XTableMario			$A540 EXPORT
.DEFINE XTableLuigi			$A550 EXPORT

.ENUM $D200 EXPORT
	.UNION
        PAL_BUFFER		DS PALSIZE*2
    .NEXTU
		PAL_BUFFER@BG	DS PALSIZE
		PAL_BUFFER@OBJ	DS PALSIZE
	.ENDU
	PAL_CHARBUFFER		DS PALUNIT	; Player's palette buffer (Flower transformation)
	PAL_CHARBUFFER_UG	DS PALUNIT	; Player's palette buffer (Underground+Flower)
	BGPAL_P1			DB
	BGPAL_P2			DB
	OBJPAL_P1			DB
	OBJPAL_P2			DB
	COPYV_P1			DB
	COPYV_P2			DB
	COPYV_P3			DB
	COPYV_P4			DB
	COPYV_P5			DB
	COPYV_P6			DB
	AUXVAR				DB
.ENDE
.DEFINE ATTRIBUTES_MAP $DB00 EXPORT

; Probably unused: $FF98, $FFA5
.ENUM $FF82 EXPORT
	DXAux				DB		; Apparently unused
	DXEventsCounter		DB		; Apparently unused
	DXEventsTrigger		DB		; Apparently unused
	VBlankFinished		DB		; If $01, VBlank just happened
    SprUpdateFlag   	DB      ; If $00, updates sprite
    SpriteRelY      	DB      ; Relative Y position
    SpriteRelX      	DB      ; Relative X position
    SpritePointer   	DB      ; Points to the correct sprite variant
    OAMAttrsMask0   	DB      ; 
    OAMAttrsMask    	DB      ; 
    OAMAttrsOver		DB      ; 
    OAMTableHighNib 	DB      ; 
    OAMTableLowNib  	DB      ; 
    Cycles          	DB      ; $FF8F
.ENDE
.ENUM $FFCD EXPORT
	CurPlayerBank		DB		; BANK_MARIO: 08, BANK_MARIO_OG:09, BANK_LUIGI, BANK_LUIGI_OG
	FireFlower			DB		; If 1, can shoot
	DXUnused2			DB		; Apparently unused
.ENDE
.DEFINE	OAMFinalX		$FF92 EXPORT
.DEFINE	OAMFinalY		$FF93 EXPORT
.DEFINE	OAMAttrsMask1	$FF94 EXPORT
.DEFINE PlayerOAMStat	$FF95 EXPORT
.DEFINE	OAMAuxDataP1	$FF96 EXPORT
.DEFINE	OAMAuxDataP2	$FF97 EXPORT
.DEFINE	CurrPower		$FF99 EXPORT ; $00: Mario, $01: Super Mario
.DEFINE	HardMode		$FF9A EXPORT ; Actually it's the no. of times you finished the game
.DEFINE	IsDemo			$FF9F EXPORT
.DEFINE cSCX			$FFA4 EXPORT
.DEFINE	Counter			$FFAC EXPORT
.DEFINE GameStatus		$FFB3 EXPORT
.DEFINE	Level			$FFB4 EXPORT
.DEFINE	CanMarioShoot	$FFB5 EXPORT
.DEFINE	VBlankRoutine3	$FFB6 EXPORT
.DEFINE	CounterPause	$FFD5 EXPORT
.DEFINE	BANK_BUFFER		$FFE1 EXPORT
.DEFINE	LevelPos		$FFE4 EXPORT
.DEFINE	CurDrawTile		$FFE9 EXPORT
.DEFINE	DrawStatus		$FFEA EXPORT
.DEFINE	GameOverCounter $FFFB EXPORT
.DEFINE	BANK_CURRENT	$FFFD EXPORT


.DEFINE REVOFFSET 0

.DEFINE LevelStart				$053D EXPORT

SETREV1 23
.DEFINE	CopyData				$05C7+REVOFFSET EXPORT			; Copies BC bytes from HL to DE

SETREV1 9
.DEFINE	VBlankRoutine1			$1B7D+REVOFFSET EXPORT
.DEFINE	VBlankRoutine2			$1C2A+REVOFFSET EXPORT
.DEFINE	VBlankRoutine5			$3D61+REVOFFSET EXPORT

SETREV1 21
.DEFINE	VBlankRoutine4			$3F24+REVOFFSET EXPORT