; Physics tables setted at Init and

SETREV1 23
.BANK 0 SLOT 0
.ORG $0627+REVOFFSET
.SECTION "Vertical Table 1" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS
.BANK 0 SLOT 0
.ORG $0630+REVOFFSET
.SECTION "Vertical Table 2" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS
.BANK 0 SLOT 0
.ORG $0639+REVOFFSET
.SECTION "Vertical Table 3" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS
.BANK 0 SLOT 0
.ORG $0642+REVOFFSET
.SECTION "Vertical Table 4" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS
.BANK 0 SLOT 0
.ORG $064B+REVOFFSET
.SECTION "Vertical Table 5" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS

SETREV1 9
.BANK 0 SLOT 0
.ORG $1058+REVOFFSET
.SECTION "Vertical Table 6" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS
.BANK 0 SLOT 0
.ORG $2398+REVOFFSET
.SECTION "Vertical Table 7" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS
.BANK 0 SLOT 0
.ORG $23A1+REVOFFSET
.SECTION "Vertical Table 8" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS
.BANK 0 SLOT 0
.ORG $23AA+REVOFFSET
.SECTION "Vertical Table 9" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS
.BANK 0 SLOT 0
.ORG $23B3+REVOFFSET
.SECTION "Vertical Table 10" OVERWRITE
	call RAMCode@PhysicsTables@Vertical
.ENDS
.BANK 0 SLOT 0
.ORG $1EAD+REVOFFSET
.SECTION "Horizontal Table 1" OVERWRITE
	call RAMCode@PhysicsTables@Horizontal
.ENDS