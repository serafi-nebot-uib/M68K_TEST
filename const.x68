
; --- ball ---------------------------------------------------------------------
balrad		equ		8							; ball radius
balbcol		equ		$00aa0000					; ball border color
balfcol		equ		$00ff0000					; ball fill color
balspeed	 equ	3							; ball speed (magnitude of dx & dy)

; --- pad ---------------------------------------------------------------------
padwidth	equ		16								; pad width
padheight	equ		64								; pad height
padposx		equ		48								; pad position in x axis
padspeed	equ		7								; pad movement speed
padbcol		equ		$0000ff00						; pad border color
padfcol		equ		$0000aa00						; pad fill color

; --- scoreboard ---------------------------------------------------------------
scofcol		equ		$00000000						; scoreboard fill color
scoline1	equ		$0101							; scoreboard line 1 position (x=1,y=1)
scoline2	equ		$0102							; scoreboard line 1 position (x=1,y=2)
