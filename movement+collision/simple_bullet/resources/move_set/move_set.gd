extends Resource
class_name move_set


#collection of information for one period of movement in simple bullet.

@export var vel_carry : bool = false
@export var vel_vec : Vector2i = Vector2i(0,0)
@export var vel_skip : Vector2i = Vector2i(2,2)
@export var acc_carry : bool = false
@export var acc_vec : Vector2i = Vector2i(0,0)
@export var acc_skip : Vector2i = Vector2i(2,2)
@export var dur_frames : int = 0



func print_set():
	print(vel_vec,vel_skip)
	print(acc_vec, acc_skip)
	print(dur_frames)
	
