
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGHT, 		480
.equ BITS_PER_PIXEL,  	32


background:
	sub sp, sp, 32 // stack frame
	stur x30, [sp, -32] // save return addr

	mov x2, 8         // Y Size 
	loop1:
		mov x1, 8         // X Size
		loop0:
			stur x1, [sp, -24]
			stur x2, [sp, -16]
			stur x10, [sp, -8]
			bl utils.pixeldir
			ldur x1, [sp, -24]
			ldur x2, [sp, -16]
			ldur x10, [sp, -8]


			stur w10,[x0]	   // Set color of pixel N
			subs x1,x1,1	   // decrement X counter
			b.pl loop0	   // If not at row's start, jump
		subs x2,x2,1	   // Decrement Y counter
		b.pl loop1	   // if not first row, jump
	ldur x30, [sp, -32]
	add sp, sp, 32 // stack frame
	ret


.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------

	// mov x1, 0
	// mov x2, 0
	// stur x1, [sp, -16]
	// stur x2, [sp, -8]
	// bl utils.pixeldir
	// ldur x1, [sp, -16]
	// ldur x2, [sp, -8]
	
	movz x10, 0x77, lsl 16
	movk x10, 0xF585, lsl 00

	bl background

	// bl cuadradito



	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
