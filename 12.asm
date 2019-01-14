.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   6
	b   db   61
	c1  db   31

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   dw    ?

;x=(24ab+8c)/(3ab-bc)=-11
;y=((x+1)-b^2)/(c-3(a+3))=-932

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=6
	mov al,3	;al=3
	mov bh,b	;bh=b=61
	mov cl,c1	;cl=c=31
	mul bl		;ax=3*a=18
	mul bh		;ax=3*a*b=1098
	mov di,ax	;di=3*a*b=1098
	mov al,bh	;al=b=61
	mul cl		;ax=b*c=1891
	neg ax		;ax=-b*c=-1891
	add di,ax	;di=3ab-bc=-793
	mov al,24	;al=24
	mul	bl		;ax=24*a=144
	mul bh		;ax=24*a*b=8784
	mov si,ax	;si=24*a*b=8784
	mov al,8	;al=8
	mul cl		;ax=8*c=248
	add ax,si	;ax=24ab+8c=9032
	cwd
	idiv di		;ax=(24ab+8c)/(3ab-bc)=-11
	mov ch,al	;ch=x=-11
	mov x,al	;x=-11
;Вычисляем y
	mov al,bl	;al=a=6
	add al,3	;al=(a+3)=9
	cbw
	imul ax,-3	;ax=-3(a+3)=-27
	add al,cl	;al=c-3(a+3)=4
	cbw
	mov di,ax	;di=c-3(a+3)=4
	mov al,bh	;al=b=61
	mul al		;ax=b^2=3721
	neg ax		;ax=-b^2=-3721
	inc ch		;ch=x+1=-10
	xchg ax,cx	;обмен
	mov al,ah
	cbw
	add ax,cx	;ax=(x+1)-b^2=-3731
	cwd
	idiv di		;ax=((x+1)-b^2)/(c-3(a+3))=-932
	mov y,ax	;y=-932
exit 
end	lab1 