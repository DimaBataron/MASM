.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   6
	b   db   7
	c1  db   3

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   dw    ?

;x=(17c+2b^2)/(ac-21(b-c))=-2
;y=((x-64)^2+bc^2)/(ax+5c)=1473

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=6
	mov bh,b	;bh=b=7
	mov cl,c1	;cl=c=3
	mov al,bh	;al=b=7
	sub al,cl	;al=(b-c)=4
	cbw
	imul ax,-21	;ax=-21(b-c)=-84
	mov si,ax	;ch=-21(b-c)=-84
	mov al,bl	;al=a=6
	mul cl		;ax=ac=18
	add si,ax	;si=ac-21(b-c)=-66
	mov al,2	;al=2
	mul bh		;ax=2*b=14
	mul bh		;ax=2*b^2=98
	mov di,ax	;di=2*b^2=98
	mov al,17	;al=17
	mul cl		;ax=17c=51
	add ax,di	;ax=17c+2b^2=149
	cwd
	idiv si		;ax=(17c+2b^2)/(ac-21(b-c))=-2
	mov ch,al	;al=x=-2
	mov x,al	;x=-2
;Вычисляем y
	imul bl		;ax=ax=-12
	mov si,ax	;si=ax=-12
	mov al,5	;al=5
	mul cl		;ax=5c=15
	add si,ax	;si=ax+5c=3
	mov al,bh	;al=b=7
	mul	cl		;ax=bc=21
	mul cl		;ax=bc^2=63
	mov di,ax	;di=bc^2=63
	mov al,ch	;al=x=-2
	sub al,64	;al=x-64=-66
	imul al		;ax=(x-64)^2=4356
	add ax,di	;ax=(x-64)^2+bc^2=4419
	cwd
	div si		;ax=((x-64)^2+bc^2)/(ax+5c)=1473
	mov y,ax	;y=1473
exit 
end	lab1 