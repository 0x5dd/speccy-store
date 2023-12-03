    org $9c40
    call setbordercol
    call filldispf
    call fillattrf
    call waitspkey
    call cls
    ret

setbordercol:
    xor a
    out ($fe),a
    ret

filldispf:
    ld hl,$4000
    ld a,%01010101
    ld e,24
loop1:
    ld b,8
loop2:
    ld c,32
loop3:
    ld (hl),a
    inc hl
    dec c
    jr nz,loop3
    djnz loop2
    cpl
    dec e
    jr nz,loop1
    ret

fillattrf:
    ld hl,$5800
    ld b,24
loop4:
    ld c,32
loop5:
    call rand8
    res 7,a
    ld (hl),a
    inc hl
    dec c
    jr nz,loop5
    djnz loop4
    ret

waitspkey:
    ld bc,$7ffe
loop6:
	in a,(c)
	bit 0,a
	jr nz,loop6
	ret

cls:
    ld b,8
loop7:
    ld hl,$5800
    ld d,24
loop8:
    ld e,32
loop9:
    ld a,(hl)
    push af
    and %00111000
    rra
    rra
    rra
    sub 1
    jr nc,cont1
    xor a
cont1:
    rla
    rla
    rla
    ld c,a
    pop af
    and %00000111
    sub 1
    jr nc,cont2
    xor a
cont2:
    or c
    ld (hl),a
    inc hl
    dec e
    jr nz,loop9
    dec d
    jr nz,loop8
    halt
    halt
    halt
    djnz loop7
    xor a
    ld hl,$4000
    ld (hl),a
    ld de,$4001
    ld bc,6144
    ldir
    ret

rand8:
    ld a,(rseed)
    and $b8
    scf
    jp po,noclr
    ccf
noclr:
    ld a,(rseed)
    rla
    ld (rseed),a
    ret
rseed:
    db 1

