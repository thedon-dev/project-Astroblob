extends CanvasLayer

onready var path_follow_2d = $Path2D/PathFollow2D
onready var progress_bar = $ProgressBar
onready var timer = $Timer
onready var animated_sprite = $Path2D/PathFollow2D/AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	Audio.playBackgroundMusic() #play background music when scene enters the game


func _on_AnimationPlayer_animation_finished(anim_name):
	animated_sprite.stop() #stopping the player animation when loading animation is done
	timer.start() #starting timer to switch into the game
 
func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Menu.tscn") #after one second switch scene to menu
