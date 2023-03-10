extends KinematicBody2D
class_name Player

enum { MOVE, CLIMB }

export (int) var JUMP_FORCE = -130
export (int) var MINIMUM_JUMP = -70
export (int) var MAX_SPEED = 50
export (int) var ACCELERATION = 30
export (int) var FRICTION = 10
export (int) var GRAVITY = 4
export (int) var ADDITIONAL_FALL_GRAVITY = 4
export (int) var MAX_DOULE_JUMP = 1
var velocity = Vector2.ZERO

onready var ladder_check = $LadderCheck
onready var coyoteJumpTimer = $coyoteJumpTimer
onready var remoteTransform = $RemoteTransform2D
var state = MOVE 
var double_jump = 1
var coyote_jump = false

func _ready():
	$AnimatedSprite.frames = load("res://assets/skins/PlayerGreenSkin.tres")
	
func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength('move_right') - Input.get_action_strength('move_left')
	input.y = Input.get_axis('move_up', 'move_down')
	
	match state:
		MOVE: moveState(input, delta)
		CLIMB: climbState(input, delta)
	

func connect_camera(camera):
	var cameraPath = camera.get_path()
	remoteTransform.remote_path = cameraPath

func moveState(input, delta):
	if is_on_ladder() and Input.is_action_pressed('move_up'):
		state = CLIMB
	
	apply_gravity(delta)
	if input.x == 0:
		$AnimatedSprite.animation = "Idle"
		apply_friction(delta)
	else:
		apply_acceleration(input.x, delta)
		$AnimatedSprite.animation = "Run"
		if input.x > 0:
			$AnimatedSprite.flip_h = true
		else: 
			$AnimatedSprite.flip_h = false
		
	if is_on_floor() or coyote_jump:
		double_jump = MAX_DOULE_JUMP #reset double jump
		if Input.is_action_just_pressed('move_up'):
			velocity.y = JUMP_FORCE #jump height
	else: 
		$AnimatedSprite.animation = "Jump"
		if Input.is_action_just_released("move_up") and velocity.y < MINIMUM_JUMP:
			velocity.y = MINIMUM_JUMP #minimum jump height
			
		if Input.is_action_just_pressed('move_up') and double_jump > 0:
			velocity.y = JUMP_FORCE
			double_jump -= 1
			
		if velocity.y > 0:
			velocity.y += ADDITIONAL_FALL_GRAVITY * delta #making the fall speed fast 
			
	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		$AnimatedSprite.animation = "Run"
		$AnimatedSprite.frame = 1
		
	var just_left_ground = not is_on_floor() and was_on_floor
	if just_left_ground and velocity.y >= 0:
		coyote_jump = true
		coyoteJumpTimer.start()

func climbState(input, delta):
	if not is_on_ladder():
		state = MOVE
	
	if input.length() != 0:
		$AnimatedSprite.animation = 'Run'
	else:
		$AnimatedSprite.animation = 'Idle'
	
	velocity = input * 50
	velocity = move_and_slide(velocity, Vector2.UP)

func player_die():
	queue_free()
	Events.emit_signal("player_died")

func is_on_ladder():
	if not ladder_check.is_colliding(): return false
	var collider = ladder_check.get_collider()
	if not collider is Ladder: return false
	return true

func apply_gravity(delta):
	velocity.y += GRAVITY * delta
	velocity.y = min(velocity.y, 300)
	
func apply_friction(delta):
	velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	pass
	
func apply_acceleration(amount, delta):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION * delta)
	pass

func _on_coyoteJumpTimer_timeout():
	coyote_jump = false

