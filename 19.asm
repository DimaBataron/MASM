.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   7
	b   db   -9
	c1  db   -10

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(b^3-ac+12)/((a-b)8+c)=-5
;y=(12(x+a)+x^2)/(x+(b-c)12)=7

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=7
	mov bh,b	;bh=b=-9
	mov cl,c1	;cl=c=-10
	mov al,bl	;al=a=7
	sub al,bh	;al=(a-b)=16
	cbw
	imul ax,8	;ax=(a-b)8=128
	mov si,ax	;si=(a-b)8=128
	mov al,cl	;al=c=-10
	cbw
	add si,ax	;si=(a-b)8+c=118
	mov al,bh	;al=b=-9
	imul bh		;ax=b^2=81
	imul bh		;ax=b^3=-729
	mov di,ax	;di=b^3=-729
	mov al,bl	;al=a=7
	imul cl		;ax=ac=-70
	neg ax		;ax=-ac=70
	add ax,12	;ax=-ac+12=82
	add ax,di	;ax=b^3-ac+12=-647
	cwd
	idiv si		;ax=(b^3-ac+12)/((a-b)8+c)=-5
	mov ch,al	;ch=x=-5
	mov x,ch	;x=-5
;Вычисляем y
	mov al,bh	;al=b=-9
	sub al,cl	;al=b-c=1
	cbw
	imul ax,12	;ax=(b-c)12=12
	add al,ch	;al=x+(b-c)12=7
	cbw
	mov si,ax	;si=x+(b-c)12=7
	mov al,ch	;al=x=-5
	imul ch		;ax=x^2=25
	mov di,ax	;di=x^2=25
	mov al,ch	;al=x=-5
	add al,bl	;al=(x+a)=2
	cbw
	imul ax,12	;ax=12(x+a)=24
	add ax,di	;ax=12(x+a)+x^2=49
	cwd
	idiv si		;ax=(12(x+a)+x^2)/(x+(b-c)12)=7
	mov y,al	;y=7
exit 
end	lab1 