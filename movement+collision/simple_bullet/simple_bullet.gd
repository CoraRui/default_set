extends Node2D
class_name simple_bullet

#TODO: add more functionality to the simple bullet class
#TODO: how does acceleration actually effect velocity? how can i use acceleration on frame skips?

#so i fixed the acceleration! by removing it... i just dont think it would work with the whole frame skipping thing.
#so ill just do the accelerations manually by changing the velocity at certain points.
#which will work with non adjustable movements. but how would i do something that would follow a certain
#object, or have some sort of parameter of movement dependent on something else?
#if i wanted something like wind, i could just put two bullet scripts on top of each other, and have one script 
#move in the opposite direction.

@export var target_node : Node2D

@export var move_queue : Array[move_set]	#array holding all movement phases
@onready var active_set : move_set = move_queue[move_index]
@export var move_index : int = 0			#index indicating which movement phase the queue is on
@export var move_frame : int = 0			#timer for moving onto next move set.
var fsli : int = 0
@export var fsl : int = 100				#frame skip length, incremented every frame to determine how many frames a 
#movement should skip



func _physics_process(delta):
	move()
	count_frames()


func move():
	if fsli % active_set.vel_skip.x == 0:
		target_node.global_position.x += active_set.vel_vec.x
	if fsli % active_set.vel_skip.y == 0:
		target_node.global_position.y += active_set.vel_vec.y
	if fsli % active_set.acc_skip.x == 0:
		active_set.vel_vec.x += active_set.acc_vec.x
	if fsli % active_set.acc_skip.y == 0:
		active_set.vel_vec.y += active_set.acc_vec.y
		
		
func count_frames():
	#checks to see if should move onto next move scheme
	move_frame += 1
	if move_frame > move_queue[move_index].dur_frames:
		move_index += 1
		move_frame = 0
		if move_index > move_queue.size() - 1:
			move_index = 0
		active_set = move_queue[move_index]
	fsli += 1
	if fsli >= fsl:
		fsl = 0

	
