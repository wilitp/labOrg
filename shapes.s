
// x1: x del punto inicial
// x2: y del punto inicial  
// x3: ancho
// x4: alto
// x10: color(usamos w10 porque el pixel ocupa 32 bits)
.globl rectangle
rectangle:
	
	mov x11, 0 // contador de filas
	rows_loop:		
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
			b.lo row_loop

		sub x1, x1, x3
		add x11, x11, 1
		add x2, x2, 1

		cmp x11, x4
		b.lo rows_loop
	ret

// x1: x del centro
// x2: y del centro
// x3: radio
// x10: color(usamos w10 porque el pixel ocupa 32 bits)
.global half_circle
half_circle:

	// guardo el centro
	mov x11, x1
	mov x12, x2

	// busco el punto inicial	
	sub x1, x1, x3
	sub x2, x2, x3
	mul x4, x3, x3  // radio cuadrado
	lsl x5, x3, 1 // ancho 
	lsl x6, x3, 0 // alto 

	mov x9, 0 // contador vertical
	mov x8, 0 // contador horizontal
	hcloop_filas:
		sub x1, x1, x8 // Devuelvo la coordenada x al extremo izquierdo
		mov x8, 0 // contador horizontal

		hcloop_fila:
				
			sub x7, x11, x1
			mul x7, x7, x7

			sub x13, x12, x2
			mul x13, x13, x13

			add x7, x7, x13

			cmp x4, x7 
			b.lo hcno_pintar // r^2 < (x0 - x)^2 + (y0 - y)^2 

			sub sp, sp, 96
			stur x30, [sp, 88] 
			stur x1, [sp, 80]
			stur x2, [sp, 72]
			stur x3, [sp, 64]
			stur x4, [sp, 56]
			stur x5, [sp, 48]
			stur x6, [sp, 40]
			stur x8, [sp, 32]
			stur x9, [sp, 24]
			stur x10, [sp, 16]
			stur x11, [sp, 8]
			stur x12, [sp, 0]
			bl utils.pixeldir
			ldur x30, [sp, 88] 
			ldur x1, [sp, 80]
			ldur x2, [sp, 72]
			ldur x3, [sp, 64]
			ldur x4, [sp, 56]
			ldur x5, [sp, 48]
			ldur x6, [sp, 40]
			ldur x8, [sp, 32]
			ldur x9, [sp, 24]
			ldur x10, [sp, 16]
			ldur x11, [sp, 8]
			ldur x12, [sp, 0]
			add sp, sp, 96

			stur w10, [x0]	
			hcno_pintar:
			add x8, x8, 1
			add x1, x1, 1
			cmp x8, x5
			b.lo hcloop_fila
		add x9, x9, 1
		add x2, x2, 1
		cmp x9, x6
		b.lo hcloop_filas

	ret

// x1: x del centro
// x2: y del centro
// x3: radio
// x10: color(usamos w10 porque el pixel ocupa 32 bits)
.globl circle
circle:

	// guardo el centro
	mov x11, x1
	mov x12, x2

	// busco el punto inicial	
	sub x1, x1, x3
	sub x2, x2, x3
	mul x4, x3, x3  // radio cuadrado
	lsl x5, x3, 1 // ancho 
	lsl x6, x3, 1 // alto 

	mov x9, 0 // contador vertical
	mov x8, 0 // contador horizontal
	loop_filas:
		sub x1, x1, x8 // Devuelvo la coordenada x al extremo izquierdo
		mov x8, 0 // contador horizontal

		loop_fila:
				
			sub x7, x11, x1
			mul x7, x7, x7

			sub x13, x12, x2
			mul x13, x13, x13

			add x7, x7, x13

			cmp x4, x7 
			b.lo no_pintar // r^2 < (x0 - x)^2 + (y0 - y)^2 

			sub sp, sp, 96
			stur x30, [sp, 88] 
			stur x1, [sp, 80]
			stur x2, [sp, 72]
			stur x3, [sp, 64]
			stur x4, [sp, 56]
			stur x5, [sp, 48]
			stur x6, [sp, 40]
			stur x8, [sp, 32]
			stur x9, [sp, 24]
			stur x10, [sp, 16]
			stur x11, [sp, 8]
			stur x12, [sp, 0]
			bl utils.pixeldir
			ldur x30, [sp, 88] 
			ldur x1, [sp, 80]
			ldur x2, [sp, 72]
			ldur x3, [sp, 64]
			ldur x4, [sp, 56]
			ldur x5, [sp, 48]
			ldur x6, [sp, 40]
			ldur x8, [sp, 32]
			ldur x9, [sp, 24]
			ldur x10, [sp, 16]
			ldur x11, [sp, 8]
			ldur x12, [sp, 0]
			add sp, sp, 96

			stur w10, [x0]	
			no_pintar:
			add x8, x8, 1
			add x1, x1, 1
			cmp x8, x5
			b.lo loop_fila
		add x9, x9, 1
		add x2, x2, 1
		cmp x9, x6
		b.lo loop_filas

	ret
