extends Node2D
class_name score_manager


#autoload that keeps a score and displays it in the screen. can define whatever behavior of the score id like 
#to adapt to whatever id like

#TODO: pretty simple but pretty decent already. maybe add some sound effects for adding points? nah.
#maybe the +new_points thing under the score bar though, and some kind of scrolling increase as the points go up
#rather than a static points thing. also try to implement some kind of combo system, even if you dont end up using it,
#just to see how you might do it.

@export var score : int = 0					#current score

@export var max_score : int = 999999		#max possible score


@export var score_label : Label				#label containing score

@export var max_digits : int = 10

func _ready():
	#testing the score label
	score = 9999
	update_label()


func update_label() -> void:
	#this function should update the score label with the score value and properly space the zeroes.
	
	score_label.text = ""
	
	var str_score : String = str(score)
	
	var zeroes : int = max_digits - str_score.length()
	
	while (zeroes > 0):
		score_label.text += "0"
		zeroes -= 1
	
	score_label.text += str_score
