extends Node2D
class_name debug

#just has some inputs for debugging various stuff. using the row num keys cause i dont use them for anything else
#also should i put the error message things here? i think so

@export var debug_active : bool = true

@export var tag_dict : Dictionary			#contains string tags and bool keys for enabling error messages.


#region autoloads

@onready var sfx_pi : sfx_player = get_node("/root/sfx_player_auto")
@onready var music_pi : music_player = get_node("/root/music_player_auto")
@onready var save_mi : save_manager = get_node("/root/save_manager_auto")
@onready var scene_mi : scene_manager = get_node("/root/scene_manager_auto")
@onready var player_li : player_loader = get_node("/root/player_loader_auto")

#endregion

func _input(event):
	if event.is_action_pressed("db_one"):
		var sf : sf_link = sf_link.new()
		sf.sf_name = "blip"
		sfx_pi.play_effect(sf)
	if event.is_action_pressed("db_two"):
		var t : music_link = music_link.new()
		t.name = "tension"
		music_pi.play_track(t)
	if event.is_action_pressed("db_three"):
		save_mi.save_game()
	if event.is_action_pressed("db_four"):
		save_mi.load_game()
	if event.is_action_pressed("db_five"):
		save_mi.file_01.print_file()
	if event.is_action_pressed("db_six"):
		save_mi.file_01.health = randi_range(0,20)
	if event.is_action_pressed("db_seven"):
		var test_scene : scene_link = scene_link.new()
		test_scene.scene_name = "test_scene"
		scene_mi.load_scene(test_scene)
	if event.is_action_pressed("db_eight"):
		var test_scene : scene_link = scene_link.new()
		test_scene.scene_name = "test_scene_2"
		scene_mi.load_scene(test_scene)
	if event.is_action_pressed("db_nine"):
		if !player_li.player_ins:
			player_li.load_player()
		else:
			player_li.unload_player()
		
func db_print(m : String, t : String) -> void:
	#prints an error message, but only if the tag is active.
	if !tag_dict[t]:
		return
	
	print(t, ": ", m)
