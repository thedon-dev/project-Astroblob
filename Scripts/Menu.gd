extends CanvasLayer

#assigning functions to various buttons

func _on_Play_pressed():
	get_tree().change_scene("res://scenes/LevelSelect.tscn")

func _on_How_To_Play_pressed():
	get_node("Buttons").hide()
	get_node("How-to-play").show()

func _on_Options_pressed():
	get_node("Buttons").hide()
	get_node("Options").show()

func _on_Exit_pressed():
	get_tree().quit()

func _on_Back_button_pressed():
	get_node("Buttons").show()
	get_node("Options").hide()
	get_node("How-to-play").hide()
	get_node("credits").hide()

func _on_credits_pressed():
	get_node("Buttons").hide()
	get_node("credits").show()
