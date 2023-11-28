		org $9c40
		ld de,(23606)
		ld l,"M"
		ld h,0
		add hl,hl
		add hl,hl
		add hl,hl
		add hl,de
		ld de,$4000
		ld b,8
loop:
		ld a,(hl)
		ld (de),a
		inc d
		inc hl
		djnz loop
		ret

