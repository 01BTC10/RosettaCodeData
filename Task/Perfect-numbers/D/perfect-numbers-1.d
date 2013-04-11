import std.stdio, std.math, std.range, std.algorithm;

bool isPerfectNumber(in int n) pure nothrow {
    if (n < 2)
        return false;

    int sum = 1;
    foreach (i; 2 .. cast(int)sqrt(cast(real)n) + 1)
        if (n % i == 0) {
            immutable int q = n / i;
            sum += i;
            if (q > i)
                sum += q;
        }

    return sum == n;
}

void main() {
    iota(10_000).filter!isPerfectNumber().writeln();
}
