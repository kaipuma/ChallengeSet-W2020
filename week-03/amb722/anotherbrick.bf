some notes:
	I will denote a cell as 'CX' where 'X' is its location starting at 0

	the ability to set 'waypoints' exists
	if a cell is at a unique value then the following algorithm can find it:
		decr by that unique value
		open loop
			incr by val
			move one cell over
			decr by val
		close loop
		incr by val
	I will denote these waypoints as 'WX' where 'X' is the value used
	of note waypoints can be negative because of wraparound
	this will be denoted with 'WnX' instead of the negative sign (obvs)
	the alg for negative waypoints simply inverts the invr and decr's
	I will call this 'skating' to the waypoint

	when working around a waypoint; I will denote cells relative to it with
	'LX' ('L' for 'Local') or 'LnX' (for neg) where X=0 is the waypoint cell

	each numerical digit in ascii is exactly 48 above its actual value
	eg 4 in ascii is 52 = 48 plus 4

======= Program start =======

>>>						leave space at front of tape

======= Input the 'h' variable ======= 

+						initial value to start loop
[
	,					input value
	[>>+<+<-]>>[<<+>>-]	copy to next cell
	<					move to the copy
	>++++[<-------->-]<	subtract 32 (the space char)
	
	if cell is zero then input was a space so stop receiving input
]

======= Set waypoint for 'h' (Wn3) =======

<						move to the space character just recieved
[-]						reset that cell
---						set the Wn3

======= Decr each input digit by 48 =======

<						move to 1s place
[						until a cell with a 0 is reached
	------------ ------------	decr by 48 (in place b/c
	------------ ------------	no workspace is available)
	<					move to next cell
]

======= Move to Ln3 =======

>						move to leftmost digit of 'h'
+++ [ --- > +++ ] ---	skate right to Wn3
<<<						move three to the left (Ln3)

======= Sum all digits into L1 (accounting for position) =======


[> +++++ +++++ < -]		add 100s place *10 to 10s place
>						move to 10s place
[> +++++ +++++ < -]		add 10s place *10 to 1s place
>						move to 1s place
[>> + << -]				move value into L1
>>						move to L1

======= Repeat above process for 'w' =======

>>>						move a ways away from Wn3

input digits exactly as for 'h' above (see comments there)
+[[-],[>>+<+<-]>>[<<+>>-]<>++++[<-------->-]<]

set waypoint for 'w' (Wn4) as for 'h' above (but w/ n4)
<[-] ----

decr each input digit by 48 as for 'h' above
<[ ------------ ------------ ------------ ------------ <]

move to Ln3 (same as above but skating to Wn4 instead)
> ++++ [ ---- > ++++ ] ---- <<<


properly sum digits into L1 as for 'h' above (but @ Wn4)
[> +++++ +++++ < -]>[> +++++ +++++ < -]>[>> + << -]>>

======= Handle the 'n' variable =======

>>>>						move a ways away from  Wn4

we will dispose all of 'n' and just use EOF to know when to stop
this is so I don't have to handle a possibly 5 digit number
especially since some (or most) brainfuck implementations limit
the cell size to one byte (which 10000 is def over)

+						initial value to start loop
[
	[-]					reset cell
	<					move to overwrite prev value
	,					input value
	[>>+<+<-]>>[<<+>>-]	copy to next cell
	<					move to the copy
	----- -----			subtract 10 (the newline char)
	
	if cell is zero then input was a space so stop receiving input
]
<						move to the leftover input
[-]						clear it

======= Setup final loop =======

this loop will find a success when 'h' hits zero
'h' will only be decr once every time a copy of 'w' hits zero
to facilitate this 'w' will also be moved to Wn3 (Ln1 specifically)

+++ [--- < +++] ---		skate left to Wn3

move 'w' to Wn3 Ln1; this is like a standard move
but with skating () between waypoints inbetween actions
[ (+++[---<+++]---) <+ (++++[---->++++]----) >-]

Wn10 is not needed now (we'll be working 
around Wn3 from now on) so it's deleted
< +++++ +++++

skate left to Wn3
+++ [--- < +++] ---

======= Begin final loop =======

>						move to 'h' at L1

[						open final 'h' check loop
	======= Make a copy of 'w' (denoted 'wc') in L2 =======
	
	<<					move to 'w' at Ln1
	[>>>+<<<<+>-]		move value into L2 and Ln2 (temp)
	<[>+<-]				move copy of 'w' from Ln2 back to Ln1
	>>>>				move to 'wc'
		TODO: input each 'x' and do the alg
	<					move back to 'h'
	-
]						close 'h' loop (this means success)

#!2 70 7
5 5 5 5 5 5 5