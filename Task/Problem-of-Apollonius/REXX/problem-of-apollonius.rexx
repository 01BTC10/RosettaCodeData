/*REXX program to solve the problem of Apollonius,  named after the     */
/*  Greek,  Apollonius of Perga [Pergaeus]    (circa 262 BC ──► 190 BC).*/

w=15;  numeric digits w                /*width used to display numbers. */
c1.x=0;    c1.y=0;    c1.r=1
c2.x=4;    c2.y=0;    c2.r=1
c3.x=2;    c3.y=4;    c3.r=2
call tell 'external tangent:', solveApollonius( 1, 1, 1)
call tell 'internal tangent:', solveApollonius(-1,-1,-1)
exit                                   /*stick a fork in it, we're done.*/

/*──────────────────────────────────SOLVEAPOLLONIUS subroutine──────────*/
/*───────────────────this code should be covered with a very think tarp.*/
solveApollonius: arg s1,s2,s3          /*internal or external tangent ? */
numeric digits digits()*3              /*reduce rounding: use triple dig*/
x1=c1.x;  x2=c2.x;  x3=c3.x
y1=c1.y;  y2=c2.y;  y3=c3.y
r1=c1.r;  r2=c2.r;  r3=c3.r
va=2*x2-2*x1;        vb=2*y2-2*y1;  vc=x1*x1-x2*x2+y1*y1-y2*y2-r1*r1+r2*r2
vd=2*s2*r2-2*s1*r1;  ve=2*x3-2*x2;  vf=2*y3-2*y2
vg=x2*x2-x3*x3+y2*y2-y3*y3-r2*r2+r3*r3;  vh=2*s3*r3-2*s2*r2
vj=vb/va;     vk=vc/va;     vm=vd/va
vn=vf/ve-vj;  vp=vg/ve-vk;  vr=vh/ve-vm;
p=-vp/vn
q= vr/vn
m=-vj*p-vk
n=vm-vj*q
a=n*n+q*q-1
b=2*m*n-2*n*x1+2*p*q-2*q*y1+2*s1*r1
c=x1*x1+m*m-2*m*x1+p*p+y1*y1-2*p*y1-r1*r1
_=b*b-4*a*c;  $.r=(-b-sqrt(_))/(a+a);  $.x=m+n*$.r;  $.y=p+q*$.r
return $.x $.y $.r                     /*return with the money.         */

/*──────────────────────────────────SQRT subroutine──────────────────────────*/
sqrt: procedure; parse arg x; if x=0 then return 0;d=digits();numeric digits 11
 g=.sqGuess();   do j=0 while p>9;  m.j=p;  p=p%2+1; end;   do k=j+5 to 0 by -1
 if m.k>11 then numeric digits m.k;g=.5*(g+x/g);end;numeric digits d;return g/1

.sqGuess: if x<0 then say 'negative number' x;    numeric form;    m.=11
 p=d+d%4+2; parse value format(x,2,1,,0) 'E0' with g 'E' _ .; return g*.5'E'_%2

/*──────────────────────────────────TELL subroutine─────────────────────*/
tell: parse arg _,a b c; say _ left(a/1,w) left(b/1,w) left(c/1,w); return
                                       /*dividing by 1 reformats #s to W*/
