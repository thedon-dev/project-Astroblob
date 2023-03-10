tool
extends Path2D

enum ANIMATION {
	LOOP,
	BOUNCE
}
export(ANIMATION) var animation #creating export variable for cases
export (int) var speed = 1 #creating an export variale fot speed of enemy 
onready var animationPlayer = $AnimationPlayer


func _ready():
	animationPlayer.playback_speed = speed #joining the export speed to the snimation speed
	
	#matching animation with the export variable
	match animation:
		ANIMATION.LOOP: animationPlayer.play("MoveAroundPath")
		ANIMATION.BOUNCE: animationPlayer.play("BounceAroundPath")
