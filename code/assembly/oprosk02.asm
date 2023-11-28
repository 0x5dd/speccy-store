; Опрос в цикле клавиш "1", "2", "3" и "5".
; При нажатии первых трёх изменяется цвет
; области экрана и области бордюра.
; При нажатии клавиши "5" происходит возврат
; в Бейсик.

		org $9c40
		
		ld e,%00000110
		call setcol
		ld bc,$f7fe
loop:
		in a,(c)
		bit 0,a
		jr nz,cont1
		ld e,%00001110
		call setcol		
cont1:
		bit 1,a
		jr nz,cont2
		ld e,%00010110
		call setcol	
cont2:
		bit 2,a
		jr nz,cont3
		ld e,%00011110
		call setcol			
cont3:
		bit 4,a
		jr nz,loop
		ret

setcol:
		push af
		push bc
		push de
		ld hl,$5800
		ld (hl),e
		push de
		ld de,$5801
		ld bc,767
		ldir
		pop de
		ld a,e
		and %00111000
		rra
		rra
		rra
		out ($fe),a
		pop de
		pop bc
		pop af
		ret

