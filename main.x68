		org		$1000

		include	'const.x68'
		include	'sysconst.x68'
		include	'system.x68'
		include	'ball.x68'
		include	'paddle.x68'
		include	'score.x68'

start:
; --- initialization -----------------------------------------------------------
		jsr		sysinit
		jsr		balinit
		jsr		padinit
		jsr		scoinit

.loop:
; --- update -------------------------------------------------------------------
		jsr		balupd
		jsr		padupd

; --- sync ---------------------------------------------------------------------
		move.b	#23, d0
		move.l	#1, d1
		trap	#15

; --- plot ---------------------------------------------------------------------
		jsr		scoplot
		jsr		balplot
		jsr		padplot

		trap	#0								; draw screen

		bra		.loop

		include	'vars.x68'

		end		start
