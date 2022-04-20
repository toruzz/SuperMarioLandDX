
.BANK BANK_LV_MARIO SLOT 1
.ORGA $4000
.SECTION "InitLevelPal" FORCE
 
 InitLevelPal:
   .INCLUDE "./includes/common/init_pals.s" NAMESPACE "Mario"

	INCLEVEL 11 dx Mario
	INCLEVEL 12 dx Mario Sunset
	INCLEVEL 13 dx Mario Pyramid
	INCLEVEL 21 dx Mario
	INCLEVEL 22 dx Mario
	INCLEVEL 23 dx Mario Underwater
	INCLEVEL 31 dx Mario
	INCLEVEL 32 dx Mario
	INCLEVEL 33 dx Mario
	INCLEVEL 41 dx Mario
	INCLEVEL 42 dx Mario
	INCLEVEL 43 dx Mario Skypop M
.ENDS



.BANK BANK_LV_MARIO SLOT 1
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