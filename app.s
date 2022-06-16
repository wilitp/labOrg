
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGHT, 		480
.equ BITS_PER_PIXEL,  	32

// x1: x del punto inicial
// x2: y del punto inicial  
// x3: ancho
// x4: alto
// x10: color(usamos w10 porque el pixel ocupa 32 bits)
rectangle:
	mov x11, 0 // contador de filas
	rows_loop:		
		mov x9, 0 // contador de columna por fila, lo reiniciamos para cada fila pintada
		row_loop:		
			// Llamada a pixel dir
			sub sp, sp, 32	
			stur x30, [sp, 16] 
			stur x2, [sp, 8]
			stur x9, [sp, 0]
			add x1, x9, x1
			add x2, x11, x2
			bl utils.pixeldir
			ldur x9, [sp, 0]
			sub x1, x1,x9
			ldur x2, [sp, 8]
			ldur x30, [sp, 16] 
			add sp, sp, 32	

			stur w10, [x0]// pintar el punto
			add x9, x9, 1
			cmp x9, x3
			b.lt row_loop
		add x11, x11, 1
		cmp x11, x4
		b.lt rows_loop
	ret


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

	mov x6, 1000	//cantidad de veces qeu ejecuto el ciclo principal
	mov x5, 1		//en x5 yo tengo el delay entre frames, como voy incrementando el delay entre frames parece que se enlentece el cohete
main_loop:

	bl utils.save_registers
	bl graphics.background	//todo el fondo en negro, las estrellas y la luna
	bl rectangle	//aca deberia printearse el cohete
	add x2, x2, 35
	add x1, x1, 11
	mov x3, x7
	movz x10, 0x00FF, lsl 16
    movk x10, 0xff00, lsl 0
	bl graphics.rocket_fire
	movz x10, 0x00ff, lsl 16
    movk x10, 0xbf00, lsl 0
	sub x3,x3,12
	bl graphics.rocket_fire
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
