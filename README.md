## First thoughts in Conway's Game of Life script.

I'm going need to define the board first.
I should be able to find some kind of general grid setup on a google search, a generic setup. Cartesian x,y coordinates would be the basis.  This will open the door to off-by-one issues.

&nbsp;  1 2 3  
3 z z z  
2 z z z  
1 z z z  

Google search tick tack toe?  No, it doesn't involve sensing neighbors.  Minesweeper would be more on the nose.
Perhaps set up as 3 arrays?  This isn't going to have UI, so no Iframes sort of setup necessary.  
Or is is there advantage to hash? Advantage to key value pair?
  
1 = \[z,z,z\]  
2 = \[z,z,z\]  
3 = \[z,z,z\]  
  
An array of arrays?
board_grid = \[ \[z,z,z\], \[z,z,z\], \[z,z,z\] \]  

That won't require me to worry about going out of bounds with sensing the surrounding area perhaps?
Actually the reverse problem exists.  1,1 zone's sense neighbors will be different than sensing the 2,2 zone neighbors.  I can make handling for the zones on the edges. But it would actually be easier on a 9x9 grid because the edges are more unusual cases.  In this case only 1 zone requires 360 and I'd be making exceptions for every single zone.
  
board = \{1a: z, 1b: z, 1c: z, 2a: z, 2b: z, 2c: z, 3a: z, 3b: z, 3c: z\}  
  
Using the number/letter combination as key/value pairs probably isn't helpful over using a number/number key. number/letter can be resolved more simply for surrounding zone scan with simple math x + 1, y-1 less easily, would take unnecessary extra steps, off the top of my head.  If hash is the way, keys should be number/number.

Gathering neighbor information would be a x+1, y-1 style of scan around the neighborhood.  Always by absolute value of 1, with positive and negative coordinates. 
The edge zone is an issue, makes each zone scan customized.  I'm sure there is an algorithm for that.
The 4 corner cases neighbor scans would actually be the same for all 4 corners, just rotated 90 degress.  So a method could be made with an argument that creates that rotation. If it were 180, I think perhaps multiply by -1 to invert?
Such a rotation of a corner method could certainly be done with an 2 arguments of 1, -1 and -1, -1, etc.  But do I need to use 2 arguments each time?
The 4 middle edge cases also just need rotation to re-use.
The center would have the 360 scan.  That method would only be used one time.
So 3 scan methods, 2 taking arguments of \(x, y\).  
Unless I can find a way to make a separate rotator method that takes one argument and that method, in turn, is applied to a separate sensing method?  
Would it be wise to create separate files for different objects?  Would that create benefit?  Perhaps not, re-use isn't a requirement here.

So those methods check what is there in the neighboring zones.  Then I need to evaluate what they find.  Feed the detected zone values into an array and count them/evaluate them.  That evaluation is fed to a method that determines the new value?

Start coding

I don't see an advantage to collections off the top of my head.
Lets display the board first.


## Midway

First I wanted to make the display of the grids for visual confirmation.  If you look to my git history, I used puts to display each step and confirm it before proceeding.
I was very wary of off-by-one error potential at every step.

Originally, I was going to use an array of arrays, then after I stepped away from it for a few hours, I realized that I would have to have methods to check the surrounding neighbor values of corners zones \(such as the upper left corner\), side middle zone \(the middle X in the left side column\) methods and a middle zone method.  And those methods \(except for middle zone\) would have to rotate 90 degrees for each counterpart.  I needed a deeper abstraction.  The only simple perimeter scan of zone values would be the middle zone because it scans 360 degrees around without looking outside of the bounds.  It seemed to me the best way was to find a way to make a single 360 scan method.  But how to deal with the scan looking out of the boundaries of the game?  I stepped away from coding to dinner and it I came up with a solution.  If Then I realized that, if I could make the center zone 0,0, then I just have to reject any out-of-bounds on a single 360 degree scan on each zone because the out of bounds zone would automatically have a absolute value of 2.  And that could be filtered out, covering all directions. 

So that made it essential to use a hash.


## Midway checklist

DONE - ok, shift zero to the center zone of the grid, so the same method will for for checking all adjacent  
DONE - Move that into a collection  
DONE - Then remove from the collection anything with a "2"  
DONE - Use the remaining collection as coordinates to check zone values  
DONE - Push zone values into a different collection and total instances of O and X  
DONE - compare counts of values to the rules  
DONE - use compare results to modify the zone accordingly to O and X  

## Refactor

Refactoring to classes
First thoughts are to give the existing methods a class
Need to look up proper script structure, haven't actually done a plain Ruby script in a while. 
I think, without testing, the best approach is extract each method one by one to a class.  Modify it.  Then run the script to ensure it works.
Making these canges will take some comments out of context, will need to review at the end.

Once separated into classes, examine the methods for things that can be separated into other methods.






