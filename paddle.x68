padinit:
; pad initialization
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		move.w	#scrheight/2, (padposy)
		rts

padupd:
; pad update logic
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		movem.w	d0-d1, -(a7)

		move.w	(padposy), d0
		btst.b	#7, (kbdval)
		beq		.chkdwn
		sub.w	#padspeed, d0
		bra		.chktop
.chkdwn:
		btst.b	#5, (kbdval)
		beq .done
		add.w	#padspeed, d0
.chktop
		cmp.w #padheight/2, d0
		bge .chkbot
		move.w #padheight/2, d0
		bra .done
.chkbot
		cmp.w #scrheight-padheight/2, d0
		ble .done
		move.w #scrheight-padheight/2, d0
.done:
		move.w d0, (padposy)
		
		movem.w	(a7)+, d0-d1
		rts

padplot:
; pad draw logic
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		movem.l d0-d4, -(a7)

		; set border color
		move.b #80, d0
		move.l #padbcol, d1
		trap #15

		; set fill color
		move.b #81, d0
		move.l #padfcol, d1
		trap #15

		; calculate coordinates
		move.w #padposx-padwidth/2, d1
		move.w #padposx+padwidth/2, d3
		move.w (padposy), d2
		sub.w #padheight/2, d2
		move.w d2, d4
		add.w #padheight, d4

		; draw rectangle
		move.b #87, d0
		trap #15

		movem.l (a7)+, d0-d4
		rts
