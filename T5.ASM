TITLE PROGRAMA SUMA DOS NUMEROS DECIMALES CON VALIDACION
;EQUIPO
;TRUJILLO ACOSTA BRYANT No.Control. 21170495
;RUBIO SOTO JESUS GUADALUPE No.Control. 21170471
.MODEL SMALL
.STACK 100h
.DATA
DECIMAL1 DW 0
DECIMAL2 DW 0
MSG1 DB 10,13,"DAME UN NUMERO DECIMAL DE 5 CIFRAS: $"
MSG2 DB 10,13,"DAME EL SEGUNDO NUMERO DECIMAL DE 5 CIFRAS: $"
MSG3 DB 10,13,"LA SUMA ES = $"
MSG4 DB 10,13,"SOLO SE PUEDEN INGRESAR DIGITOS DECIMALES INTENTALO OTRA VEZ: $"
MSG_RETRY DB 10,13,13,13,"DESEA VOLVER A EJECUTAR EL PROGRAMA('S' o 'N')? $"
MSG_END DB 10,13,"FIN DEL PROGRAMA.$"
.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS,AX
INICIO:

LEER_PRIMER_NUMERO:
    ; Desplegar mensaje para el primer número
    LEA DX,MSG1
    MOV AH,9
    INT 21h
    
    ; Inicializar BX en 0
    XOR BX,BX
    ; Establecer contador de dígitos en 5
    MOV CX,5
LEER_DIGITO1:
    ; Multiplicar BX por 10
    MOV AX,10
    MUL BX
    MOV BX,AX
    
    ; Leer un carácter del teclado
    MOV AH,1
    INT 21h
    
VALIDAR_DIGITO1:
    ; Comparar si el carácter es menor que '0'
    CMP AL,"0"
    JB DIGITO_INVALIDO1
    ; Comparar si el carácter es menor o igual a '9'
    CMP AL,"9"
    JBE SIGUIENTE_DIGITO1
    
DIGITO_INVALIDO1:
    ; Comparar si el carácter es Enter
    CMP AL,13
    JE CERO_ENTER1
    
    ; Desplegar mensaje de error
    LEA DX,MSG4
    MOV AH,9
    INT 21h
    
    ; Reintentar leer el primer número
    JMP LEER_PRIMER_NUMERO

CERO_ENTER1:
    ; Dividir BX entre 10
    MOV AX,BX
    XOR CX,CX
    MOV CX,10
    DIV CX
    MOV BX,AX
    JMP CONTINUAR1
    
SIGUIENTE_DIGITO1:
    ; Convertir carácter a número
    AND AL,0Fh
    CBW
    ADD BX,AX
    ; Decrementar contador y repetir si no es cero
    LOOP LEER_DIGITO1
    
CONTINUAR1:
    ; Guardar el primer número en DECIMAL1
    XOR CX,CX
    MOV DECIMAL1,BX
    
LEER_SEGUNDO_NUMERO:
    ; Desplegar mensaje para el segundo número
    LEA DX,MSG2
    MOV AH,9
    INT 21h
    
    ; Inicializar BX en 0
    XOR BX,BX
    ; Establecer contador de dígitos en 5
    MOV CX,5
LEER_DIGITO2:
    ; Multiplicar BX por 10
    MOV AX,10
    MUL BX
    MOV BX,AX
    
    ; Leer un carácter del teclado
    MOV AH,1
    INT 21h
    
VALIDAR_DIGITO2:
    ; Comparar si el carácter es menor que '0'
    CMP AL,"0"
    JB DIGITO_INVALIDO2
    ; Comparar si el carácter es menor o igual a '9'
    CMP AL,"9"
    JBE SIGUIENTE_DIGITO2
    
DIGITO_INVALIDO2:
    ; Comparar si el carácter es Enter
    CMP AL,13
    JE CERO_ENTER2
    
    ; Desplegar mensaje de error
    LEA DX,MSG4
    MOV AH,9
    INT 21h
    
    ; Reintentar leer el segundo número
    JMP LEER_SEGUNDO_NUMERO
    
CERO_ENTER2:
    ; Dividir BX entre 10
    MOV AX,BX
    XOR CX,CX
    MOV CX,10
    DIV CX
    MOV BX,AX
    JMP CONTINUAR2
    
SIGUIENTE_DIGITO2:
    ; Convertir carácter a número
    AND AL,0Fh
    CBW
    ADD BX,AX
    ; Decrementar contador y repetir si no es cero
    LOOP LEER_DIGITO2
    
CONTINUAR2:
    ; Guardar el segundo número en DECIMAL2
    XOR CX,CX
    MOV DECIMAL2,BX
    
SUMAR_NUMEROS:
    ; Inicializar AX y BX en 0
    XOR AX,AX
    XOR BX,BX
    ; Cargar DECIMAL1 en AX
    MOV AX,DECIMAL1
    ; Sumar DECIMAL2 a AX
    ADD AX,DECIMAL2
    ; Guardar el resultado en BX
    MOV BX,AX
    
DIVIDIR_NUMERO:
    ; Inicializar DX en 0
    XOR DX,DX
    ; Dividir BX entre 10
    MOV BX,10
    DIV BX ; Cociente en AX, residuo en DX
    ; Guardar residuo en la pila
    PUSH DX
    ; Incrementar contador
    INC CX
    
    ; Repetir mientras el cociente no sea cero
    CMP AX,0
    JNE DIVIDIR_NUMERO
    
    ; Desplegar mensaje de resultado
    LEA DX,MSG3
    MOV AH,9
    INT 21h
    
DESPLEGAR_NUMERO:
    ; Desplegar cada dígito del resultado
    MOV AH,2
    POP DX
    OR DL,30h
    INT 21h
    LOOP DESPLEGAR_NUMERO
    
REINTENTAR:
    ; Desplegar mensaje de reintento
    LEA DX,MSG_RETRY
    MOV AH,9
    INT 21h
    
    ; Leer decisión del usuario
    MOV AH,1
    INT 21h
    ; Comparar con 'N' o 'n' para finalizar
    CMP AL,"N"
    JE FIN_PROGRAMA
    CMP AL,"n"
    JE FIN_PROGRAMA
    ; Comparar con 'S' o 's' para reiniciar
    CMP AL,"S"
    JE INICIO2
    CMP AL,"s"
    JE INICIO2
    
    ; Reintentar si no es una opción válida
    JMP REINTENTAR
INICIO2:
    ; Reiniciar el programa
    JMP INICIO
    
FIN_PROGRAMA:
    ; Desplegar mensaje de fin del programa
    LEA DX, MSG_END
    MOV AH,9
    INT 21h
    
    ; Terminar el programa
    MOV AH,4Ch
    INT 21h

MAIN ENDP
    END MAIN