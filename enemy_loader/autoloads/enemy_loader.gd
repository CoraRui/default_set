extends Node2D
class_name enemy_loader


#TODO: add some functionality for looping enemy patterns

#this autoload holds a bunch of references to enemies.
#you know, im getting a lot of these like "assigns a bunch of nodes to a string then instantiates them"
#kinds of things. i mean, they're all marginally different, but im sure theres some kind of inheritance i could
#do to make things more efficient.
#whatever. i feel like they're all marginally different so itd be a pain to combine them for now.
#anyways, i dont know if i have time to completely reconstruct the way im doing this stuff before the jam...
#so whatever! ill just do things the way i know.

#gonna be an array of PackedScenes holding references to enemy nodes.
#i want something similar to the text_queue where i can just pass in a string and a dictionary for each "command"
#maybe cause i want to have different kinds of commands baked into there, right?

#the goal of this is to have an enemy spawner. just an array holding commands for spawning enemies mainly.
#but there are other commands relevant to enemy spawning that i want to be able to have, so if i wanted to be able
#to write a queue of enemies just in like data, id have to have that data stored somewhere.
#in a locationbased platformer, you could do it in the window, cause you could just be like "this enemy is here, and 
#that enemy is there." but when you have something on a timer, and the level is less about location and more about 
#timing, i think an array makes sense. again, things like pauses, waiting for a specific event to trigger the 
#next event, those are commands that id want to be a part of the array.
#so i think the string dict thing is pretty elegant.

enum EComm { SPAWN_ENEMY, DELAY_QUEUE_TIME, }

@export var enemy_arr : Array[enemy_reference]				#list of enemy types
@export var fail_ref : enemy_reference

@export var enemy_queue : Array[enemy_command]			#list of commands for enemies
var queue_index : int = 0

@export var enemy_ia : Array[Node2D]					#array of references to enemies

@export var delay_timer : Timer

#enemy spawning commands!

@onready var debug_i : debug = get_node("/root/debug_auto")

func execute_command():
	#this function should check for all possible commands
	print("queue index: ", queue_index)
	if queue_index >= enemy_queue.size():
		debug_i.db_print("enemy queue finished", "emy_loa")
		return
	
	var comm : enemy_command = enemy_queue[queue_index]
	
	match comm.comm:
		EComm.SPAWN_ENEMY:
			spawn_enemy(comm.par)
		EComm.DELAY_QUEUE_TIME:
			delay_queue_time(comm.par)
		_:
			debug_i.db_print("enemy loader didn't recognize command", "emy_loa")
	
	if ( comm.comm != EComm.DELAY_QUEUE_TIME ):
		queue_index += 1
		execute_command()
	
func spawn_enemy(p : Dictionary) -> void:
	#should have tags:
	#enemy - contains enemy_link. to find which enemy to spawn
	#position - contains vector2i. where to spawn the enemy relative to the global position
	#further than just global position, ill have to design specific functions to connect to other autoloads/
	#frames of code
	
	var new_enemy : Node2D
	print("enemy spawn ran")
	
	if p.has("enemy"):
		new_enemy = find_enemy(p["enemy"]).enemy_ref.instantiate()
		get_tree().get_root().add_child.call_deferred(new_enemy)
		enemy_ia.insert(0, new_enemy)
		
	if p.has("position") && new_enemy:
		new_enemy.global_position = p["position"]
	
func delay_queue_time(p : Dictionary) -> void:
	#dont do the next command immediately, trigger a timer whose signal will trigger the next command.
	#time - float, seconds to wait until next command
	if p.has("time"):
		delay_timer.wait_time = p["time"]
		delay_timer.start()
		await delay_timer.timeout
		queue_index += 1
		execute_command()
	
func find_enemy(el : enemy_link) -> enemy_reference:
	
	for e in enemy_arr:
		if e.enemy_name == el.enemy_name:
			return e
	
	return fail_ref

func send_pattern(ea : Array[enemy_command]) -> void:
	#receives an enemy pattern and starts it
	enemy_queue = ea
	execute_command()
