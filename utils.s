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
	mov x9, SCREEN_WIDTH
	mul x2, x2, x9 
	add x0, x1, x2
	lsl x0, x0, 2
	add x0, x20, x0
	ret

// Args:
// 		x20: base del frame
// 		x1: x
// 		x2: y
// Resumen:
//    Pinta el punto (x, y) del color en x10
.globl utils.pixelpaint
utils.pixelpaint:
	mov x9, SCREEN_WIDTH
	mul x2, x2, x9 
	add x0, x1, x2
	lsl x0, x0, 2
	add x0, x20, x0
	stur w10, [x0]
	ret

//args:
	//x5: microseconds
.globl utils.delay
utils.delay:
	sub sp,sp,8	//me encargo de dejar x5 como  estaba antes
	stur x5,[sp,0]
	lsl x5,x5,19
	subs x5,x5,xzr
	b.le delay_ret
delay_loop:
	add xzr, xzr, xzr //nop
	subs x5,x5,1
	b.ne delay_loop 
delay_ret:

	ldur x5,[sp,0]
	add sp,sp,8	
	ret


//guarda los registros del 0 al 10
.global utils.save_registers
utils.save_registers:
	sub sp,sp,112	
	stur x0,[sp,0]
	stur x1,[sp,8]
	stur x2,[sp,16]
	stur x3,[sp,24]
	stur x4,[sp,32]
	stur x5,[sp,40]
	stur x6,[sp,48]
	stur x7,[sp,56]
	stur x8,[sp,64]
	stur x9,[sp,72]
	stur x10,[sp,80]
	stur x11,[sp,88]
	stur x12,[sp,96]
	stur x13,[sp,104]
	ret

//actualiza los registros con los valores en el stack
.global utils.restore_registers
utils.restore_registers:
	ldur x0,[sp,0]
	ldur x1,[sp,8]
	ldur x2,[sp,16]
	ldur x3,[sp,24]
	ldur x4,[sp,32]
	ldur x5,[sp,40]
	ldur x6,[sp,48]
	ldur x7,[sp,56]
	ldur x8,[sp,64]
	ldur x9,[sp,72]
	ldur x10,[sp,80]
	ldur x11,[sp,88]
	ldur x12,[sp,96]
	ldur x13,[sp,104]
	add sp,sp,112
	ret 



//toma un valor en x0 y devuelve su raiz cuadrada en x0
.global square_root
square_root:
    sub sp, sp, 16
    stur x1,[sp,8]
    stur x2,[sp,0]
    mov x1, 0
square_root_loop:
    mul x2, x1, x1
    cmp x2, x0
    bge square_root_exit
    add x1, x1, 1
    b square_root_loop
square_root_exit:
    mov x0, x1
    ldur x1,[sp,8]
    ldur x2,[sp,0]
    add sp, sp, 16
    ret
