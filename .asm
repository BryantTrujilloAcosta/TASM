;28/0ctubre/2024
;1.Direccionamiento de registros, cuando los operandos son registros 
;ejemplo
; MOV AX,BX
; AND DH,CL
;
;2.Direccionamiento inmediato, cuando uno de los operandos es 
;una constante
;Ejemplo
; OR DL,30H
; MOV CX,10
;
;3.Direccionamiento Directo, cuándo uno de los operandos es una variable
;Ejemplo
;Asumiendo DATO DW 67CBh
;          ADD DATO, BX
;
;5.Direccionamiento de base, cuando se utiliza BX O BP y el otro es una constante o el nombre de una variable
;ejemplo:
; MOV BX,2
; ADD ARRAY[BX],7FH
;
;6.Direccionamiento indexado, cuando se utiliza SI O DI y el otro es una constante o el nombre de una variable
;ejemplo:
; asumiendo ALPHA  DW 5 DUP(67CBH)
;            XOR SI,SI
;            MOV CX, 5  
;
;
;
;