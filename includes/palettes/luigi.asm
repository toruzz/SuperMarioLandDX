
.BANK BANK_LV_LUIGI SLOT 1
.ORGA $4000
.SECTION "InitLevelPal" FORCE

 InitLevelPal:
   .INCLUDE "./includes/common/init_pals.s" NAMESPACE "Luigi"

	INCLEVEL 11 dx Luigi
	INCLEVEL 12 dx Luigi Sunset
	INCLEVEL 13 dx Luigi Pyramid
	INCLEVEL 21 dx Luigi
	INCLEVEL 22 dx Luigi
	INCLEVEL 23 dx Luigi Underwater
	INCLEVEL 31 dx Luigi
	INCLEVEL 32 dx Luigi
	INCLEVEL 33 dx Luigi
	INCLEVEL 41 dx Luigi
	INCLEVEL 42 dx Luigi
	INCLEVEL 43 dx Luigi Skypop L
.ENDS



.BANK BANK_LV_LUIGI SLOT 1
.SECTION "MidLevel Pals" FREE
	INCMIDLEVEL 11 dx 1
	INCMIDLEVEL 12 og 1
	INCMIDLEVEL 13 dx 1
	INCMIDLEVEL 21 dx 0
	INCMIDLEVEL 21 dx 1
	INCMIDLEVEL 21 dx 2
	INCMIDLEVEL 22 dx 0
	INCMIDLEVEL 22 dx 1
	INCMIDLEVEL 23 dx 1
	INCMIDLEVEL 31 dx 1
	INCMIDLEVEL 31 dx 2
	INCMIDLEVEL 32 dx 1
	INCMIDLEVEL 32 dx 2
	INCMIDLEVEL 32 dx 3
	INCMIDLEVEL 33 dx 1
	INCMIDLEVEL 41 dx 1
	INCMIDLEVEL 42 dx 1
	INCMIDLEVEL 42 dx 2
	INCMIDLEVEL 43 dx 1
	INCMIDLEVEL 43 dx 2
	INCMIDLEVEL 43 dx 3
	INCMIDLEVEL 43 dx 4
	INCMIDLEVEL 43 dx 5
	INCMIDLEVEL 43 dx 6
	INCMIDLEVEL 43 dx 7
.ENDS
