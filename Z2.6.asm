.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   2
	b   dw   7

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   dw    ?

;		/|a+b|/4	a^2-1<15
;	y=	|5a+b^2		a^2-1=15
;		\30/a^2*b	a^2-1>15

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,a	;ax=a=2
	mul	ax		;ax=a^2=4
	dec ax		;ax=a^2-1=3
	cmp ax,15	
	jl m1
	je m2

	;>15
	mov ax,a	;ax=a=2
	mul ax		;ax=a^2=4
	mov si,ax	;si=a^2=4
	mov ax,30	;ax=30
	cwd
	div si		;ax=30/a^2=7
	mul b		;ax=30/a^2*b=49
	jmp m3
m1: mov ax,a	;ax=a=2
	add ax,b	;ax=a+b=9
	fabs 
	cwd
	mov si,4	;si=4
	div si		;ax=|a+b|/4=2
	jmp m3
m2: mov ax,b	;ax=b=7
	mul ax		;ax=b^2=49
	mov si,ax	;si=b^2=49
	mov ax,5	;ax=5
	mul a		;ax=5a=10
	add ax,si	;ax=5a+b^2=59
m3: mov y,ax	
exit
end	lab2 