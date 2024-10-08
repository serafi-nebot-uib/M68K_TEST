balinit:
; ball initialization
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		move.w	#scrwidth/2, (balposx)
		move.w	#scrheight/2, (balposy)
		move.w	#balspeed, (balvelx)
		move.w	#balspeed, (balvely)
		rts

balupd:
; ball update logic
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		movem.l	d0-d2, -(a7)

		move.w	(balposx), d0
		move.w	(balposy), d1
		add.w	(balvelx), d0
		add.w	(balvely), d1

		; check pad collisions
		cmp.w	#padposx+padwidth/2+balrad, d0
		bgt		.chkhorz

		move.w	(padposy), d2
		sub.w	#padheight/2+balrad, d2
		cmp.w	d2, d1
		blt		.chkhorz
		move.w	(padposy), d2
		add.w	#padheight/2+balrad, d2
		cmp.w	d2, d1
		bgt		.chkhorz
		neg.w	(balvelx)
		move.w	#padposx+padwidth/2+balrad, d0
		addq.w	#1, (scoin)
		bra		.done

.chkhorz:
		; check horizontal collisions
		cmp.w	#scrwidth-balrad, d0
		bgt		.colrgt
		cmp.w	#balrad, d0
		blt		.collft
		bra		.chkvert
		
.colrgt:
		neg.w	(balvelx)
		move.w	#scrwidth-balrad, d0
		bra		.done
.collft:
		neg.w	(balvelx)
		move.w	#scrwidth/2, d0
		move.w	#scrheight/2, d1
		addq.w	#1, (scoout)
		bra		.done

		; check vertical collisions
.chkvert:
		cmp.w	#scrheight-balrad, d1
		bgt		.colbot
		cmp.w	#balrad, d1
		blt		.coltop
		bra		.done

.colbot:
		neg.w	(balvely)
		move.w	#scrheight-balrad, d1
		bra		.done

.coltop:
		neg.w	(balvely)
		move.w	#balrad, d1

.done:
		move.w	d0, (balposx)
		move.w	d1, (balposy)

		movem.l	(a7)+, d0-d2
		rts

balplot:
; ball draw logic
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		movem.l	d0-d4, -(a7)

; set ball border color
		move.b	#80, d0
		move.l	#balbcol, d1
		trap	#15

; set ball fill color
		move.b	#81, d0
		move.l	#balfcol, d1
		trap	#15

; calculate plot coordinates
		move.w	(balposx), d1
		sub.w	(balrad), d1
		move.w	(balposy), d2
		sub.w	(balrad), d2
		move.w	d1, d3
		add.w	#2*balrad, d3
		move.w	d2, d4
		add.w	#2*balrad, d4

; draw ball
		move.b	#88, d0
		trap	#15

		movem.l	(a7)+, d0-d4
		rts
