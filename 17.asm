.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   21
	b   db   2
	c1  db   35

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(a^3-(b+c)4)/(28b-ac)=-13
;y=(x^2-4(a+c))/(x+24b)=-1

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=21
	mov bh,b	;bh=b=2
	mov cl,c1	;cl=c=35
	mov al,28	;al=28
	mul	bh		;ax=28*b=56
	mov si,ax	;si=28*b=56
	mov al,bl	;al=a=21
	mul cl		;ax=ac=735
	neg ax		;ax=-ac=-735
	add si,ax	;si=28b-ac=-679
	mov al,bl	;al=a=21
	mul al		;ax=a^2=441
	mov di,ax	;di=a^2=441
	mov al,bl	;al=a
	cbw
	mul di		;ax:dx=a^3=9261
	mov di,ax	;di=a^3=9261
	mov al,bh	;al=b=2
	add al,cl	;al=b+c=37
	cbw
	imul ax,-4	;ax=-4(b+c)=-148
	add ax,di	;ax=a^3-4(b+c)=9113
	cwd
	idiv si		;ax=(a^3-(b+c)4)/(28b-ac)=-13
	mov ch,al	;ch=x=-13
	mov x,al	;x=-13
;Вычисляем y
	mov al,24	;al=24
	mul	bh		;ax=24*b=48
	add al,ch	;al=x+24*b=35
	cbw
	mov si,ax	;si=x+24*b=35
	mov al,ch	;al=x=-13
	imul ch		;ax=x^2=169
	mov di,ax	;di=x^2=169
	mov al,bl	;al=a=21
	add al,cl	;al=a+c=56
	cbw 
	imul ax,-4	;ax=-4(a+c)=-224
	add ax,di	;ax=x^2-4(a+c)=-55
	cwd
	idiv si		;ax=(x^2-4(a+c))/(x+24b)=-1
	mov y,al	;y=-1
exit 
end	lab1 