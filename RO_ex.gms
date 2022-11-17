*Robust counterpart

Variable  z;
Positive Variables
          x1 
          x2;
Positive Variables
          w1, w2, w3, w4;
          
equations obj, r1, r2, r3;

obj.. z =e= x1 + x2;
r1 .. w1 + w2 + w3 + w4 =l= -5*x1 - 10*x2 + 100;
r2 .. w1 + w2 - w3 - w4 =e= x1;
r3 .. w1 - w2 + w3 - w4 =e= 2*x2;

model ro /all/;

solve ro using lp maximizing z;

display z.l;