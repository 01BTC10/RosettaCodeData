/*REXX program displays numbers  1 âââº 100  for the  FizzBuzz  problem. */

  do n=1  for 100;  _=
  if n//3 ==0  then _= 'Fizz'
  if n//5 ==0  then _=_'Buzz'
  say right(word(_ n,1),8)
  end   /*n*/
                                       /*stick a fork in it, we're done.*/
