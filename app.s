
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGHT, 		480
.equ BITS_PER_PIXEL,  	32

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------

	mov x10, 0	

	mov x1, 0
	mov x2, 0
	mov x3, 640
	mov x4, 480
	bl rectangle

	movz x10, 0x77, lsl 16
	movk x10, 0xF585, lsl 00

	mov x1, 100
	mov x2, 100
	mov x3, 50
	mov x4, 50
	bl rectangle

	mov x1, 150
	mov x2, 150
	mov x3, 50
	mov x4, 50
	bl rectangle

	mov x1, 175
	mov x2, 125
	mov x3, 25
	bl circle

	mov x1, 125
	mov x2, 175
	mov x3, 25
	bl half_circle


	

	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
