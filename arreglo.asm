;28/octubre/2024
;asumiendo:
; ARREGLO DB 255 DUP(0)
;
;1. INICIALIZAR EL ARREGLO CON LOS ELEMENTOS DEL 1 AL 255. USAR DIR INDIRECTO
;
;BX,SI,DI -> DS
;LEA BX, ARREGLO
;MOV AL,1
;MOV CX,255
;CICLO:
;   MOV [BX],AL
;   INC AL
;   INC BX
;   LOOP CICLO

;2. RESOLVER 1 CON DIR DE BASE
;XOR BX,BX
;MOV AL,1
;MOV CX,255
;CICLO:
;   MOV ARREGLO[BX],AL
;   INC AL
;   INC BX
;   LOOP CICLO

;3.RESOLVER 1 CON DIRECCIONAMIENTO INDEXADO
;XOR SI,SI
;MOV AL,1
;MOV CX,255
;
;CICLO:
;   MOV ARREGLO[SI],AL
;   INC AL
;   INC SI
;   LOOP CICLO

;4.RESOLVER 1 CON DIRECCIONAMIENTO DE BASE INDEXADO
;LEA BX,ARREGLO
;XOR DI,DI
;MOV AL,1
;MOV CX,255
;CICLO:
;   MOV [BX][DI],AL
;   INC DI
;   INC AL
;   LOOP CICLO