extends Node2D

onready var audio_stream_player = $gameMusic/AudioStreamPlayer


func _ready():
	pass # Replace with function body.

func playBackgroundMusic():
	audio_stream_player.play()
	
