
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGHT, 		480
.equ BITS_PER_PIXEL,  	32

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	bl virtual_frame.change_base_pos
	//---------------- CODE HERE ------------------------------------
	//bl graphics.background

	movz x10, 0x77, lsl 16
	movk x10, 0x0000, lsl 00
	
	mov x1, 300
	mov x2, 0
	mov x3, 25
	mov x4, 50
	mov x7, 20	
	mov x12, 0
	mov x19, 0

	mov x6, 2500	//cantidad de veces qeu ejecuto el ciclo principal
	mov x5, 2	//en x5 yo tengo el delay entre frames, como voy incrementando el delay entre frames parece que se enlentece el cohete

	bl graphics.background	//todo el fondo en negro, las estrellas con su movimiento segun x6 y la luna

	mov x22, 50
	bl amongus

	bl virtual_frame.show_frame	//copio todo lo del frame virtual en el frame original

InfLoop: 
	b InfLoop
