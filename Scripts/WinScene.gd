extends Control

#making the menu button take you back to menu

func _on_menu_pressed():
	Transition.play_exit_transition()
	get_tree().paused = true
	yield(Transition, "Transition_completed")
	Transition.play_enter_transition()
	get_tree().paused = false
	get_tree().change_scene("res://scenes/menu.tscn")
