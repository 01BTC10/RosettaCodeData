/*REXX program to display:              1, 2, 3, 4, 5, 6, 7, 8, 9, 10   */

     do j=1  for 10                    /*using  FOR  is faster than  TO.*/
     call charout ,j ||copies(', ',j<10) /*show J, maybe append a comma.*/
     end     /*j*/
                                       /*stick a fork in it, we're done.*/
