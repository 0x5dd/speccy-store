    org $9c40
    call cls
    call draw
    call waitspkey
    ret

cls:
    xor a
    ld hl,$4000
    ld de,$4001
    ld bc,6144
    ldir
    out ($fe),a
    ld hl,$5800
    ld de,$5801
    ld bc,768
    ldir
    ret

draw:
    ld hl,$5920
    ld de,chdat
    ld b,24
loop1:
    ld a,(de)
    ld c,8
loop2:
    sla a
    jr c,cont1
    ld (hl),%01000000
    jr cont2
cont1:
    ld (hl),%01111000
cont2:
    inc hl
    dec c
    jr nz,loop2
    inc de
    djnz loop1
    ret

waitspkey:
    ld bc,$7ffe
loop3:
    in a,(c)
    bit 0,a
    ret z
    call donoise
    jr loop3

donoise:
    push bc
    ld hl,(addrt)
    ld de,$4800
    ld bc,2048
    ldir
    ld de,1920
    sbc hl,de
    ld a,h
    cp $37
    jr nz,cont3
    ld hl,0
cont3:
    ld (addrt),hl
    pop bc
    ret

addrt:
    defw 0
buf:
    defb 0
chdat:
    defb $3c, $3c, $3c, $08
    defb $42, $46, $42, $18
    defb $02, $4a, $02, $28
    defb $3c, $52, $3c, $48
    defb $40, $62, $40, $7e
    defb $7e, $3c, $7e, $08

