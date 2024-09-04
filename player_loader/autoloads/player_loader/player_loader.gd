extends Node2D
class_name player_loader

#loads the player in and out of the scene. not sure how this will really be much different from the scene loader.

@export var player_ref : PackedScene

@export var player_ins : Node2D

@onready var debug_i : debug = get_node("/root/debug_auto")

func load_player():

	if player_ins:
		debug_i.db_print("tried to spawn player when player already exists", "pla_loa")
		return

	#well for now ill just put them on the root and keep a reference to them. then have an unload function
	player_ins = player_ref.instantiate()
	
	get_tree().get_root().add_child(player_ins)
	
func unload_player():
	player_ins.queue_free()
	player_ins = null

