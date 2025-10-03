.segment "INES"
.byte $4e, $45, $53, $1a
.byte 1
.byte 1
.byte $00
.byte $00

.segment "HEADER"
.byte $00, $00, $00, $00, $00, $00, $00, $00

.segment "CODE"
.org $8000
start:
    lda #$3F
    sta $2006
    lda #$00
    sta $2006
    lda #$3F
    sta $2007
    jmp start
