extends CanvasLayer

onready var animation_player = $AnimationPlayer

signal Transition_completed #creating a signal for transition animation finished

func play_exit_transition():
	animation_player.play("exit") 
	
func play_enter_transition():
	animation_player.play("enter")


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("Transition_completed") #tell the game that the animtion is done
