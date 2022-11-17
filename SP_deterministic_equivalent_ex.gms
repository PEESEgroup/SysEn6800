Variable  z      "profit";
Positive Variables
          x      "units bought"
          y      "units sold";

Scalars   c      "purchase costs per unit"         / 0.60 /
          r      "revenue per unit sold"           / 1.5 /;

Sets s /s1*s3/;

Parameters d(s) /s1 15, s2 45, s3 90/
           probability(s) /s1 0.333, s2 0.333, s3 0.333/;

Equations profit "profit to be maximized" 
          row1(s)   "demand = UnitsSold + LostSales"
          row2(s)   "inventory = UnitsBought - UnitsSold";

profit..  z =e= -c*x + sum(s, probability(s)*r*y(s));
row1(s)..    y(s) =l= x;
row2(s)..    y(s) =l= d(s);

Model nv / all /;
 
solve nv maximizing z using lp;