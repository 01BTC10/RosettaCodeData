constant mapping = :OPEN(' '),
		      :N< ╵ >,
		      :E< ╶ >,
		     :NE< └ >,
		      :S< ╷ >,
		     :NS< │ >,
		     :ES< ┌ >,
		    :NES< ├ >,
		      :W< ╴ >,
		     :NW< ┘ >,
		     :EW< ─ >,
		    :NEW< ┴ >,
		     :SW< ┐ >,
		    :NSW< ┤ >,
		    :ESW< ┬ >,
		   :NESW< ┼ >,
		   :TODO< x >,
	          :TRIED< · >;

enum Code (mapping.map: *.key);
my @code = mapping.map: *.value;

enum Direction <DeadEnd Up Right Down Left>;

sub gen_maze ( $X,
               $Y,
               $start_x = (^$X).pick * 2 + 1,
               $start_y = (^$Y).pick * 2 + 1 )
{
    my @maze;
    push @maze, [ ES, -N, (ESW, EW) xx $X - 1, SW ];
    push @maze, [ (NS, TODO) xx $X, NS ];
    for 1 ..^ $Y {
	push @maze, [ NES, EW, (NESW, EW) xx $X - 1, NSW ];
	push @maze, [ (NS, TODO) xx $X, NS ];
    }
    push @maze, [ NE, (EW, NEW) xx $X - 1, -NS, NW ];
    @maze[$start_y][$start_x] = OPEN;

    my @stack;
    my $current = [$start_x, $start_y];
    loop {
        if my $dir = pick_direction( $current ) {
            @stack.push: $current;
            $current = move( $dir, $current );
        }
        else {
            last unless @stack;
            $current = @stack.pop;
        }
    }
    return @maze;

    sub pick_direction([$x,$y]) {
	my @neighbors =
	    (Up    if @maze[$y - 2][$x]),
	    (Down  if @maze[$y + 2][$x]),
	    (Left  if @maze[$y][$x - 2]),
	    (Right if @maze[$y][$x + 2]);
	@neighbors.pick or DeadEnd;
    }

    sub move ($dir, @cur) {
	my ($x,$y) = @cur;
	given $dir {
	    when Up    { @maze[--$y][$x] = OPEN; @maze[$y][$x-1] -= E; @maze[$y--][$x+1] -= W; }
	    when Down  { @maze[++$y][$x] = OPEN; @maze[$y][$x-1] -= E; @maze[$y++][$x+1] -= W; }
	    when Left  { @maze[$y][--$x] = OPEN; @maze[$y-1][$x] -= S; @maze[$y+1][$x--] -= N; }
	    when Right { @maze[$y][++$x] = OPEN; @maze[$y-1][$x] -= S; @maze[$y+1][$x++] -= N; }
	}
	@maze[$y][$x] = 0;
	[$x,$y];
    }
}

sub display (@maze) {
    for @maze -> @y {
	for @y -> $w, $c {
	    print @code[abs $w];
	    if $c >= 0 { print @code[$c] x 3 }
	    else { print ' ', @code[abs $c], ' ' }
	}
	say @code[@y[*-1]];
    }
}

display gen_maze( 29, 19 );
