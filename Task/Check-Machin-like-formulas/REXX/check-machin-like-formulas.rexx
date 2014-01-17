/*REXX program  evaluates  some expressions and verifies their veracity.*/
parse arg digs .;  if digs=='' then digs=100     /*use default for digs?*/
numeric digits digs+10;     numeric fuzz   3;    pi=pi();  !.=
 !.1 = 'pi/4 =    atan(1/2)    +    atan(1/3)'
 !.2 = 'pi/4 =  2*atan(1/3)    +    atan(1/7)'
 !.3 = 'pi/4 =  4*atan(1/5)    -    atan(1/239)'
 !.4 = 'pi/4 =  5*atan(1/7)    +  2*atan(3/79)'
 !.5 = 'pi/4 =  5*atan(29/278) +  7*atan(3/79)'
 !.6 = 'pi/4 =  atan(1/2)      +    atan(1/5)   +    atan(1/8)'
 !.7 = 'pi/4 =  4*atan(1/5)    -    atan(1/70)  +    atan(1/99)'
 !.8 = 'pi/4 =  5*atan(1/7)    +  4*atan(1/53)  +  2*atan(1/4443)'
 !.9 = 'pi/4 =  6*atan(1/8)    +  2*atan(1/57)  +    atan(1/239)'
!.10 = 'pi/4 =  8*atan(1/10)   -    atan(1/239) -  4*atan(1/515)'
!.11 = 'pi/4 = 12*atan(1/18)   +  8*atan(1/57)  -  5*atan(1/239)'
!.12 = 'pi/4 = 16*atan(1/21)   +  3*atan(1/239) +  4*atan(3/1042)'
!.13 = 'pi/4 = 22*atan(1/28)   +  2*atan(1/443) -  5*atan(1/1393) - 10*atan(1/11018)'
!.14 = 'pi/4 = 22*atan(1/38)   + 17*atan(7/601) + 10*atan(7/8149)'
!.15 = 'pi/4 = 44*atan(1/57)   +  7*atan(1/239) - 12*atan(1/682)  + 24*atan(1/12943)'
!.16 = 'pi/4 = 88*atan(1/172)  + 51*atan(1/239) + 32*atan(1/682)  + 44*atan(1/5357)  + 68*atan(1/12943)'
!.17 = 'pi/4 = 88*atan(1/172)  + 51*atan(1/239) + 32*atan(1/682)  + 44*atan(1/5357)  + 68*atan(1/12944)'

        do j=1  while !.j\==''         /*evaluate each of the formulas. */
        interpret  'answer='   "("   !.j   ")"      /*the heavy lifting.*/
        say  right(word('bad OK',answer+1),3)": "     space(!.j,0)
        end   /*j*/                    /* [↑]  show OK | bad, formula.  */
exit                                   /*stick a fork in it, we're done.*/
/*──────────────────────────────────subroutines─────────────────────────*/
Acos: procedure;  parse arg x;   if x<-1 | x>1  then call AcosErr
      return .5*pi()-Asin(x)

Asin: procedure;  parse arg x;   if x<-1 | x>1  then call AsinErr;   s=x*x
      if abs(x)>=.7  then return sign(x)*Acos(sqrt(1-s));  z=x;  o=x;  p=z
      do j=2 by 2; o=o*s*(j-1)/j; z=z+o/(j+1); if z=p then leave; p=z; end
      return z

Atan: procedure; parse arg x; if abs(x)=1  then return pi()/4*sign(x)
                                                return Asin(x/sqrt(1+x**2))
sqrt: procedure; parse arg x; if x=0  then return 0;  m.=9; p=digits(); i=
numeric digits 9; if x<0  then do; x=-x; i='i'; end;  numeric form;  m.0=p
parse value format(x,2,1,,0) 'E0' with g 'E' _ .;     g=g*.5'E'_%2;  m.1=p
      do j=2  while p>9;      m.j=p;   p=p%2+1;                  end /*j*/
      do k=j+5  to 0  by -1;  numeric digits m.k; g=.5*(g+x/g);  end /*k*/
                              numeric digits m.0;     return (g/1)i
pi: return,
3.14159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651

AcosErr: call tellErr 'Acos(x),  X  must be in the range of  -1 ──► +1,  X='||x
AsinErr: call tellErr 'Asin(x),  X  must be in the range of  -1 ──► +1,  X='||x
tanErr:  call tellErr 'tan(' || x") causes division by zero,  X=" || x
tellErr: say; say '*** error! ***'; say;   say arg(1); say;   exit 13
