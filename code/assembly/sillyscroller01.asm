		org $9c40
		call scroll
		call printch
		ret

printch:
		ld hl,(curch)
		ld a,(hl)
		cp $ff
		jr nz,cont1
		ld hl,text
		ld (curch),hl
		ld a,(hl)
cont1:
		ld de,(23606)
		ld l,a
		ld h,0
		add hl,hl
		add hl,hl
		add hl,hl
		add hl,de
		ld de,$401f
		ld b,8
loop2:
		ld a,(hl)
		ld (de),a
		inc hl
		inc d
		djnz loop2
		ld hl,curch
		inc (hl)
		ret

scroll:
		ld hl,$4001
		ld b,8
loop4:
		push hl
		ld c,31
loop3:
		ld a,(hl)
		dec hl
		ld (hl),a
		inc hl
		inc hl
		dec c
		jr nz,loop3
		pop hl
		inc h
		djnz loop4
		ret

text:
		db "Happy new 2024 year!!!          "
		db $ff
curch:
		dw text
