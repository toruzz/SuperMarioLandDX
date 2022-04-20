SETREV1 9
.BANK 0 SLOT 0
.ORG $0F81+REVOFFSET
.SECTION "Text printing routine Hook" OVERWRITE
	ldh a,(<BANK_CURRENT)
	ldh (<BANK_BUFFER),a

	ld a,:TextPrintingRoutine
	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a

	call TextPrintingRoutine

	push af
	ldh a,(<BANK_BUFFER)
	ldh (<BANK_CURRENT),a
	ld (SWITCH_BANK),a
	pop af

	ret
.ENDS

.IF REV == 0
	.UNBACKGROUND $0F99 $0FC3
.ELSE
	.UNBACKGROUND $0FA2 $0FCC
.ENDIF

.BANK BANK_INIT SLOT 1
.SECTION "Text printing routine" FREE
	TextPrintingRoutine:
	ldh a,($A6)		; $0f81: $f0 $a6
	and a			; $0f83: $a7
	ret nz			; $0f84: $c0

	ldh a,($FB)		; $0f85: $f0 $fb
	ld e,a			; $0f87: $5f
	ld d,$00		; $0f88: $16 $00
	add hl,de		; $0f8a: $19
	ld a,(hl)		; $0f8b: $7e
	ld b,a			; $0f8c: $47
	cp $FE			; $0f8d: $fe $fe
	jr z,@CharFE	; $0f8f: $28 $34
	cp $FF			; $0f91: $fe $ff
	ret z			; $0f93: $c8

	ldh a,($E2)		; $0f94: $f0 $e2
	ld h,a			; $0f96: $67
	ldh a,($E3)		; $0f97: $f0 $e3
	ld l,a			; $0f99: $6f
	@waitHBlank:
	;ldh a,(<STAT)	; $0f9a: $f0 $41
	;and $03			; $0f9c: $e6 $03
	;jr nz,@waitHBlank
	WAITBLANK

	push hl
	SETVRAM 1
	pop hl
	push hl
	ld a,$0C		; This is the attribute that will be applied to each letter
	ld (hl),a
	SETVRAM 0
	pop hl

	;@waitHBlank2:
	;ldh a,(<STAT)	; $0fa0: $f0 $41
	;and $03			; $0fa2: $e6 $03
	;jr nz,@waitHBlank2	; $0fa4: $20 $fa
	WAITBLANK

	ld (hl),b		; $0fa6: $70
	inc hl			; $0fa7: $23
	ld a,h			; $0fa8: $7c
	ldh ($E2),a		; $0fa9: $e0 $e2
	ld a,l			; $0fab: $7d
	and $0F			; $0fac: $e6 $0f
	jr nz,@NotCarriage	; $0fae: $20 $12
	bit 4,l			; $0fb0: $cb $65
	jr nz,@NotCarriage	; $0fb2: $20 $0e
	ld a,l			; $0fb4: $7d
	sub $20			; $0fb5: $d6 $20
	@End:
	ldh ($E3),a		; $0fb7: $e0 $e3
	inc e			; $0fb9: $1c
	ld a,e			; $0fba: $7b
	ldh ($FB),a		; $0fbb: $e0 $fb
	ld a,$0C		; $0fbd: $3e $0c
	ldh ($A6),a		; $0fbf: $e0 $a6
	ret				; $0fc1: $c9

	@NotCarriage:
	ld a,l			; $0fc2: $7d
	jr @End		; $0fc3: $18 $f2

	@CharFE:
	inc hl			; $0fc5: $23
	ldi a,(hl)		; $0fc6: $2a
	ld c,a			; $0fc7: $4f
	ld b,$00		; $0fc8: $06 $00
	ld a,(hl)		; $0fca: $7e
	push af			; $0fcb: $f5
	ldh a,($E2)		; $0fcc: $f0 $e2
	ld h,a			; $0fce: $67
	ldh a,($E3)		; $0fcf: $f0 $e3
	ld l,a			; $0fd1: $6f
	add hl,bc		; $0fd2: $09
	pop bc			; $0fd3: $c1
	inc de			; $0fd4: $13
	inc de			; $0fd5: $13
	jr @waitHBlank		; $0fd6: $18 $c2
.ENDS


; ** Previous text location **
.IF REV == 0
	.UNBACKGROUND $0FD8 $0FF3		; 00: THANK YOU MARIO.*<$73>OH! DAISY/1
	.UNBACKGROUND $117A $118A		; 01: OH! DAISY*<$1B>DAISY/
	.UNBACKGROUND $11B6 $11C6		; 02: THANK YOU MARIO.
	.UNBACKGROUND $1236 $124A		; 03: -YOUR QUEST IS OVER-
.ELSE
	.UNBACKGROUND $0FE1 $0FFC		; 00: THANK YOU MARIO.*<$73>OH! DAISY/1
	.UNBACKGROUND $1183 $1193		; 01: OH! DAISY*<$1B>DAISY/
	.UNBACKGROUND $11BF $11CF		; 02: THANK YOU MARIO.
	.UNBACKGROUND $123F $1253		; 03: -YOUR QUEST IS OVER-
.ENDIF

; New pointers
SETREV1 9
.BANK 0 SLOT 0
.ORG $0F61+REVOFFSET
.SECTION "Text pointer 00" OVERWRITE
	call GetTextPointer00
.ENDS
.ORG $115C+REVOFFSET
.SECTION "Text pointer 01" OVERWRITE
	ld hl,TextPointer01
.ENDS
.ORG $118B+REVOFFSET
.SECTION "Text pointer 02" OVERWRITE
	call GetTextPointer02
.ENDS
.ORG $1212+REVOFFSET
.SECTION "Text pointer 03" OVERWRITE
	ld hl,TextPointer03
.ENDS

.SECTION "GetTextPointer00" FREE
 GetTextPointer00:
	ld a,(PlayerFlag)
	cp $01
	jr z,@IsLuigi
	ld hl,TextPointer00M
	ret
	@IsLuigi:
	ld hl,TextPointer00L
	ret
.ENDS
.SECTION "GetTextPointer02" FREE
 GetTextPointer02:
	ld a,(PlayerFlag)
	cp $01
	jr z,@IsLuigi
	ld hl,TextPointer02M
	ret
	@IsLuigi:
	ld hl,TextPointer02L
	ret
.ENDS

.BANK BANK_INIT SLOT 1
.SECTION "Text pointers" FREE
 TextPointer00M:
	.ASC "THANK YOU MARIO.*"
	.db $73
	.ASC "OH! DAISY/"
 TextPointer00L:
	.ASC "THANK YOU LUIGI.*"
	.db $73
	.ASC "OH! DAISY/"
 TextPointer01:
	.ASC "OH! DAISY*"
	.db $1B
	.ASC "DAISY/"
 TextPointer02M:
	.ASC "THANK YOU MARIO./"
 TextPointer02L:
	.ASC "THANK YOU LUIGI./"
 TextPointer03:
	.ASC "-YOUR QUEST IS OVER-/"
.ENDS

.BANK 0 SLOT 0
.ORG $11FC+REVOFFSET
.SECTION "Clean text fix" OVERWRITE
	ld (hl),$FE
.ENDS
