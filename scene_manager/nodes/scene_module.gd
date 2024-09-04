extends Node2D
class_name scene_module

#in scene trigger for basic level loading using scene manager autoload. mostly for signal connection


@export var link : scene_link

@onready var scene_mi : scene_manager = get_node("/root/scene_manager_auto")

func load_scene():
	scene_mi.load_scene(link)
