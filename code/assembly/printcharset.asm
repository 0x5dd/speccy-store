		org $9c40
		ld de,15616			; адрес начала печатаемых символов в таблице символов
		ld hl,$4000
		ld b,3				; количество строк
loop2:
		push hl
		ld c,32				; количество столбцов
loop1:
		call prchar
		dec c
		;halt				; задержка печати
		jr nz,loop1
		pop hl
		push de
		ld de,32
		add hl,de
		pop de
		djnz loop2
		ret

prchar:
		push bc
		push hl
		ld b,8
loop3:
		ld a,(de)
		ld (hl),a
		inc h
		inc de
		djnz loop3
		pop hl
		inc hl
		pop bc
		ret

