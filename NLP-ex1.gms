$ontext
For a list of functions supported by GAMS, see  section 6.3.3 of "GAMS Users' Guide" (page 55)
For example, the square of a variable can be expressed as "sqr(x)" or "x**2".
$offtext


positive variables x1, x2;

variable z;

equations con1, con2, obj;

obj..   z =e= sqr(x1) + x2**2 - 3*x1 - 4*x2 + 10;
con1..  x1 - 2*x2 =l= -1 ;
con2..  x1 + 2*x2 =l= 4  ;

model course6800 /all/;

x1.l = 4;  x2.l = 5;

option nlp = conopt;

*******************************************************
*** you can select the NLP solver by setting the option
*******************************************************
* option nlp = minos;
* option nlp = knitro;

solve course6800 minimizing z using nlp;

display x1.l, x2.l;
