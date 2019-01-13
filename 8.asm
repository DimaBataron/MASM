.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   -13
	b   db   8
	c1  db   -128

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(2с-7ba^2)/(3(a+b)+c)=67
;y=(x-c)/((102+ab)(x-20))=-2

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov al,a	;al=a=-13
	add al,b	;al=a+b=-5
	cbw
	imul ax,3	;ax=3(a+b)=-15
	mov cx,ax	;cx=3*(a+b)=-15
	mov al,c1	;al=c1=-128
	cbw
	add ax,cx	;ax=3*(a+b)+c1=-143
	mov cx,ax	;cx=3*(a+b)+c1=-143
	mov al,c1	;al=c1=-128
	cbw
	add ax,ax	;ax=2c1=-256
	mov bx,ax	;bx=2c1=-256
	mov al,a	;al=a=-13
	imul al		;ax=a^2=169
	mul b		;ax=a^2*b=1352
	imul ax,-7	;ax=-9464
	add ax,bx	;ax=2c-7ba^2=-9720
	cwd
	idiv cx		;ax=(2с-7ba^2)/(3(a+b)+c)=67
	mov x,al	;x=67
;Вычисляем y
	mov bx,102	;bx=102
	mov al,a	;al=a=-13
	imul b		;ax=a*b=-104
	add bl,al	;bx=102+ab=-2
	mov al,x	;al=x=67
	add al,-20	;al=x-20=47
	imul bl		;ax=(102+ab)(x-20)=-94
	mov bl,al	;bl=(102+ab)(x-20)=-94
	mov al,c1	;al=c1=-128
	cbw 
	mov cx,ax	;cx=c1=-128
	mov al,x	;al=x=67
	cbw
	sub ax,cx	;ax=x-c1=195
	idiv bl		;al=(x-c)/((102+ab)(x-20))=-2
	mov y,al	;y=-2
exit 
end	lab1 