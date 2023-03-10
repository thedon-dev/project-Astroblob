extends Area2D

export(String) var text_edit #creating an export variable to hold the sign text

func _process(delta):
	get_node("Panel/Label").text = text_edit #joining the export variable with the sign's text

func _on_sign_body_entered(body):
	if not body is Player : return #if body entered is not player exit function
	get_node("Panel").show() #if body is player, show message


func _on_sign_body_exited(body):
	if not body is Player : return #if body exited is not player exit function
	get_node("Panel").hide() #if body is player, hide message
