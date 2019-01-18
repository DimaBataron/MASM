.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   -13
	b   dw   8

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   dw    ?

;		/b|a^3|		b*3/a<3
;	y=	|33			b*3/a=3
;		\30/a^2*b	b*3/a>3

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,3	;ax=3
	mul b	;ax=b*3=24
	cwd
	idiv a		;ax=b*3/a=-1
	cmp ax,3	
	jl m1
	je m2
	;>3
	mov ax,a	;ax=a=-13
	imul ax		;ax=a^2=169
	mov si,ax	;si=a^2=169
	mov ax,30	;ax=30
	cwd
	div si		;ax=30/a^2=0
	mul b		;ax=0
	jmp m3
m1:	mov ax,a	;ax=a=-13
	imul ax		;ax=a^2=169
	imul ax,a	;ax=a^3=-2197
	cmp ax,0
	js k1
	jmp k2
	k1: neg ax
	k2: mul b		;ax=b|a^3|=17576
	jmp m3
m2: mov ax,30	;ax=30
m3:	mov y,ax	
exit
end	lab2 