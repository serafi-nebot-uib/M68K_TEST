sysinit:
; system initialization
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		jsr		scrinit

		move.l	#scrplot, ($80)

; change to user mode
		move	sr, -(a7)
		andi.w	#$dfff, (a7)
		rte

scrinit:
; screen initialization
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		movem.l	d0-d1, -(a7)

; set screen resolution
		move.b	#33, d0
		move.l	#scrwidth<<16|scrheight, d1
		trap	#15

; set windowed mode
		move.l	#1, d1
		trap	#15

; clear screen
		move.b	#11, d0
		move.l	#$ff00, d1
		trap	#15

; enable double buffer
		move.b	#92, d0
		move.b	#17, d1
		trap	#15

		movem.l	(a7)+, d0-d1
		rts

scrplot:
; screen plot
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		movem.l	d0-d1, -(a7)

; change screen buffer
		move.b	#94, d0
		trap	#15

; clear screen
		move.b	#11, d0
		move.l	#$ff00, d1
		trap	#15

		movem.l	(a7)+, d0-d1
		rte
