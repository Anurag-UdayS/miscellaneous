[brainf 8bit 30KB]

======================================================================================

[ASCII value]
[DevTenga]
[17th December, 2021]
[A brainf program to print binary equiv of an entered character.]

======================================= Start ========================================

Our messages would be:
	Enter Character:
	ASCII Value:

Reused Characters: [e,t,r,a,C,I,space,:]

[We put them in special locations, as per their ascending ASCII values.]
[We keep byte 0 as control-byte, and byte 1 as the current-character byte.]

[space,C,I,a,e,r,t,:]

[We keep setting all characters gradually.]
	space (32)[2]:
	++++++++[++++++++>>+>+>+>+>+>+>+<<<<<<<<]>>+>+>+>+>+>+>+<<<<<<<<

	C (67)[3]:
	+++++++++++[+++++++>>>+>+>+>+>+>+<<<<<<<<]

	I (73)[4]:
	>>>>++++++>++++++>++++++>++++++>++++++<<<<<<<<

	a (97)[5]: 
	++++++[++++++++++>>>>>+>+>+>+<<<<<<<<]>>>>>-

	e (101)[6]:
	>+++>+++>+++<

	r (114)[7]:
	+++++++++++++>+++++++++++++

	t (116)[8]:
	++<<<<<<<<

	: (58)[9]:
	+[+++++>>>>>>>>>+<<<<<<<<<]>>>>>>>>>+++++++<<<<<<<<<

[Debug statement(() == braces): (<)!>!>!>!>!>!>!>!>!>!>>>>>>!<<<<<<<<<<<<<<< ]

[Printing out "Enter Character:"]
	E (69):
	+++[+++++++++++>+++<]>.

	n (110):
	<++++++++++[++++++>+<]>.

	t (116)[8]:
	>>>>>>>.

	e (101)[6]:
	<<.

	r (114)[7]:
	>.

	space (32)[2]:
	<<<<<.

	C (67)[3]:
	>.<<

	h (104)[1] is 110:
	------.

	a (97)[5]:
	>>>>.

	r (114)[7]:
	>>.

	a (97)[5]:
	<<.

	c (99)[1] is 104:
	<<<<-----.

	t (116)[8]:
	>>>>>>>.

	e (101)[6]:
	<<.

	r (114)[7]:
	>.

	: (58)[9]:
	>>.

	space (32)[2]:
	<<<<<<<.

[Now we take a character and store it in byte 12 so that we get enough space to work.]
[Byte 10 will be used as a control-byte.]

>>>>>>>>>>,<<<<<<<<<<<<

[Printing out "ASCII Value: "]
	A (65)[1] is 99:
	++++[+++++++>-<]>++.

	S(83)[1] is 65:
	++++++++++++++++++.

	C (67)[3]:
	>>.

	I (73)[4]:
	>.

	I (73)[4]:
	.

	space (32)[2]:
	<<.

	V (86)[1] is 83:
	<+++.

	a (97)[5]:
	>>>>.<<<<<

	l (108)[1] is 86:
	++++[++++++++++++>+<]>+.

	u (117)[1] is 108:
	+++++++++.

	e (101)[6]:
	>>>>>.

	: (58)[9]:
	>>>.

	space (32)[2]:
	<<<<<<<.

[Now, we handle the actual code and output the ASCII Value.]
	[Go to the control-byte value:]
	>>>>>>>>+

	[Go to the entered value:]
	>>

	Start a loop:
	[
		[Dividing the data into two cells.]
		[
			[As the control byte is active, the code runs.]
			<<[->>->+<<<]>>

			[If the value is 0, this is ignored, else it adds 1 to the left byte.] 
			[-<+<] [As we returned to the inactive control byte, the loop stopped.]
			[We reactivate the control byte and resume.]
			<<[>]+>>
		]

		[Subtract smaller cell from larger. Store smaller value in another cell.]  
		<[->>->+<<<]

		[Store the remainder 10 cells further.]
		>>[->>>>>>>>>>+<<<<<<<<<<]

		[Get back to the cell where the value is stored.]
		>

		[Move it to the previous cell.]
		[-<+>]

		[Finally, move to the previous cell as the new data cell.]
		<<<[-]+>>
	]

	[Get to the last of the stored bits.] 
	>>>
	>>>>>>>>

	[Add 48 to each byte. Use the byte to the right as a control-byte, and the next as the counter byte.]
	>>++++++++
	[
		[Go to the control byte, subtract 1, then start loop to add 51 to the main byte.]
		<-[-----<+>]

		[Go to the main byte and subtract 3, then output.]
		<---.

		[Cleanup the main byte (for setup as control byte.)]
		[-]

		[Move to the counter byte, and remove the current count.]
		>>-

		[Start loop to move control byte to the previous byte.]
		[-<+>]

		[Finally, select previous byte as control byte.]
		<
	]

[Cleanup, Print form-feed and start GC.]
[-]++++++++++.

Garbage Collection:

[Store the. index of the next byte in itself == 25.]
>>++++++[++++++++++<+>]<

[Start a loop to go to till beginning and GC.]
[
	[Go to the previous byte and GC it.]
	<[-]

	[Go to the counter byte and remove the current iteration.]
	>-

	[Move the counter byte to the previous iteration.]

	[-<+>]

	[Finally, select the previous byte as the counter and loop.]
	<
]

======================================== End =========================================