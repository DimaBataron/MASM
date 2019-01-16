.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   22
	b   db   -2
	c1  db   3

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(ca^2+18(b-c))/(14c+16ab)=-2
;y=(4c+14(x-a)+18)/((b-c)^2-32b)=-3

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=22
	mov bh,b	;bh=b=-2
	mov cl,c1	;cl=c=3
	mov al,bl	;al=a=22
	imul bh		;ax=ab=-44
	imul ax,16	;ax=16ab=-704
	mov si,ax	;si=16ab=-704
	mov al,cl	;al=c=3
	cbw
	imul ax,14	;ax=14c=42
	add si,ax	;si=14c+16ab=-662
	mov al,bl	;al=a=22
	mul bl		;ax=a^2=484
	mov di,ax	;di=a^2=484
	mov al,cl	;al=c=3
	cbw
	imul di,ax	;di=c*a^2=1452
	mov al,bh	;al=b=-2
	sub al,cl	;al=b-c=-5
	cbw
	imul ax,18	;ax=18(b-c)=-90
	add ax,di	;ax=ca^2+18(b-c)=1362
	cwd
	idiv si		;ax=(ca^2+18(b-c))/(14c+16ab)=-2
	mov ch,al	;ch=x=-2
	mov x,al	;x=-2
;Вычисляем y
	mov al,32	;al=32
	imul bh		;ax=32b=-64
	mov si,ax	;si=32b=-64
	neg si
	mov al,bh	;al=b=-2
	sub al,cl	;al=b-c=-5
	imul al		;ax=(b-c)^2=25
	add si,ax	;si=(b-c)^2-32b=89
	mov al,ch	;al=x=-2
	sub al,bl	;al=x-a=-24
	cbw
	imul ax,14	;ax=14(x-a)=-336
	mov di,ax	;di=14(x-a)=-336
	mov al,4	;al=4
	mul cl		;ax=4c=12
	add ax,di	;ax=4c+14(x-a)=-324
	add ax,18	;ax=4c+14(x-a)=-306
	cwd
	idiv si		;ax=(4c+14(x-a)+18)/((b-c)^2-32b)=-3
	mov y,al	;y=-3
exit 
end	lab1 