		org $9c40
		
		ld hl,$5800
		ld a,%00111000
		ld c,24
loop1:
		ld b,32
loop2:
		ld (hl),a
		inc hl
		xor %01000000
		djnz loop2
		xor %01000000
		dec c
		jr nz, loop1
		ret

