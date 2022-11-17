Variable  z      "profit";
Positive Variables
          x      "units bought"
          y      "units sold";

Scalars   c      "purchase costs per unit"         / 0.60 /
          r      "revenue per unit sold"           / 1.5 / 
          d      "demand, random parameter"        / 45 /;

Equations profit "profit to be maximized" 
          row1   "demand = UnitsSold + LostSales"
          row2   "inventory = UnitsBought - UnitsSold";

profit..  z =e= -c*x + r*y;
row1..    y =l= x;
row2..    y =l= d;

Model nv / all /;

File emp / '%emp.info%' /;
put emp '* problem %gams.i%'/;
$onput
randvar d discrete 0.333 15 0.333 45 0.333 90
stage 2 y d
stage 2 Row1 Row2
$offput
putclose emp;

Set scen           "scenarios" / s1*s3 /;
Parameter
     s_d(scen)     "demand realization by scenario"
     s_y(scen)     "units sold by scenario"
     s_rep(scen,*) "scenario probability"   / #scen.prob 0/;
 
Set dict / scen .scenario.''
           d    .randvar .s_d
           y    .level   .s_y
           ''   .opt     .s_rep /;
 
solve nv max z use EMP scenario dict;
