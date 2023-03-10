extends Area2D

onready var animatedSprite: = $AnimatedSprite

var active = true


func _on_checkPoint_body_entered(body):
	if not body is Player: return #if body entered isn't player leave function
	if not active: return #if checkpoint is not active leave function
	animatedSprite.play("checked") #switch animation 
	active = false 
	Events.emit_signal("hit_checkpoint", position) #tell the game that the player has entered a checkpoint
