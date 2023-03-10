extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var edge_checkRight = $edge_checkRight
onready var edge_checkLeft = $edge_checkLeft
onready var sprite = $AnimatedSprite

	
func _physics_process(delta):
	var found_wall = is_on_wall()
	var found_edge = not edge_checkRight.is_colliding() or not edge_checkLeft.is_colliding()
	
	if found_wall or found_edge:
		direction *= -1
	
	sprite.flip_h = direction.x > 0
	
	velocity = direction * 25
	move_and_slide(velocity, Vector2.UP)
