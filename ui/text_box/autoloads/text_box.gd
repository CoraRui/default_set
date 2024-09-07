extends Node2D
class_name text_box

#autoload with functions for displaying text

#TODO: should be ok for now


enum TComm  {OPEN_TEXT_BOX, CLOSE_TEXT_BOX, UPDATE_TEXT, CHANGE_COLOR, WAIT_FOR_ADVANCE,
DELAY_NEXT, PLAY_TRACK}

@export var main_label : Label
#i think for the exact text size/font/everything, its gonna depend on the rest of the project.
#but i really like the tools in font variation. really nice basic set of things. i should be able to tweak it a little bit at 
#the time. anyways.

@export var box_anim : AnimatedSprite2D
#i should make a couple different sprites for this, but in the end ill probably just make one at the time.
#i can store different boxes in different animations, then have some sort of function that'll change the animation for
#a different text box

@export var delay_timer : Timer

var current_set : Array[command_set]
var set_index : int = 0

@export var delta_index : int = 0
@export var delta_char : int	#frame delay between each character
@export var char_sf : sf_link
var text_queue : String = ""

@onready var debug_i : debug = get_node("/root/debug_auto")
@onready var sfx_pi : sfx_player = get_node("/root/sfx_player_auto")
@onready var music_pi : music_player = get_node("/root/music_player_auto")

func _physics_process(_delta):
	next_char()

func _input(event):
	if (event.is_action_pressed("action")):
		advance()

func send_commands( c_set : Array[command_set]) -> void:
	current_set = c_set
	#this function will complete commands until it reaches a stop command.
	set_index = 0
	execute_command(c_set[0])

func next_command() -> void:
	set_index += 1 
	if set_index >= current_set.size():
		debug_i.db_print("ran out of commands, use close_text_box next time", "txt_box")
		return
	execute_command(current_set[set_index])

func execute_command( c_set : command_set) -> void:
	#this is the most important function for these commands it determines which function is called by which string.
	#you'll have to keep track of which functions require which dictionary values.
	match c_set.comm:
		TComm.OPEN_TEXT_BOX:
			open_text_box(c_set.par_dict)
		TComm.CLOSE_TEXT_BOX:
			close_text_box(c_set.par_dict)
		TComm.UPDATE_TEXT:
			update_text(c_set.par_dict)
		TComm.CHANGE_COLOR:
			change_color(c_set.par_dict)
		TComm.PLAY_TRACK:
			play_track(c_set.par_dict)
		TComm.DELAY_NEXT:
			delay_next(c_set.par_dict)
		TComm.WAIT_FOR_ADVANCE:
			#dont do anything, just to avoid the debug message.
			pass
		_:
			debug_i.db_print("txt_box", "command didnt match a command type")
			return
			
	if c_set.comm == TComm.WAIT_FOR_ADVANCE || c_set.comm == TComm.DELAY_NEXT:
		pass #dont do anything yet, just avoids next
	else:
		next_command()
	
func advance() -> void:
	#TODO:just triggers the next command for now, but eventually there might be checks for when the player can advance text.
	#like a time limit between skips,  or a character count minimum or something.
	next_command()
	
func next_char() -> void:
	#this function should check each frame if theres more text to display, and increment the frame count/
	#add the next character if necessary
	
	if text_queue.length() == 0:
		return
	
	delta_index += 1
	if delta_index >= delta_char:
		delta_index = 0
		main_label.text += text_queue[0]
		text_queue = text_queue.erase(0, 1)
		sfx_pi.play_effect(char_sf)
	
#command definitions
func open_text_box(_p : Dictionary) -> void:
	#just toggles visibility for now, not sure what else.
	set_visible(true)
	main_label.text = ""

func close_text_box(_p : Dictionary) -> void:
	#just does visibility and clears text.
	#also clears the text queue. so that sounds dont play/add text after closed.
	set_visible(false)
	main_label.text = ""
	text_queue = ""

func update_text(p : Dictionary) -> void:
	#adds the values to the global variables so the process loop will update the text each frame as needed.
	#parameter keys:
	#clear - clears the text, mostly for clearing before new text.
	#text - text to be displayed
	#delta_char - frames between each character being displayed
	#char_sf - sound effect for each character.
	#you can pretty much leave out any of them and itll still work.
	
	if !p.has("dont_clear"):
		#doesnt clear the text before adding to the queue
		main_label.text = ""
	if p.has("text"):
		text_queue += p["text"]
	if p.has("delta_char"):
		delta_char = p["delta_char"]
	if p.has("char_sf"):
		char_sf = p["char_sf"]
	
func change_color(p : Dictionary) -> void:
	#parameter keys:
	#color - a color to change the text to.
	if p.has("color"):
		main_label.set("theme_override_colors/font_color", p["color"])
	else:
		debug_i.db_print("change_color was called without a color. this is concerning", "txt_box")
	
func play_track(p : Dictionary) -> void:
	#"track" = music_link
	if p.has("track"):
		music_pi.play_track(p["track"])
	else:
		debug_i.db_print("tried to play track without music link. this is concerning", "txt_box")
	
func wait_for_advance(_p : Dictionary) -> void:
	#wait for advance shouldnt need a member function the way it is
	#ill keep this just in case.
	pass
	
func delay_next(p : Dictionary) -> void:
	if p.has("time"):
		delay_timer.wait_time = p["time"]
	else:
		debug_i.db_print("delay_next called without time. this is strange", "txt_box")
	
	delay_timer.start()
	await delay_timer.timeout
	
	next_command()
	
	
	
	
	
	
	
	




