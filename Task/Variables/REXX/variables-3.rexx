/*REXX pgm to do a "bad" assignment  (with an unassigned REXX variable).*/

signal on novalue                      /*usually, placed at pgm start.  */

xxx=aaaaa                              /*tries to assign aaaaa ───► xxx */

say xxx 'or somesuch'
exit

novalue:                               /*this can be dressed up better. */
badLine  =sigl                         /*REXX statement num that failed.*/
badSource=sourceline(badLine)          /*REXX source statement ···      */
badVar   =condition('D')               /*REXX var name that's ¬ defined.*/
say
say '*** error! ***'
say 'undefined variable' badvar "at REXX statement number" badLine
say
say badSource
say
exit 13
