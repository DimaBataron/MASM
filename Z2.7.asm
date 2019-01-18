.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   6
	b   dw   -2

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   dw    ?

;		/(a+b)^2	2+a*b<0
;	y=	|a*b		2+a*b=0
;		\|a|+b^3	2+a*b>0

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,a	;ax=a=6
	imul b		;ax=ab=-12
	add ax,2	;ax=ab+2
	cmp ax,0
	jl m1
	je m2

	;>0
	mov ax,b	;ax=b=-2
	imul ax
	imul ax,b	;ax=b^3=-8
	mov si,ax	;si=b^3=-8
	mov ax,a	;ax=a=6
	fabs		;ax=|a|=6
	add ax,si	;ax=|a|+b^3=-2
	jmp m3
m1: mov ax,a	;ax=a=6
	add ax,b	;ax=a+b=4
	mul ax		;ax=(a+b)^2=16
	jmp m3
m2: mov ax,a	;ax=a=6
	imul b		;ax=b=-12
m3: mov y,ax	
exit
end	lab2 