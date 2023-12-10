    org $9c40
    call setattr
mainloop:
    call scroll
    ld bc,$7ffe
    in a,(c)
    bit 0,a
    ret z
    halt
    jr mainloop

setattr:
    ld hl,$5800
    ld (hl),0
    ld b,31
attrloop:
    inc hl
    ld (hl),%01000111
    djnz attrloop
    ld (hl),0
    ret

scroll:
    ld a,(counter)
    cp 8
    jr nz,cont1
    call getnewch
    ld a,0
    jr cont2
cont1:
    inc a
    call scrlin
cont2:
    ld (counter),a
    ret

scrlin:
    push af
    ld hl,$401f
    ld b,8
loop2:
    or a
    push hl
    ld c,31
loop3:
    rl (hl)
    dec hl
    dec c
    jr nz,loop3
    pop hl
    inc h
    djnz loop2
    pop af
    ret

getnewch:
    ld hl,text
    ld a,(hl)
    cp 0
    jr nz,cont3
    ld hl,text
    ld a,(hl)
cont3:
    push hl
    ld de,(23606)
    ld l,a
    ld h,0
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,de
    ld de,$401f
    ld b,8
loop1:
    ld a,(hl)
    ld (de),a
    inc hl
    inc d
    djnz loop1
    pop hl
    inc hl
    ld (getnewch + 1),hl
    ret

counter:
    db 8

text:
    db "Hello ZX Spectrum programming!     "
    db "Press 'SPACE' to exit...     "
    db 0
