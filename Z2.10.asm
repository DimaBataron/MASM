﻿.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   -1
	b   dw   -2

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   dw    ?

;		/19a		1-a<11
;	y=	|b^2/a   	1-a=11
;		\5ab		1-a>11

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,1	;ax=1
	sub	ax,a	;ax=1-a=2
	cmp ax,11	
	jl m1
	je m2
	;>11
	mov ax,5	;ax=5
	imul a		;ax=5a=-5
	imul b		;ax=5ab=10
	jmp m3
m1: mov ax,19	;ax=19
	imul a		;ax=19a=-19
	jmp m3
m2: mov ax,b	;ax=b=-2
	imul ax		;ax=b^2=4
	idiv a		;ax=b^2/a=-4
m3: mov y,ax	
exit
end	lab2 