variable z, x1, x2;
binary variable y;

x1.lo = 0; x2.lo = 0;

equations obj, c1, c2, c3;

obj..  z =e= -4*y -0.15*x1 + 0.28*x2;
c1..   x1 =e= 1.4*x2;
c2..   x1 =l= 80*y ;
c3..   x2 =l= 50*y ;

model course6800 /all/;

option optcr = 0;

solve course6800 using mip maximizing z;
