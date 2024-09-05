extends Node2D
class_name start_menu


@export var start_link : scene_link
@export var settings_link : scene_link


#region autoloads

@onready var scene_mi : scene_manager = get_node("/root/scene_manager_auto")
@onready var app_mi : app_manager = get_node("/root/app_manager_auto")

#endregion

func _on_start_option_activated():
	scene_mi.load_scene(start_link)

func _on_settings_option_activated():
	scene_mi.load_scene(settings_link)

func _on_quit_option_activated():
	app_mi.quit_game()
