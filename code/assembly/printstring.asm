		org $9c40
		
		ld hl,$4000
		ld (pos),hl
		
		ld de,(23606)
		ld hl,text
		ld b,32
loop1:
		push hl
		push de
		ld a,(hl)		; в А - код следующего символа
		ld l,a
		ld h,0			; копирование А в HL
		add hl,hl
		add hl,hl
		add hl,hl
		add hl,de		; в HL - адрес байта в наборе символов
		ld de,(pos)		; в DE - адрес байта в дисплейном файле
		call prch
		inc de
		ld (pos),de
		pop de
		pop hl
		inc hl
		djnz loop1		
		ret

prch:
		push bc
		push de
		ld b,8
loop2:
		ld a,(hl)
		ld (de),a
		inc d
		inc hl
		djnz loop2
		pop de
		pop bc
		ret

pos:
		dw 0
text:
		db " Hello ZX Spectrum programming! "

