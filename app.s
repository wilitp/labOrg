
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
	mov x22, 0

	mov x6, 2500	//cantidad de veces qeu ejecuto el ciclo principal
	mov x5, 2	//en x5 yo tengo el delay entre frames, como voy incrementando el delay entre frames parece que se enlentece el cohete
main_loop:
	bl utils.save_registers
	bl graphics.background	//todo el fondo en negro, las estrellas con su movimiento segun x6 y la luna
	mov x5, 4	//tamaño del cohetiño
	bl utils.save_registers
	bl graphics.rocket	//aca deberia printearse el cohete
	bl amongus
	bl utils.restore_registers	

	bl graphics.rocket_complete_fire	//fucncion que se encarga de mostrar el fuego segun lo que hay en x1,x2 y x7(nivel del fuego)
	bl utils.delay //delay segun lo que tenga cargado en x5
	bl utils.restore_registers
	
	bl graphics.rocket_position_reg_changer   //funcion que se encarga de ir cambiando la posicion del cohete
	bl graphics.rocket_fire_reg_changer	//funcion que se encarga de darle el efecto del fuego

	subs x6,x6,1	
	bl virtual_frame.show_frame	//copio todo lo del frame virtual en el frame original
	bne main_loop

InfLoop: 
	b InfLoop
