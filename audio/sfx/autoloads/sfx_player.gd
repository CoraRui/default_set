extends Node2D
class_name sfx_player

#im gonna have a limited amount of stream players for sfx, like 16 or something.
#every time a sound is played, the player will update the index. once it makes a full round, 
#it'll overwrite the old sound if its still playing.

#im thinking of doing something similar to the music player in terms of holding all sound effects.


@export var sp_arr : Array[AudioStreamPlayer]

@export var sf_arr : Array[sf_track]		#holds all sound effects

var sp_index : int = 0						#index of the current sound player to be used

@export var fail_sf : sf_track

@onready var debug_i : debug = get_node("/root/debug_auto")

func play_effect(sl : sf_link) -> void:
	var sft : sf_track = find_sf(sl)
	
	if !sft:
		return
	
	sp_arr[sp_index].stream = sft.sf_ref
	sp_arr[sp_index].play()
	sp_index += 1
	if sp_index > sp_arr.size()-1:
		sp_index = 0

func find_sf(sl : sf_link) -> sf_track:
	if !sl:
		debug_i.db_print("tried to play null sf_link", "sfx_pla")
		return
	for sf in sf_arr:
		if sl.sf_name == sf.sf_name:
			return sf
	
	return fail_sf
		
