/*REXX program calculates/shows some values for the Ackermann function. */
high=24
numeric digits 100        /*have REXX to use up to  100  digit integers.*/

                          /*When REXX raises a number to a power  (via  */
                          /*  the   **  operator), the power must be an */
                          /*  integer  (positive,  zero,  or negative). */

       do j=0 to 4;  say  /*Ackermann(5,1) is a bit impractical to calc.*/
             do k=0 to high%(max(1,j))
             call Ackermann_tell j,k
             if j==4 & k==2 then leave    /*no sense in going overboard.*/
             end   /*k*/
       end         /*j*/
exit                                   /*stick a fork in it, we're done.*/
/*ââââââââââââââââââââââââââââââââââACKERMANN_TELL subroutineâââââââââââ*/
ackermann_tell: parse arg mm,nn;   calls=0    /*display an echo message.*/
nnn=right(nn,length(high))
say 'Ackermann('mm","nnn')='right(ackermann(mm,nn),high),
                             left('',12) 'calls='right(calls,10)
return
/*ââââââââââââââââââââââââââââââââââACKERMANN subroutineââââââââââââââââ*/
ackermann: procedure expose calls      /*compute the Ackerman function. */
parse arg m,n;      calls=calls+1
if m==0 then return n+1
if m==1 then return n+2
if m==2 then return n+n+3
if m==3 then return 2**(n+3)-3
if m==4 then do;  a=2
                         do (n+3)-1     /*ugh!*/
                         a=2**a
                         end
             return a-3
             end
if n==0 then return ackermann(m-1,1)
             return ackermann(m-1,ackermann(m,n-1))
