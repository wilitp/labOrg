.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGHT, 		480
.equ BITS_PER_PIXEL,  	32
.equ ROCKET_BREADTH,    60

.global graphics.background
//funcion que toma solo como argumento la posicion del frameBuffer en x0
//y me printea el fondo
//para el funcionamiento se va a usar el registro 11, 12
//esta funcion debe ocupar el menor tiempo posible para reducir panatallasos(aborresables)
graphics.background:
    sub sp,sp,32
    stur x11,[sp,0]
    stur x12,[sp,8]
    stur x30,[sp,16]
    stur x13,[sp,24]
    movz x11,0x0004,lsl 16
    movk x11,0xB000,lsl 0


background_loop:
        lsl x12,x11,2
        add x12,x12,x20
        stur xzr,[x12,0]
        subs x11,x11,1
    b.ge background_loop 

    //ahora hardcodeo algunas estrellas (hardcode es lo mas optimo a nivel cantidad de instruciones)
    movz x11, 0x00ff, lsl 16
    movk x11, 0xffff, lsl 0 

mov x12, 3270
   bl graphics.star_3x3  
   mov x12, 6000
   bl graphics.star_3x3 
   mov x12, 24000
   bl graphics.star_2x2 
   mov x12, 28500
   bl graphics.star_3x3  //
   mov x12, 30000
   bl graphics.star_3x3
   mov x12, 33500
   bl graphics.star_2x2  //
   mov x12, 33570
   bl graphics.star_2x2  //
   mov x12, 45000
   bl graphics.star_3x3
   mov x12,5270
   bl graphics.star_3x3
   mov x12,48500
   bl graphics.star_2x2 // 
   mov x12,47700
   bl graphics.star_3x3
   mov x12, 43000
   bl graphics.star_2x2  //
   mov x12, 43010
   bl graphics.star_3x3
   mov x12,49350
   bl graphics.star_3x3
   mov x12, 60000
   bl graphics.star_3x3

    //por ultimo llamo a la funcion que me grafica la luna con sus parametros
    bl utils.save_registers
    //lunaa
	mov x1, 320
	mov x2, 860
	mov x3, 500
	movz x10, 0x00D0, lsl 16
	movk x10, 0xD0D0, lsl 0
	bl half_circle
///////////////////
	mov x1, 360
	mov x2, 420 
	mov x3, 40
	movz x10, 0x00e0, lsl 16
	movk x10, 0xe0e0, lsl 0
	bl circle
	mov x1, 360
	mov x2, 420 
	mov x3, 30
	movz x10, 0x00c0, lsl 16
	movk x10, 0xc0c0, lsl 0
	bl circle
    bl utils.restore_registers
    /////


    ldur x12,[sp,8]
    ldur x11,[sp,0]
    ldur x30,[sp,16]
    ldur x13,[sp,24]
    add sp,sp,32
    ret


//dibuja una estrella comenzando por x12*4 de colo x11
graphics.star_3x3:
    lsl x12,x12,4
    lsr x13, x6, 2  //efecto movimiento
    lsl x13, x13, 2 //efecto movimiento
    add x12, x12, x13   //efecto movimiento
    add x12,x20,x12
    stur x11,[x12, 0]
    stur x11,[x12, 4]
    stur x11,[x12, 8]
    add x12,x12,2560
    stur x11,[x12, 0]
    stur x11,[x12, 4]
    stur x11,[x12, 8]
    add x12,x12,2560
    stur x11,[x12, 0]
    stur x11,[x12, 4]
    stur x11,[x12, 8]
    ret

graphics.star_2x2:
    lsl x12,x12,4
    lsr x13, x6, 4  //efecto movimiento
    lsl x13, x13, 2 //efecto movimiento
    add x12, x12, x13   //efecto movimiento
    add x12,x20,x12
    stur x11,[x12, 0]
    stur x11,[x12, 4]
    add x12,x12,2560
    stur x11,[x12, 0]
    stur x11,[x12, 4]
    ret




.global graphics.rocket_complete_fire
graphics.rocket_complete_fire:
    sub sp, sp, 8
    stur x30,[sp, 0]
    add x2, x2, 0
	add x1, x1, 1
	mov x3, x7
	movz x10, 0x00ff, lsl 16
    movk x10, 0xbf00, lsl 0
	bl graphics.rocket_fire
	sub x3,x3,15
	movz x10, 0x00FF, lsl 16
    movk x10, 0xff00, lsl 0
	bl graphics.rocket_fire
    ldur x30,[sp, 0]
    add sp, sp, 8
    ret
.global graphics.rocket_fire
//se printea el fuego abaixo du cohetiño
//parametriños:
//  1) x3 : estado del fuego 1-apagaduki ... 50 etoNoHeCocaPapi 
//  no implementado -> 2) x4 : estado anterior para ir variando, la funcion se encarga de ir mutandolo. Por eso es importante que nadie lo cambie 
//  3) x1, x2 : x e y position (mandar la misma que el coethe para que no quede patiadelix)
graphics.rocket_fire:
sub sp, sp, 8
stur x30,[sp, 0]
cmp x3, 0
ble fire_exit
bl utils.save_registers 
    add x5, x2, x3  //x5 seria la altura del fuego
rocket_fire_loop1:
        sub x0, x5, x2
        sub x0, xzr, x0
        add x0, x0, x3
        bl rocket_fire_function //esto se encarga de poner x0 en funcion de x0
        bl square_root
        add x6, x1, x0  //esto va drecmentando x6 seria el x del pixel
    rocket_fire_loop2:
            bl utils.save_registers
            mov x1, x6
            mov x2, x5
            bl utils.pixeldir
            sub x7, x6, x1
            sub x7, x1, x7
            stur w10,[x7, 0]
            stur w10,[x0, 0]
            bl utils.restore_registers
            bl utils.save_registers
            sub x7, x6, x1
            sub x7, x1, x7
            mov x1, x7
            mov x2, x5
            bl utils.pixeldir
            stur w10,[x0, 0]
            bl utils.restore_registers
            sub x6, x6, 1
            cmp x6, x1
            bge rocket_fire_loop2
        sub x5, x5, 1
        sub x7, x5, x2 
        subs x7, x7, 0
        bge rocket_fire_loop1
bl utils.restore_registers
fire_exit:
ldur x30,[sp, 0]
add sp, sp, 8
ret 

rocket_fire_function:
    //lsr x6, x0, 1
    //mul x0, x0, x0
    lsl x0, x0, 1
    //add x6, x1, x0  
    //add x6, x0, xzr 
    ret


.global graphics.rocket_fire_reg_changer
//esta funcion se encarga de ir mutando el x7(intensidad do fogo) para lograr un efecto piola en el fuego
graphics.rocket_fire_reg_changer:
add x7, x7, 2
cmp x7, 62
blt rocket_fire_reg_changer_exit
mov x7, 54
rocket_fire_reg_changer_exit:
ret


.global graphics.rocket_position_reg_changer

graphics.rocket_position_reg_changer:
    cmp x2, 400
    bge rocket_position_reg_changer_stay
    cmp x2, 385
    bge rocket_position_reg_changer_kill_fire
    add x12, x12, 1
    lsr x18, x2, 6
    cmp x12, x18
    blt rocket_position_reg_changer_exit
    mov x12, 0
    add x2, x2, 1
rocket_position_reg_changer_exit:
    ret
rocket_position_reg_changer_stay:
    mov x7, -2
    ret
rocket_position_reg_changer_kill_fire:
    add x2, x2, 1
    sub x7,x7 ,6
    ret
    
// Args:
// 		x20: base del frame
// 		x1: x
// 		x2: y
//    x5: escala
// Resumen:
//   	Pinta un cohete con (x, y) como punto medio inferior usando la escala en x5.
.globl graphics.rocket
graphics.rocket:
	sub sp, sp, 8
	stur x30, [sp]
	
	// porcion roja oscura
	movz x10, 0x00bf, lsl 16
	movk x10, 0x0202, lsl 0

	mov x9, 4
	mul x6, x5, x9
	sub x1, x1, x6

	mov x9, 20
	mul x6, x5, x9
	sub x2, x2, x6

	mov x9, 9
	mul x6, x5, x9
	mov x3, x6

	mov x9, 18
	mul x6, x5, x9
	mov x4, x6

	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// Punta
	// - Linea 1
	sub x2, x2, x5
	movz x10, 0x00e6, lsl 16
	movk x10, 0x0202, lsl 0

	mov x9, 9
	mul x6, x5, x9
	mov x3, x6

	mov x4, x5
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea 2
	sub x2, x2, x5
	add x1, x1, x5

	mov x9, 7
	mul x6, x5, x9
	mov x3, x6

	mov x4, x5

	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea 3
	sub x2, x2, x5
	add x1, x1, x5

	mov x9, 5
	mul x6, x5, x9
	mov x3, x6

	mov x4, x5
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea 4
	sub x2, x2, x5
	add x1, x1, x5

	mov x9, 3
	mul x6, x5, x9
	mov x3, x6

	mov x4, x5
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea 5
	sub x2, x2, x5
	add x1, x1, x5

	mov x3, x5
	mov x4, x5
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// Base

	// - Linea 1
	mov x9, 23
	mul x6, x5, x9
	add x2, x2, x6

	mov x9, 3
	mul x6, x5, x9
	sub x1, x1, x6
	movz x10, 0x00e6, lsl 16
	movk x10, 0x0202, lsl 0

	mov x9, 7
	mul x6, x5, x9
	mov x3, x6

	mov x4, x5
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea 2
	add x2, x2, x5
	sub x1, x1, x5

	mov x9, 9
	mul x6, x5, x9
	mov x3, x6
	mov x4, x5
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers


	// Ala izquierda
	// - Linea(vertical) 1
	mov x9, 4
	mul x6, x5, x9
	sub x1, x1, x6

	mov x9, 2
	mul x6, x5, x9
	sub x2, x2, x6

	mov x3, x5

	mov x9, 3
	mul x6, x5, x9
	mov x4, x6

	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea(vertical) 2
	add x1, x1, x5

	mov x9, 2
	mul x6, x5, x9
	sub x2, x2, x6
	
	mov x3, x5

	mov x9, 4
	mul x6, x5, x9
	mov x4, x6
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea(vertical) 3
	add x1, x1, x5

	mov x9, 2
	mul x6, x5, x9
	sub x2, x2, x6

	mov x3, x5

	mov x9, 5
	mul x6, x5, x9
	mov x4, x6
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea(vertical) 4
	add x1, x1, x5

	mov x9, 2
	mul x6, x5, x9
	sub x2, x2, x6

	mov x3, x5

	mov x9, 6
	mul x6, x5, x9
	mov x4, x6
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers


	// Ala derecha
	// - Linea(vertical) 1
	mov x9, 13
	mul x6, x5, x9
	add x1, x1, x6

	mov x9, 6
	mul x6, x5, x9
	add x2, x2, x6

	mov x3, x5

	mov x9, 3
	mul x6, x5, x9
	mov x4, x6
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea(vertical) 2
	sub x1, x1, x5

	mov x9, 2
	mul x6, x5, x9
	sub x2, x2, x6

	mov x3, x5

	mov x9, 4
	mul x6, x5, x9
	mov x4, x6
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea(vertical) 3
	sub x1, x1, x5

	mov x9, 2
	mul x6, x5, x9
	sub x2, x2, x6

	mov x3, x5

	mov x9, 5
	mul x6, x5, x9
	mov x4, x6
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// - Linea(vertical) 4
	sub x1, x1, x5


	mov x9, 2
	mul x6, x5, x9
	sub x2, x2, x6

	mov x3, x5

	mov x9, 6
	mul x6, x5, x9
	mov x4, x6
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// ret // vvvvvvvvvv Parte no escalada aun vvvvvvvvvvv

	// Ventana	

	// Linea derecha
	mov x9, 3
	mul x6, x5, x9
	sub x1, x1, x6

	mov x9, 7
	mul x6, x5, x9
	sub x2, x2, x6

	mov x3, x5

	mov x9, 3
	mul x6, x5, x9
	mov x4, x6

	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// Linea izquierda
	mov x9, 4
	mul x6, x5, x9
	sub x1, x1, x6

	mov x3, x5

	mov x9, 3
	mul x6, x5, x9
	mov x4, x6

	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// Linea arriba
	add x1, x1, x5
	sub x2, x2, x5

	mov x9, 3
	mul x6, x5, x9
	mov x3, x6

	mov x4, x5
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// Linea abajo
	mov x9, 4
	mul x6, x5, x9
	add x2, x2, x6

	mov x9, 3
	mul x6, x5, x9
	mov x3, x6

	mov x4, x5
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers

	// Cuadrado del medio
	movz x10, 0x0078, lsl 16
	movk x10, 0x0101
	mov x9, 3
	mul x6, x5, x9
	sub x2, x2, x6
	mov x3, x6
	mov x4, x6
	bl utils.save_registers
	bl rectangle
	bl utils.restore_registers


	ldur x30, [sp]
	add sp, sp, 8
	ret
