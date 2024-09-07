extends Node2D
class_name scene_manager

#basic loading in and out of scenes to the root node. or to this node idk.
#can reload duplicates. cause idk why not

#TODO: has been working pretty well, not gonna fuck with it



@export var current_scene : Node2D

@export var scene_arr : Array[scene]

@export var fail_scene : scene

@onready var debug_i : debug = get_node("/root/debug_auto")

func load_scene(sl : scene_link):
	
	var new_scene : scene = find_scene(sl)
	
	if current_scene:
		current_scene.queue_free()
	
	current_scene = new_scene.scene_ref.instantiate()
	
	get_tree().get_root().add_child.call_deferred(current_scene)

func find_scene(sl : scene_link) -> scene:
	for s in scene_arr:
		if s.scene_name == sl.scene_name:
			return s
			
	return fail_scene
	
	

