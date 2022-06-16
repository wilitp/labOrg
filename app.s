
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

	mov x6, 2000	//cantidad de veces qeu ejecuto el ciclo principal
	mov x5, 1		//en x5 yo tengo el delay entre frames, como voy incrementando el delay entre frames parece que se enlentece el cohete
main_loop:

	bl utils.save_registers
	bl graphics.background	//todo el fondo en negro, las estrellas y la luna
	mov x5, 4
	bl utils.save_registers
	bl graphics.rocket	//aca deberia printearse el cohete
	bl utils.restore_registers
	bl graphics.rocket_complete_fire
	bl utils.delay 
	bl utils.restore_registers
	
	//add x5,x5,1	//incremeto el delay en 1 milisegundo cada iteracion para generar efecto de realentizacion
	//add x2,x2,2	//muevo el cohete 1 casillero para abajo
	bl graphics.rocket_position_reg_changer
	bl graphics.rocket_fire_reg_changer

	subs x6,x6,1
	bl virtual_frame.show_frame
	bne main_loop

InfLoop: 
	b InfLoop
