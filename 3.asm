.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   7
	b   db   4
	c1  db   -5

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   dw    ?
	y   dw    ?

;x=(2a(4b+12c1))/(a^2-3c1)
;y= (4+bx^2+5)/((28-c1)(a-2)

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov al,a	;al=a=7
	mul al		;ax=a*a=49
	mov cx,ax	;cx=a*a=49
	mov al,3	;al=3
	imul c1		;ax=3*c1=-15
	sub cx,ax	;cx=a*a-3*c1=64
	mov al,4	;al=4
	mul b		;ax=4b=16
	mov bx,ax	;bx=4b=16
	mov al,12	;al=12
	imul c1		;ax=12*c1=-60
	add ax,bx	;ax=4b+12c1=-44
	mov bl,a	;bl=a=7
	add bl,bl	;bl=2a=14
	mov bh,0	;bx=2a=14
	imul bx		;dx:ax=2a(4b+12c1)=-616
	idiv cx		;ax=-9
	mov bp,ax	;ch=-9

;Вычисляем y
	mov al,28	;al=28
	sub al,c1	;al=28-c1=33
	mov cl,a	;cl=a=7
	add cl,-2   ;cl=a-2=5
	mul cl		;ax=(28-c1)(a-2)=165
	mov bx,ax	;bx=(28-c1)(a-2)=165
	mov ax,bp	;al=x=-9
	imul al		;ax=x^2=81
	mul b		;ax=x^2*b=324
	add ax,5    ;ax=x^2*b+5
	add ax,4	;ax=x^2*b+5+4=333
	cwd
	div bx		;ax=(x^2*b+5+4)/((28-c1)(a-2))=2
	mov y,ax
	mov x,bp
exit  ;это макрос, который вызывает функцию ExitProcess, которая
	    ;возвращает управление операционоой системе
end	lab1  ;Это директива ассемблера - определяет точку входа.