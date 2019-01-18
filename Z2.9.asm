.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   -11
	b   dw   0

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   dw    ?

;		/7/a+b		a<3
;	y=	|b/(|a|+1)	a=3
;		\2ba		a>3

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,a
	cmp ax,3
	jl m1
	je m2
	;>3
	imul ax,2	;ax=2a=-22
	imul b		;ax=2ab=0
	jmp m3
m1: mov ax,7	;ax=7
	cwd
	idiv a		;ax=7/a=0
	add ax,b	;ax=7/a+b=0
	jmp m3
m2:	mov ax,a	;ax=a=-11
	cmp ax,0
	js k1
	jmp k2
k1: neg ax		;ax=|a|=11
k2: inc ax		;ax=|a|+1=12
	mov si,ax	;si=|a|+1=12
	mov ax,b	;ax=b=0
	cwd
	idiv si		;ax=b/(|a|+1)=0
m3: mov y,ax

exit
end	lab2 