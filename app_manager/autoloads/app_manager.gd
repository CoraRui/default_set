extends Node2D
class_name app_manager

#resize window is f4
#scales the window size
#hold esc to quit
#thats it

@export var window_scale : float = 2.0

@onready var double_size : Vector2i = Vector2i(int(get_window().size.x * window_scale), int(get_window().size.y * window_scale))

@export var quit_timer : Timer

@export var quit_label : Label

@export var quitting : bool = false

func _ready():
	get_window().size = double_size

func _physics_process(_delta):
	if quitting :
		quit_label.self_modulate.a8 += 15
		

func _input(event):
	if event.is_action_pressed("app_resize"):
		toggle_fullscreen()
	if event.is_action_pressed("app_quit"):
		quit_timer.start()
		quit_label.set_visible(true)
		quitting = true
	if event.is_action_released("app_quit"):
		quit_timer.stop()
		quit_label.set_visible(false)
		quitting = false
		quit_label.self_modulate = Color(1,1,1,0)

func toggle_fullscreen():
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func quit_game():
	get_tree().quit()

func _on_quit_timer_timeout():
	quit_game()
