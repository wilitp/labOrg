# Lab Org. y Arq. de Computadoras ej2

##Integrantes:
- Alejo Corral(43561688)
- Guillermo de Ipola(43524608)
- Victoria Lopez(44274057)

## Descripción de la animación
Un sospechoso viajero espacial llega a lo que parece ser una luna.

## Uso
**Para correr el proyecto ejecutar**

```bash
$ make run
```
Esto construirá el código y ejecutará qemu para su emulación

### Para usar el lab en Windows con wsl:
- Instalar VcXsrv
- Iniciar el server grafico corriendo `& "C:\Program Files\VcXsrv\vcxsrv.exe" :0 -ac -terminate -lesspointer -multiwindow -clipboard -wgl -dpi auto`
- En wsl, correr el archivo env.sh para configurar la pantalla.
- Usar el makefile normalmente
