    org $9c40
    call scrsetup
mainloop:
    call scroll
    ld bc,$7ffe
    in a,(c)
    bit 0,a
    ret z
    halt
    jr mainloop

scrsetup:
    ld a,7
    out ($fe),a
    xor a
    ld hl,$4000
    ld (hl),a
    ld de,$4001
    ld bc,6143
    ldir
    ld a,%00111000
    ld hl,$5800
    ld (hl),a
    ld de,$5801
    ld bc,767
    ldir
    ret

scroll:
    ld a,0
    cp 0
    jr nz,cont1
    call getnewch
    ld a,8
    jr cont2
cont1:
    call scrlines
    call ptdots
    dec a
cont2:
    ld (scroll + 1),a
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
    ld de,buf
    ld b,8
gncloop:
    ld a,(hl)
    ld (de),a
    inc hl
    inc de
    djnz gncloop
    pop hl
    inc hl
    ld (getnewch + 1),hl
    ret

ptdots:
    push af
    ld hl,$581f
    ld de,buf
    ld b,8
ptdloop:
    ld a,(de)
    sla a
    ld (de),a
    jr nc,cont4
    ld (hl),%00000000       ; ink = paper = bright = flash = 0
    jr cont5
cont4:
    ld (hl),%00111000       ; ink = bright = flash = 0, paper = 7
cont5:
    push de
    ld de,32
    add hl,de
    pop de
    inc de
    djnz ptdloop
    pop af
    ret

scrlines:
    push af
    ld hl,$5801
    ld b,8
slloop1:
    push hl
    ld c,31
slloop2:
    ld a,(hl)
    dec hl
    ld (hl),a
    inc hl
    inc hl
    dec c
    jr nz,slloop2
    pop hl
    ld de,32
    add hl,de
    djnz slloop1
    pop af
    ret

buf:
    db 0, 0, 0, 0, 0, 0, 0, 0

text:
    db "Hello ZX Spectrum programming!     "
    db "Press 'SPACE' to exit...     "
    db 0
