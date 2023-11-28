		org $9c40
		
		ld hl,$5800
		xor a
		ld b,24
loop1:
		ld c,8
loop2:
		ld (hl),a
		inc hl
		ld (hl),a
		inc hl
		set 6,a
		ld (hl),a
		inc hl
		ld (hl),a
		inc hl
		and %00111000
		rra
		rra
		rra
		inc a
		rla
		rla
		rla
		dec c
		jr nz,loop2
		djnz loop1
		ret

