    org $9c40
    call scroll
    call putattr
    ret

putattr:
    ld hl,$581f
    ld de,32
    ld b,8
loop1:
    call rand8
    res 7,a
    ld (hl),a
    add hl,de
    djnz loop1
    ret

scroll:
    ld hl,$5801
    ld de,32
    ld b,8
loop3:
    push hl
    ld c,31
loop2:
    ld a,(hl)
    dec hl
    ld (hl),a
    inc hl
    inc hl
    dec c
    jr nz,loop2
    pop hl
    add hl,de
    djnz loop3
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
