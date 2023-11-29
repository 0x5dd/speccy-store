		org $9c40
		
		ld de,0
		ld b,4
loop3:	ld hl,$4000
		push bc
		ld b,192
loop2:	ld c,32
loop1:	ld a,(de)
		and (hl)
		ld (hl),a
		inc hl
		dec c
		inc de
		jr nz,loop1
		djnz loop2
		halt
		pop bc
		djnz loop3
		xor a
		ld hl,$4000
		ld (hl),a
		ld de,$4001
		ld bc,6143
		ldir
		ret
