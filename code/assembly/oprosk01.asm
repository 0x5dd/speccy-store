		org $9c40
		ld c,$fe
loop:
		ld b,$7f	; ожидаем нажатия клавиши из полуряда B N M SS SP
		in a,(c)
		bit 0,a		; клавиша SP нажата?
		jr z,exit	; если нажата, то переход на exit
		ld b,$f7	; ожидаем нажатия клавиши из полуряда 1 2 3 4 5
		in a,(c)
		bit 0,a		; клавиша 1 нажата?
		jr z,exit	; если нажата, то переход на exit
		jr loop
exit:
		ret

