extends Area2D


func _on_key_body_entered(body):
	if not body is Player : return #if body entered isn't player exist function
	Events.emit_signal("key_collected") #tell the game that the key has been collected
	queue_free() #delete the key
