extends Node2D
class_name arpg_player

#movement script/player object for a typical arpg player.

#im trying to remember if i ever ended up doing that up down thing.

#meaning that i check everything on key ups or down. 

@export var m_node : Node2D
@export var v_vec : Vector2i = Vector2i(1,1)		#number of pixels to move each movement
@export var v_skip : Vector2i = Vector2i(1,1)		#number of frames to wait before moving
var point_dir : Vector2i = Vector2i(0,0)

#frame counting - counts frames up to an arbitrary amount to skip movement frames
@export var frame_index : int = 0			#current frame in frame cycle
@export var frame_cap : int = 100			#max frames in frame cycle

@export var player_anim : AnimatedSprite2D

@export var col_box : collision_box

func _input(event):
	collect_input(event)

func _physics_process(_delta):
	move()
	inc_frame()

func move():
	#x movement
	if frame_index % v_skip.x == 0:
		var x : int = point_dir.x
		if col_box.left_area.has_overlapping_areas():
			x = clampi(x, 0, 100)
		if col_box.right_area.has_overlapping_areas():
			x = clampi(x, -100, 0)
		m_node.global_position.x += v_vec.x * x
	
	#y movement
	if frame_index % v_skip.x == 0:
		var y : int = point_dir.y
		if col_box.down_area.has_overlapping_areas():
			y = clampi(y, -100, 0)
		if col_box.up_area.has_overlapping_areas():
			y = clampi(y, 0, 100)
		m_node.global_position.y += v_vec.y * y

func inc_frame():
	frame_index = cmath.cycle_int(frame_index + 1, 0, frame_cap)

func collect_input(e : InputEvent):
	if e.is_action_released("up") || e.is_action_released("down") || e.is_action_released("left") || e.is_action_released("right"):
		point_dir = Vector2i(0,0)
		player_anim.stop()
	
	if Input.is_action_pressed("up"):
		point_dir = Vector2i(0,-1)
		player_anim.play("walk_up")
	if Input.is_action_pressed("down"):
		point_dir = Vector2(0,1)
		player_anim.play("walk_down")
	if Input.is_action_pressed("left"):
		point_dir = Vector2(-1,0)
		player_anim.play("walk_left")
	if Input.is_action_pressed("right"):
		point_dir = Vector2(1,0)
		player_anim.play("walk_right")
	
#region collision signals
	
#enter signals
func _on_collision_box_up_entered():
	pass # Replace with function body.

func _on_collision_box_down_entered():
	pass # Replace with function body.

func _on_collision_box_left_entered():
	pass # Replace with function body.

func _on_collision_box_right_entered():
	pass # Replace with function body.


#exit signals
func _on_collision_box_up_exited():
	pass # Replace with function body.

func _on_collision_box_down_exited():
	pass # Replace with function body.

func _on_collision_box_left_exited():
	pass # Replace with function body.

func _on_collision_box_right_exited():
	pass # Replace with function body.

#endregion




