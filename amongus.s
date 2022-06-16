// Args:
// 		x20: base constante del frame
// 		x1: x
// 		x2: y
.globl amongus
amongus:
	cmp x22, 1
	blt amongus_exit
	cmp x22, 50
	blt amongus_increment_cont
	mov x1, 300
    mov x2, 410
	sub sp, sp, 1
	stur x30, [sp]
	// primero el contorno, mas o menos de izquierda a derecha
	mov x10, 0
	sub x1, x1, 14
	sub x2, x2, 24
	bl utils.save_registers
	mov x3, 2
	mov x4, 16
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 2
	add x2, x2, 16
	bl utils.save_registers
	mov x3, 4
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	sub x2, x2, 18
	bl utils.save_registers
	mov x3, 4
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 4
	sub x2, x2, 6
	bl utils.save_registers
	mov x3, 2
	mov x4, 28
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 2
	sub x2, x2, 2
	bl utils.save_registers
	mov x3, 2
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 2
	sub x2, x2, 2
	bl utils.save_registers
	mov x3, 12
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 12
	add x2, x2, 2
	bl utils.save_registers
	mov x3, 2
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 2
	add x2, x2, 2
	bl utils.save_registers
	mov x3, 2
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	sub x1, x1, 8
	add x2, x2, 2
	bl utils.save_registers
	mov x3, 12
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	add x2, x2, 6
	bl utils.save_registers
	mov x3, 12
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	sub x1, x1, 2
	sub x2, x2, 4
	bl utils.save_registers
	mov x3, 2
	mov x4, 4
	bl rectangle
	bl utils.restore_registers
	
	add x1, x1, 14
	bl utils.save_registers
	mov x3, 2
	mov x4, 4
	bl rectangle
	bl utils.restore_registers

	sub x1, x1, 2
	add x2, x2, 6
	bl utils.save_registers
	mov x3, 2
	mov x4, 18
	bl rectangle
	bl utils.restore_registers
	
	sub x1, x1, 6
	add x2, x2, 18
	bl utils.save_registers
	mov x3, 6
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	sub x1, x1, 12
	bl utils.save_registers
	mov x3, 6
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 6
	sub x2, x2, 4
	bl utils.save_registers
	mov x3, 2
	mov x4, 4
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 4
	bl utils.save_registers
	mov x3, 2
	mov x4, 4
	bl rectangle
	bl utils.restore_registers

	sub x1, x1, 2
	sub x2, x2, 2
	bl utils.save_registers
	mov x3, 2
	mov x4, 2
	bl rectangle
	bl utils.restore_registers


	// Lentes
	movz x10, 0x0083, lsl 16
	movk x10, 0xdbdb

	sub x2, x2, 18
	bl utils.save_registers
	mov x3, 12
	mov x4, 4
	bl rectangle
	bl utils.restore_registers

	// Ahora el cuerpo
	movz x10, 0x00bb, lsl 16
	movk x10, 0xbbbb

	sub x1, x1, 6
	sub x2, x2, 6
	bl utils.save_registers
	mov x3, 12
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	sub x1, x1, 2
	add x2, x2, 2
	bl utils.save_registers
	mov x3, 16
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	add x2, x2, 2
	bl utils.save_registers
	mov x3, 8
	mov x4, 2
	bl rectangle
	bl utils.restore_registers

	add x2, x2, 2
	bl utils.save_registers
	mov x3, 6
	mov x4, 24
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 6
	add x2, x2, 4
	bl utils.save_registers
	mov x3, 2
	mov x4, 16
	bl rectangle
	bl utils.restore_registers
	
	add x1, x1, 2
	add x2, x2, 2
	bl utils.save_registers
	mov x3, 2
	mov x4, 12
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 2
	bl utils.save_registers
	mov x3, 8
	mov x4, 14
	bl rectangle
	bl utils.restore_registers

	add x1, x1, 2
	add x2, x2, 14
	bl utils.save_registers
	mov x3, 6
	mov x4, 4
	bl rectangle
	bl utils.restore_registers

	sub x1, x1, 18
	sub x2, x2, 16
	bl utils.save_registers
	mov x3, 4
	mov x4, 16
	bl rectangle
	bl utils.restore_registers




	ldur x30, [sp]
	add sp, sp, 1
	ret
amongus_increment_cont:
	add x22, x22, 1
amongus_exit:
	ret








