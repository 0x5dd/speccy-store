		org $9c40
		ld hl,$5800
		ld a,%01000000
		ld b,8
loop2:
		ld c,96
loop1:
		ld (hl),a
		inc hl
		dec c
		jr nz,loop1
		and %00111000
		rra
		rra
		rra
		inc a
		cp 8
		jr nz,cont
		xor a
cont:
		rla
		rla
		rla
		or %01000000
		djnz loop2
		ret

