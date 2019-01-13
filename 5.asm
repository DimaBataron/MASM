.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   5
	b   db   3
	c1  db   -3

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(12a^2+8b)/(2c^2-a)=24
;y=((21+a)x+1)/(14-bc)=27

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov al,c1	;al=c1=-3
	imul al		;ax=c1*c1=9
	add ax,ax	;ax=2*c1*c1=18
	sub al,a	;al=2*c1^2-a=13
	mov cl,al	;cl=2*c1^2-a=13
	mov al,a	;al=a=5
	mul al		;ax=a*a=25
	imul ax,12	;ax=a*a*12=300
	mov bx,ax	;bx=a*a*12=300
	mov al,8	;al=8
	mul	b		;ax=8*b=24
	add ax,bx	;ax=a*a*12+8*b=324
	div cl		;al=(12a^2+8b)/(2c^2-a)=24
	mov x,al	;x=al
;Вычисляем y
	mov al,b	;al=b=3
	imul c1		;ax=b*c1=-9
	neg ax		;ax=-b*c1=9
	add ax,14	;ax=14-b*c1=23
	mov cl,al	;cl=14-b*c1=23
	mov al,a	;al=a=5
	add al,21	;al=a+21=26
	mul x		;ax=(a+21)*x=624
	inc ax		;ax=(a+21)*x+1=625
	div cl		;al=((21+a)x+1)/(14-bc)=27
	mov y,al	;y=27
exit  ;это макрос, который вызывает функцию ExitProcess, которая
	    ;возвращает управление операционоой системе
end	lab1  ;Это директива ассемблера - определяет точку входа.