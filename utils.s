.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGHT, 		480
.equ BITS_PER_PIXEL,  	32


// Args:
// 		x20: base constante del frame
// 		x1: x
// 		x2: y
// Ret:
//    x0 = x20 + 4(x1 + SCREEN_WIDTH * x2)
.globl utils.pixeldir
utils.pixeldir:
	mov x10, 4
	mov x9, SCREEN_WIDTH
	mul x2, x2, x9 
	add x0, x1, x2
	mul x0, x0, x10
	add x0, x20, x0
	ret

