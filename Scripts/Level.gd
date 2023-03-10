extends Node2D #giving the code access to the Node class
class_name Main

const playerScene = preload("res://scenes/Player.tscn") #loading the player scene
const keyScene = preload("res://scenes/key.tscn")

var player_spawn_location = Vector2.ZERO #giving the player location an axis
var key_spawn_location = Vector2.ZERO
var key_collected = false

#getting nodes in the world scene
onready var camera = $Camera2D 
onready var player = $Player  
onready var key = $key 
onready var timer = $Timer	   

func _process(delta):
	if Input.is_action_just_pressed("pause"): #if spacebar is pressed
		get_node("in_game_menu").show() #shwoing the info 
		
		#pausing the game
		var game = get_tree() 
		if game.paused:
			game.paused = false
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state
		visible = pause_state

func _ready(): #function that gets calledd when the scene enters the tree
	VisualServer.set_default_clear_color(Color.lightblue)  #setting the game background to blue
	key_collected = false
	key_spawn_location = key.global_position
	player_spawn_location = player.global_position #setting the spawn location to the player position
	player.connect_camera(camera) #connecting th e player to the camera
	Events.connect("player_died", self, "playerDied")  #connecting an event of when the player dies to the world
	Events.connect("hit_checkpoint", self, "on_hit_checkpoint") #connecting an event to when player enters a checkpoint
	Events.connect("key_collected", self, "on_key_collected")


func on_hit_checkpoint(checkpoint_position): #function when player hit the checkpoint
	player_spawn_location = checkpoint_position #setting the players new location to the location of the checkpoint

func on_key_collected():
	key_collected = true

func playerDied(): #function that get called when player dies
	timer.start(1.0) #creates a timer
	yield(timer, "timeout") #connects the timer to a timerout function
	#function waits 1 second efore moving to the next line 
	var player = playerScene.instance() #creating the player after the wait
	add_child(player)  #adding the player backto the scene
	key_collected = false
	player.global_position = player_spawn_location #setting the new spawn location to the former one
	player.connect_camera(camera) #connecting the camera to the new player created
	var key = keyScene.instance() #creating a new key after player died
	add_child(key)
	key.global_position = key_spawn_location
