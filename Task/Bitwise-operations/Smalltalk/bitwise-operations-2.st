(a bitClear: b) "mask out bits"
(a bitAt: index) "retrieve a bit (bit-index, one-based)"
(a setBit: index) "set a bit (bit-index)"
(a clearBit: index) "clear a bit (bit-index)"
(a invertBit: index) "invert a bit (bit index)"
lowBit "find the index of the lowest one-bit; zero if none"
highBit "find the index of the highest one-bit; zero if none"
bitCount "count the one-bits"