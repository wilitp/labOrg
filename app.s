
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

	mov x1, 0
	mov x2, 0
	mov x3, 50
	mov x4, 50

	mov x6, 5

main_loop:

	bl utils.save_registers
	movz x10, 0x77, lsl 16
	movk x10, 0xF585, lsl 00
	bl rectangle
	mov x5,300
	bl utils.delay 
	bl utils.restore_registers
	
	bl utils.save_registers
	mov x10, 0
	mov x1, 0
	mov x2, 0
	mov x3, 640
	mov x4, 480
	bl rectangle
	bl utils.restore_registers

	add x0,x0,50	
	subs x6,x6,1
	bne main_loop


InfLoop: 
	b InfLoop
