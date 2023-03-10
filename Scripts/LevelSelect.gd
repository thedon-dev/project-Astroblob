extends CanvasLayer

onready var control = $Control
onready var padlocks = $padlocks


func _ready():
	for level in control.get_children(): #getting the children of the control node
		if str2var(level.name) in range(Global.openedLevels + 1): #check if name is in opened levels
			level.disabled = false #if it is among the levels opened then make the button active
		else: level.disabled = true #if it's not disable the button
		
	for padlock in padlocks.get_children(): #getting the children of the padlock node
		if str2var(padlock.name) in range(Global.openedLevels + 1): #check if name is in opened levels
			padlock.hide() #if it is among the levels opened then hide sprite
		else: padlock.show()  #if it's not show sprite


#assigning functions to the buttons
func _on_1_pressed():
	Transition.play_exit_transition()
	get_tree().paused = true
	yield(Transition, "Transition_completed")
	Transition.play_enter_transition()
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Level1.tscn")

func _on_2_pressed():
	Transition.play_exit_transition()
	get_tree().paused = true
	yield(Transition, "Transition_completed")
	Transition.play_enter_transition()
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Level2.tscn")

func _on_3_pressed():
	Transition.play_exit_transition()
	get_tree().paused = true
	yield(Transition, "Transition_completed")
	Transition.play_enter_transition()
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Level3.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")
