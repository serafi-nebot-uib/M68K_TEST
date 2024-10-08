scoinit:
; score initialization
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		clr.w	(scoin)
		clr.w	(scoout)
		rts

scoplot:
; score draw logic
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		movem.l	d0-d1/a1, -(a7)

		; set background color
		move.b	#81, d0
		move.l	#scofcol, d1
		trap	#15

		; set first line position
		move.b	#11, d0
		move.w	#scoline1, d1
		trap	#15

		; print first line
		move.b	#17, d0
		lea		.txt1, a1
		clr.l	d1
		move.w	(scoin), d1
		trap	#15

		; set second line position
		move.b	#11, d0
		move.w	#scoline2, d1
		trap	#15

		; print second line
		move.b	#17, d0
		lea		.txt2, a1
		clr.l	d1
		move.w	(scoout), d1
		trap	#15
	
		movem.l	(a7)+, d0-d1/a1
		rts

.txt1:	dc.b	'CAPTURED: ',0
.txt2:	dc.b	'MISSED  : ',0
