.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   124
	b   db   67
	c1  db   2

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   dw    ?
	y   dw    ?

;x=(a^2+b(c-2))/(32c-b)=-5125
;y=(xc-ba)/(x+5242+2c)=-153

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=124
	mov bh,b	;bh=b=67
	mov cl,c1	;cl=c=2
	mov al,32	;al=32
	mul cl		;ax=32c=64
	sub al,bh	;al=32c-b=-3
	cbw
	mov si,ax	;si=32c-b=-3
	mov al,bl	;ax=a=124
	mul bl		;ax=a^2=15376
	cwd
	idiv si		;ax=(a^2+b(c-2))/(32c-b)=-5125
	mov x,ax	;x=-5125
;Вычисляем y
	add ax,5242	;ax=x+5242=117
	mov si,ax	;si=x+5242=117
	mov al,cl	;al=c=2
	add al,al	;al=2c=4
	cbw
	add si,ax	;si=x+5242+2c=121
	mov al,cl	;al=c=2
	cbw
	imul ax,x	;ax=x*c= -10250
	mov di,ax	;di=x*c= -10250
	mov al,bh	;al=b=67
	mul bl		;ax=b*a=8308
	neg ax		;ax=-b*a=-8308
	add ax,di	;ax=xc-ba=-18558
	cwd
	idiv si		;ax=(xc-ba)/(x+5242+2c)=-153
	mov y,si	;y=-153
exit 
end	lab1 