import std.stdio, std.string, std.algorithm, std.range;

void main() {
    auto data =
"Given$a$txt$file$of$many$lines,$where$fields$within$a$line$
are$delineated$by$a$single$'dollar'$character,$write$a$program
that$aligns$each$column$of$fields$by$ensuring$that$words$in$each$
column$are$separated$by$at$least$one$space.
Further,$allow$for$each$word$in$a$column$to$be$either$left$
justified,$right$justified,$or$center$justified$within$its$column."
    .splitLines.map!q{ a.chomp("$").split("$") };

    int[int] maxWidths;
    foreach (line; data)
        foreach (i, word; line)
            maxWidths[i] = max(maxWidths.get(i, 0), word.length);

    foreach (just; [&leftJustify!string, &center!string,
                    &rightJustify!string])
        foreach (line; data)
            writefln("%-(%s %)", iota(line.length)
                     .map!(i => just(line[i], maxWidths[i], ' ')));
}
