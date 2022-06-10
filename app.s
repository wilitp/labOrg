
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGHT, 		480
.equ BITS_PER_PIXEL,  	32


// x1: y del punto inicial
// x2: x del punto inicial  
// x3: ancho
// x4: alto
// x10: color(usamos w10 porque el pixel ocupa 32 bits)
rectangle:
	
	mov x11, 0 // contador de filas
	rows_loop:		
		sub x1, x1, x9
		mov x9, 0 // contador de columna por fila, lo reiniciamos para cada fila pintada
		row_loop:	
			
			// Llamada a pixel dir
			sub sp, sp, 64	
			stur x30, [sp, 56] 
			stur x1, [sp, 48]
			stur x2, [sp, 40]
			stur x3, [sp, 32]
			stur x4, [sp, 24]
			stur x9, [sp, 16]
			stur x10, [sp, 8]
			stur x11, [sp, 0]
			bl utils.pixeldir
			ldur x11, [sp, 0]
			ldur x10, [sp, 8]
			ldur x9, [sp, 16]
			ldur x4, [sp, 24]
			ldur x3, [sp, 32]
			ldur x2, [sp, 40]
			ldur x1, [sp, 48]
			ldur x30, [sp, 56] 
			add sp, sp, 64	

			stur w10, [x0]// pintar el punto
			add x9, x9, 1
			add x1, x1, 1
			cmp x9, x3
			b.lt row_loop
		add x11, x11, 1
		add x2, x2, 1

		cmp x11, x4
		b.lt rows_loop
	ret


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
	
	mov x1, 10
	mov x2, 10
	mov x3, 20
	mov x4, 40
	bl rectangle

	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
