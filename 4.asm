.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   4
	b   db   7
	c1  db   5

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(3bc(2a-b))/(4a+3c)=3
;y= (14-x^2+c)/(a^2-b3)=-2

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov al,4	;al=4
	mul a		;ax=a*4=16
	mov cx,ax   ;cx=ax=a*4=16
	mov ax,3	;cl=3
	mul c1		;cx=c1*3=15
	add cx,ax   ;cx=a*4+c1*3=31
	mov bl,a	;bl=a=4
	add bl,bl	;bl=2a=8
	sub bl,b	;bl=2a-b=1
	mov al,3	;al=3
	mul b		;ax=3*b=21
	mul c1		;ax=3*b*c1=105
	cwd
	div cx		;ax=(3*b*c1(2a-b))/(4a+3c)=3
	mov cl,al	;cl=(3*b*c1(2a-b))/(4a+3c)=3

;Вычисляем y
	mov al,3	;al=3
	mul b		;ax=3*b=21
	mov bx,ax	;bx=3*b=21
	mov al,a	;al=a=4
	mul al		;ax=a*a=16
	sub ax,bx	;ax=a*a-b*3=-5
	mov bx,ax	;ax=a*a-b*3=-5
	mov al,cl	;al=x=3
	mul al		;ax=x^2=9
	neg ax		;ax=-x^2=-9
	add ax,14	;ax=14-x^2=5
	add al,c1   ;al=14-x^2+c
	idiv bl		;al=(14-x^2+c)/(a^2-b3)=-2
	mov y,al	;y=-2
	mov x,cl	;x=3
exit  ;это макрос, который вызывает функцию ExitProcess, которая
	    ;возвращает управление операционоой системе
end	lab1  ;Это директива ассемблера - определяет точку входа.