extends Node
class_name music_trigger

#this node starts a music track in the music player autoload.
#so what different ways should music be able to trigger? and should i do all of them in this node?
#im thinking by area, by on ready, by signal, and maybe more. it just seems more convinient to combine them.
#less extra coding/work, not to much redundancy, etc.

#indicates the type of trigger to be used in order to trigger the music.
enum TriggerType { READY, AREA, NONE }
@export var trigger_type : TriggerType = TriggerType.NONE

#music link to be sent on trigger
@export var trig_link : music_link

#region autoloads

@onready var music_pi : music_player = get_node("/root/music_player_auto")

#endregion

func _ready():
	if trigger_type == TriggerType.READY:
		send_track()

func send_track():
	#should call when the music is ready to be played.
	print("sent track")
	music_pi.play_track(trig_link)

func _on_mt_area_area_entered(_area):
	if trigger_type == TriggerType.AREA:
		send_track()

func _on_mt_area_body_entered(_body):
	if trigger_type == TriggerType.AREA:
		send_track()
