		org $9c40
		ld hl,$5800
		ld de,$0800			; d = 8, e = 0
loop3:
		ld b,3
loop2:
		ld c,32
loop1:
		ld (hl),e
		inc hl
		ld a,c
		cp 17
		jr nz,cont1
		set 6,e
cont1:
		dec c
		jr nz,loop1
		res 6,e
		djnz loop2
		ld a,e
		and %00111000
		rra
		rra
		rra
		inc a
cont2:
		rla
		rla
		rla
		ld e,a
		dec d
		jr nz,loop3
		ret

