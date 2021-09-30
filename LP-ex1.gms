variables x1, x2, x3, z;

equations obj, c1, c2, c3;


obj..   z =e= 60*x1 + 30*x2 + 20*x3 ;

c1..     8*x1 + 6*x2 + x3 =l= 48   ;

c2..     4*x1 + 2*x2 + 1.5*x3 =e= 20  ;

c3..     2*x1 + 1.5*x2 + 0.5*x3 =g= 8  ;

x1.lo = 0;

x2.lo = 0;
x2.up = 10;

model course6800 /all/;

*model course6800 /obj, c1, c2, c3/;

option lp=cbc;

solve course6800 using lp maximizing z;
