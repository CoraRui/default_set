extends Node
class_name cmath

#has some weird math functions i feel like i use a lot.

#bounds i cyclically. meaning that once the integer "goes over" upper, it "starts again" on the bottom
static func cycle_int(i : int, lower : int, upper : int) -> int:
	#span between lower and upper
	var div : int = upper - lower
	
	while i > upper:
		i -= div
		
	while i < lower:
		i += div
		
	return i
	
