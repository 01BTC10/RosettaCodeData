/*REXX program gens 100 random points in an annulus: 10 ≤ √(x²+y²) ≤ 15 */
parse arg points low high .            /*allow parms from command line. */
if points==''  then points=100
if    low==''  then  low=10;   low2= low**2  /*define a square shortcut.*/
if   high==''  then high=15;  high2=high**2  /*   "   "    "       "    */
$=
   do x=-high;       x2=x*x            /*gen all possible annulus points*/
   if x<0 & x2>high2  then iterate
   if x>0 & x2>high2  then leave
         do y=-high;       y2=y*y;    s=x2+y2
         if (y<0 & s>high2) | s<low2  then iterate
         if  y>0 & s>high2            then leave
         $=$ x','y                     /*add a point-set to the $ list. */
         end   /*y*/
   end         /*x*/

plotChar='O';    minY=high2;    maxY=-minY;    ap=words($);   field.=

   do j=1  for points                  /*"draw" the x,y points [char O].*/
   parse value word($,random(1,ap))  with  x ',' y  /*pick random point.*/
   field.y=overlay(plotChar, field.y, 2*x+2*high+1) /*"draw: the point. */
   minY=min(minY,y);    maxY=max(maxY,y)            /*plot restricting. */
   end   /*j*/

 do y=minY  to maxY                    /*display the annulus to screen. */
 if field\==''  then say field.y       /*Not blank?   Then display it.  */
 end   /*y*/
                                       /*stick a fork in it, we're done.*/
