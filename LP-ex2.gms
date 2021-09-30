 sets   i plants /seattle, SD/      ;
 set    j markets /NY, chicago, topeka/;

 parameter
       a(i) capacity of each plant
       / seattle    350
         SD         600/

       d(j)  demand in each market
       / NY 325
         chicago 300
         topeka 275  /;

 table c(i,j) unit transportation cost
             NY    chicago   topeka
   seattle  2.5     1.7        1.8
   SD       2.5     1.8        1.4
  ;

 variable x(i,j), z;
 equations cost, sup(i), dem(j);

 cost..   z=e= sum((i,j), c(i,j)*x(i,j) );
 sup(i)..   sum(j, x(i,j) ) =l= a(i)    ;
 dem(j)..   sum(i, x(i,j) ) =g= d(j)    ;

 x.lo(i,j) = 0;


 model transport /all/;
 solve transport using lp minimizing z;

 display x.L;
