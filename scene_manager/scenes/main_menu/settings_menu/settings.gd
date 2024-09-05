extends Node2D
class_name settings


@export var start_link : scene_link

#region autoloads

@onready var scene_mi : scene_manager = get_node("/root/scene_manager_auto")

#endregion

func _ready():
	pass




func _on_back_activated():
	scene_mi.load_scene(start_link)
