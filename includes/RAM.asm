SETREV1 9
.ORG $1D52+REVOFFSET
.SECTION "Mario looking up graphic Hook" OVERWRITE
	; There's also code for the shooting graphics
	jp RAMCode@LookUp
	LookUpEnded:
.ENDS

.BANK $03 SLOT 1
.ORGA $4A67
.SECTION "Change shooting ball graphic Hook" OVERWRITE
	call RAMCode@ShootGFX
.ENDS

SETREV1 12
.BANK 0 SLOT 0
.ORGA $0986+REVOFFSET
.SECTION "Superball Mario On Hook" OVERWRITE
	call RAMCode@Superball@On
.ENDS

SETREV1 15
.BANK 0 SLOT 0
.ORGA $09DB+REVOFFSET
.SECTION "Superball Mario Off Hook" OVERWRITE
	call RAMCode@Superball@Off
.ENDS

.BANK BANK_ROUTINES SLOT 1
.SECTION "RAM Code source in ROM" SIZE $400 FREE
 RAMCodeSource:
	@Lookup: 	.INCLUDE "./includes/RAM/look_up.s" NAMESPACE "ROM"
	@ShootGFX:	.INCLUDE "./includes/RAM/shooting_gfx.s" NAMESPACE "ROM"
	@Superball:	.INCLUDE "./includes/RAM/superball.s" NAMESPACE "ROM"
	@DXEvents:	.INCLUDE "./includes/RAM/dx_events.s" NAMESPACE "ROM"
	@PhysicsTables:	.INCLUDE "./includes/RAM/physics_tables.s" NAMESPACE "ROM"
	@GameOverFix: .INCLUDE "./includes/RAM/gameover_fix.s" NAMESPACE "ROM"
.ENDS


.BANK BANK_ROUTINES SLOT 2
.ORGA $A000
.SECTION "RAM Code" SIZE $400 FORCE
 RAMCode:
	@LookUp:	.INCLUDE "./includes/RAM/look_up.s" NAMESPACE "RAM"
	@ShootGFX:	.INCLUDE "./includes/RAM/shooting_gfx.s" NAMESPACE "RAM"
	@Superball:	.INCLUDE "./includes/RAM/superball.s" NAMESPACE "RAM"
	@DXEvents:	.INCLUDE "./includes/RAM/dx_events.s" NAMESPACE "RAM"
	@PhysicsTables:	.INCLUDE "./includes/RAM/physics_tables.s" NAMESPACE "RAM"
	@GameOverFix: .INCLUDE "./includes/RAM/gameover_fix.s" NAMESPACE "RAM"
.ENDS


