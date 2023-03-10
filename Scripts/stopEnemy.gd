extends Node2D

enum {HOVER, FALL, LAND, RISE}

var state = HOVER
onready var timer: = $Timer
onready var start_position = global_position
onready var raycast = $RayCast2D
onready var animatedsprite = $AnimatedSprite
onready var particle = $Particles2D

func _physics_process(delta):
	match state:
		HOVER: hover_state()
		RISE: rise_state(delta)
		FALL: fall_state(delta)
		LAND: land_state()
		
func hover_state():
	state = FALL
	
func fall_state(delta):
	animatedsprite.play("falling")
	position.y += 100 * delta
	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		position.y = collision_point.y
		state = LAND
		timer.start(1.0)
		particle.emitting = true


func land_state():
	if timer.time_left == 0:
		state = RISE
	
func rise_state(delta):
	particle.emitting = false
	animatedsprite.play("rising")
	position.y = move_toward(position.y, start_position.y, 25*delta)
	if position.y == start_position.y:
		state = FALL
