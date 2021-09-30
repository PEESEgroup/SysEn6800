set type item types /t3*t1/;
set s states /s0*s50/;
set j number of items /j0*j4/;

parameter itemLimit(type) number available
/t1       4
 t2       4
 t3       4/;

parameter weight(type) item weight
/t1       10
 t2       9
 t3       11/;

table benefit(type, j)
    j0  j1  j2  j3  j4
t1  0   46  70  90  105
t2  0   20  45  75  110
t3  0   50  75  80  100
;

* define allowable actions
set allowable(type,s,j);
allowable(type,s,j)=yes$((ord(j)-1<=itemLimit(type)) and ((ord(j)-1)*weight(type) <=ord(s)-1) );

* initialize the optimal values and optimal items at each stage and state
set optimal(type,s,j); optimal(type,s,j)=no;
parameter optimal_items(s,type); optimal_items(s,type)=0;

* definie initial values and boundary conditions; compute the optimal value using recurrence relation
parameter f(type,s); f(type,s)=0;
loop(type,
    f(type,s) = smax(j$allowable(type,s,j), benefit(type, j) + f(type-1, s-((ord(j)-1)*weight(type)) ) ) ;
    optimal(type,s,j) = yes$(f(type,s) = benefit(type, j) + f(type-1, s-((ord(j)-1)*weight(type)) ));
    optimal_items(s,type) = smin(j$optimal(type,s,j), (ord(j)-1));
);

* find the optimal solution and output the results
parameter DPvalue;  DPvalue = f('t1','s50');
*DPvalue = sum((type, s)$(ord(s)=card(s) and ord(type)=card(type)), f(type, s) );

display  DPvalue;

* create a reverse list of set s
alias (s,rs);
set revs(s,rs);
revs(s,s+[card(s)-2*ord(s)+1]) = yes;

$ontext
* output the optimal value table to the LOG files
file log /''/;
put log;

put ' Capacity(s)      f1     Type 1 opt   f2   Type 2 opt    f3     Type 3 opt ' /;

loop {revs(s,rs),
    put '    ' (ord(rs)-1):0:0 '            ' f('t1',rs):0:0 '         ' optimal_items(rs,'t1'):0:0 '          '
    f('t2',rs):0:0 '         ' optimal_items(rs,'t2'):0:0 '        '
    f('t3',rs):0:0 '        ' optimal_items(rs,'t3'):0:0/;
};
$offtext

* output the optimal value table to the LST and LOG files
put_utility 'msgLog'    / 'Below is the optimal value table of this problem.' ;
put_utility 'msgLog'    / ' Capacity(s)      f1     Type 1 opt   f2   Type 2 opt    f3     Type 3 opt ' /;

loop {revs(s,rs),
    put_utility 'msgLog'    /  '    ' (ord(rs)-1):0:0 '            ' f('t1',rs):0:0 '         ' optimal_items(rs,'t1'):0:0 '          '
    f('t2',rs):0:0 '         ' optimal_items(rs,'t2'):0:0 '        '
    f('t3',rs):0:0 '        ' optimal_items(rs,'t3'):0:0/;
};

