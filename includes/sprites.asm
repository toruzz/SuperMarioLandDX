.INCLUDE "includes/sprites/dx.asm"
.INCLUDE "includes/sprites/og.asm"

SETREV1 9
.BANK 0 SLOT 0
.ORG $25B7+REVOFFSET
.SECTION "SetSpriteHook" OVERWRITE SIZE 25
	SetSpriteHook:
	ldh a,(<BANK_CURRENT)
	ldh (<BANK_BUFFER),a

	ld a,(GraphicsFlag)
	add BANK_SPRITES

	ldh (<BANK_CURRENT), a
	ld (SWITCH_BANK), a
	call SetSprite

	ldh a, (<BANK_BUFFER)
	ldh (<BANK_CURRENT), a
	ld (SWITCH_BANK), a
	ret
.ENDS
