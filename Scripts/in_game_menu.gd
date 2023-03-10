extends CanvasLayer

#assigning sctivities to various buttons

func _on_Play_pressed():
	get_tree().paused = false
	get_parent().get_node("in_game_menu").hide()


func _on_Menu_pressed():
	Transition.play_exit_transition()
	get_tree().paused = true
	yield(Transition, "Transition_completed")
	Transition.play_enter_transition()
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Menu.tscn")


func _on_Exit_pressed():
	get_tree().quit()
