First thoughts in Conway's Game of Life script.

I'm going need to define the board first.
I should be able to find some kind of general grid setup on a google search, a generic setup. Cartesian x,y coordinates would be the basis.  

  1 2 3
1 z z z
2 z z z
3 z z z

Google search tick tack do?  No, it doesn't involve sensing neighbors.  Minesweeper would be more on the nose.
Perhaps set up as 3 arrays?  This isn't going to have UI, so no Iframes sort of setup necessary.  
Or is is there advantage to hash? Advantage to key value pair?

1 = [z,z,z]
2 = [z,z,z]
3 = [z,z,z]

An array of arrays?
board_grid = [ [z,z,z], [z,z,z], [z,z,z] ]

That won't require me to worry about going out of bounds with sensing the surrounding area perhaps?
Actually the reverse problem exists.  1,1 zone's sense neighbors will be different than sensing the 2,2 zone neighbors.  I can make handling for the zones on the edges. But it would actually be easier on a 9x9 grid because the edges are more unusual cases.  In this case only 1 zone requires 360 and I'd be making exceptions for every single zone.

board = {1a: z, 1b: z, 1c: z, 2a: z, 2b: z, 2c: z, 3a: z, 3b: z, 3c: z}

Using the number/letter has key probably isn't helpful over using a number-number key as it can be resolved with simple math x + 1, y-1 less easily, would take unnecessary extra steps, off the top of my head.

Gathering neighbor information would be x+1, y-1 type of scan around the neighborhood.  always by absolute value of 1, with positive and negative coordinates. 
The edge zone is an issue, makes each zone scan customized.  I'm sure there is an algorithm for that.
The 4 corner cases neighbor scans would actually be the same for all 4 corners, just rotated 90 degress.  So a method could be made with an argument that creates that rotation. If it were 180, I think perhaps multiply by -1 to invert?
Certainly could be done with an 2 arguments of 1, -1 and -1, -1, etc.  But do I need to use 2 arguments each time?
The 4 center edge cases also just need rotation to re-use.
The center would have the 360.  That method would only be used one time.
So 3 scan methods, 2 taking arguments of (x, y).  
Unless I can find a way to make a separate rotator method that takes one argument and that method, in turn, is applied to needed sensing method?  
Would it be wise to create separate files for different objects?  Would that create benefit?  Re-use isn't a factor here.

So those methods check what is there in the neighboring zones.  Then I need to evaluate what they find.  Feed the detected zone values into an array and count them/evaluate them.  That evaluation is fed to a method that determines the new value?

Start coding

I don't see an advantage to collections off the top of my head.
Lets display the board first.






