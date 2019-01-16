.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   4
	b   db   2
	c1  db   3

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(a^3+c^2(b+2))/(7b-3a)=50
;y=(14(x-a)+10b)/(cx-14a)=7

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=4
	mov bh,b	;bh=b=2
	mov cl,c1	;cl=c=3
	mov al,3	;al=3
	mul bl		;ax=3a=12
	neg ax
	mov si,ax	;si=3a=-12
	mov al,7	;al=7
	mul bh		;ax=7b=14
	add si,ax	;si=7b-3a=2
	mov al,bl	;al=a=4
	mul bl		;ax=a^2=16
	mul bl		;ax=a^3=64
	mov di,ax	;di=a^3=64
	mov al,bh	;al=b=2
	add al,2	;al=b+2=4
	mul cl		;ax=c(b+2)=12
	mul cl		;ax=c^2(b+2)=36
	add ax,di	;ax=a^3+c^2(b+2)=100
	cwd
	div si		;ax=(a^3+c^2(b+2))/(7b-3a)=50
	mov ch,al	;ch=x=50
	mov x,al	;x=50
;Вычисляем y
	mov al,14;	;al=14
	mul bl		;ax=14a=56
	neg ax		;ax=-14a=-56
	mov si,ax	;si=-14a=-56
	mov al,cl	;al=c=3
	mul ch		;ax=cx=150
	add si,ax	;si=cx-14a=94
	mov al,ch	;al=x=50
	sub al,bl	;al=(x-a)=46
	cbw
	imul ax,14	;ax=14(x-a)=644
	mov di,ax	;di=14(x-a)=644
	mov al,10	;al=10
	mul bh		;ax=10b=20
	add ax,di	;ax=14(x-a)+10b=664
	cwd
	div si		;ax=(14(x-a)+10b)/(cx-14a)=7
	mov y,al	;y=7
exit 
end	lab1 