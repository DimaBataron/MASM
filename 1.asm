.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   11
	b   db    2
	c1  db    21

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   dw    ?
	y   dw    ?

;x=(9*a*b + 4*a*c)/(b^2 - 2*(a+2))
;y= (x*c-b^2)/(16*(a-14)+2x)

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov al,a	;al=11
	add al,2	;al=(a+2)=13
	mov ah,-2   ;ah=-2
	imul ah		;ax=-2(a+2)=-26
	mov cx,ax	;cx=-2(a+2)=-26
	mov al,b	;al=b=2
	mul al		;ax=b^2=4
	add cx,ax	;cx=b^2-2(a+2)=-22
	mov al,9    ;al=9
	mul a		;ax=9*a=99
	mul b		;ax=9*a*b=198
	mov bx,ax   ;bx=9*a*b=198
	mov al,4	;al=4
	mul a       ;ax=4*a=44
	mul c1		;ax=4*a*c=924
	add ax,bx	;ax=4*a*c + 9*a*b=1122
	cwd			;dx:ax=ax
	idiv cx		;ax=(4*a*c + 9*a*b)/(b^2-2(a+2))=-51
	mov bp,ax	;bp=(4*a*c + 9*a*b)/(b^2-2(a+2))=-51
;Вычисляем y
	mov al,-14	;al=-14
	add al,a	;al=a-14=-3
	cbw			;ax=a-14=-3
	imul ax,16	;ax=(a-14)*16=-48
	mov cx,bp   ;cx=(4*a*c + 9*a*b)/(b^2-2(a+2))=-51
	add cx,cx	;cx=2*(4*a*c + 9*a*b)/(b^2-2(a+2))=-102
	add cx,ax   ;cx=x+(a-14)*16=-150
	mov al,c1	;al=c1=21
	cbw         ;ax=al
	imul bp		;dx:ax=c1*x=-1071
	mov bx,ax	;bx=c1*x=-1071
	mov al,b	;al=b=2
	add al,al	;al=b^2=4
	cbw
	neg ax		;ax=-b^2=-4
	add ax,bx	;bx=c1*x-b^2=-1075
	cwd         ;dx:ax=ax
	idiv cx		;ax=(c1*x-b^2)/(x+(a-14)*16)=7
	mov x,bp	
	mov y,ax	
exit  ;это макрос, который вызывает функцию ExitProcess, которая
	    ;возвращает управление операционоой системе
end	lab1  ;Это директива ассемблера - определяет точку входа.