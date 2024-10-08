sysinit:
; system initialization
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		jsr		scrinit
		jsr		kbdinit

		move.l	#scrplot, ($80)
		move.l	#kbdupd, ($84)

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

kbdinit:
; keyboard init
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		clr.b	(kbdval)
		clr.b	(kbdedge)
		rts

kbdupd:
; keyboard update values
; arg: none
; ret: none
; mod: none
; ------------------------------------------------------------------------------
		movem.l	d0-d3, -(a7)

		; read first part (WASD)
		move.b	#19, d0
		move.l	#kbdup<<24|kbdleft<<16|kbddown<<8|kbdright, d1
		trap	#15
		jsr		.pack

		; read second part
		move.b	#19, d0
		move.l	#kbdfire1<<24|kbdfire2<<16|kbdfire3<<8|kbdpause, d1
		trap	#15
		jsr		.pack

		; compute kbdedge
		move.b	(kbdval), d0
		not.b	d0
		and.b	d2, d0
		move.b	d0, (kbdedge)

		; store kbdval
		move.b	d2, (kbdval)

		movem.l	(a7)+, d0-d3
		rte

.pack:	move.w	#3, d3
.loop:	lsl.l	#8, d1
		roxl.b	#1, d2
		dbra.w	d3, .loop
		rts
