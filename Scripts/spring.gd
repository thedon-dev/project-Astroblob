extends Area2D

onready var animated_sprite = $AnimatedSprite
onready var timer = $Timer
export(int) var spring_force #creating export variable for spring force

func _on_spring_body_entered(body):
	if not body is Player : return #if body entered is not player exit function
	animated_sprite.play("Up") #if player, change sprite animation
	body.velocity.y = -spring_force #adding jump force to the player
	timer.start() #starting timer to take the animation sprite back to it's normal animaiton
	

func _on_Timer_timeout():
	animated_sprite.play("Down") #when animation finished, play normal sprite animation
