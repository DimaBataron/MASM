.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   6
	b   db   -4
	c1  db   3

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(128(a-b)+c^2)/((a-1)*8+78)=10
;y=(2ac-x^2)/(x(12+a)+32b)=-1

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=6
	mov bh,b	;bh=b=-4
	mov cl,c1	;cl=c=31
	mov al,bl	;al=a=6
	dec	al		;al=(a-1)=5
	cbw
	imul ax,8	;ax=(a-1)*8=40
	add ax,78	;ax=(a-1)*8+78=118
	mov ch,al	;ch=(a-1)*8+78=118
	mov al,bl	;al=a=6
	sub al,bh	;al=(a-b)=10
	cbw
	imul ax,128	;ax=128(a-b)=1280
	mov si,ax	;si=128(a-b)=1280
	mov al,cl	;al=c=3
	mul al		;ax=c^2=9
	add ax,si	;ax=128(a-b)+c^2=1289
	div ch		;al=(128(a-b)+c^2)/((a-1)*8+78)=10
	mov ch,al	;ch=x=10
	mov x,al	;x=10
;Вычисляем y
	mov al,12	;al=12
	add	al,bl	;al=12+a=18
	mul ch		;ax=x(12+a)=180
	mov si,ax	;si=x(12+a)=180
	mov al,32	;al=32
	imul bh		;ax=32*b=-128
	add si,ax	;si=x(12+a)+32*b=52
	mov al,2	;al=2
	mul bl		;ax=2*a=12
	mul cl		;ax=2*a*c=36
	mov di,ax	;di=2*a*c=36
	mov al,ch	;al=x=10
	mul al		;ax=x^2=100
	neg ax		;ax=-x^2=-100
	add ax,di	;ax=2ac-x^2=-64
	cwd
	idiv si		;ax=y=(2ac-x^2)/(x(12+a)+32b)=-1
	mov y,al	
exit 
end	lab1 