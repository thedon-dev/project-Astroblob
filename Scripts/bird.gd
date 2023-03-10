extends KinematicBody2D

var direction
var look_right = Vector2.RIGHT
var look_left = Vector2.LEFT
var velocity = Vector2.ZERO

enum FLY_TO {
	RIGHT,
	LEFT
}

#making an export variable to choose where the bird will fly to 
export(FLY_TO) var fly_towards
export(int) var speed #export variable for speed of the bird

# Called when the node enters the scene tree for the first time.
func _ready():
	#matching the direction with the export variables
	match fly_towards:
		FLY_TO.RIGHT: direction = look_right
		FLY_TO.LEFT: direction = look_left
	
func _physics_process(delta):
	
	velocity = direction * speed
	move_and_slide(velocity, Vector2.UP)
	
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
