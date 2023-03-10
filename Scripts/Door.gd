extends Area2D

export(String, FILE, "*.tscn") var level_path = "" #creating an export variable to accept files with the .tscn extention
onready var main = get_parent() #getting access to parent node
onready var panel = $Panel #getting acces to a child node

var player = false

func go_to_next_room():
	
	Transition.play_exit_transition() #play exit animattion from transition scene
	get_tree().paused = true #pausing the game 
	yield(Transition, "Transition_completed") #waiting for the exit animation to finish playing
	Transition.play_enter_transition() #after waiting play enter animation
	if Global.openedLevels < 3: #check if levels opened are less than the number of levels in the game
		Global.openedLevels = Global.openedLevels + 1 #if true add 1 to the number of levels
	Global.save_data() #saving the number of levels we have after adding 1
	get_tree().paused = false #releasing the game 
	get_tree().change_scene(level_path) # changing the scene to the scene inserted at the export variable

func _process(delta):
	if not player : return 
	if not player.is_on_floor() : return

func _on_Door_body_entered(body):
	if not body is Player : return #check if the body entered is a player, if it's not a player exit function
	if level_path.empty() : return #if the level variable is empty exit function
	if main.key_collected == false : panel.show() #if player entered and key ins't collected show message
	else : go_to_next_room() #if all these are passed go to the next level

func _on_Door_body_exited(body):
	if not body is Player : return #if not a player that exited the area exit function
	panel.hide() #hide the message when player leaves the area
	player = null
