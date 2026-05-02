extends Node

var playerCount = 1
var beatScene = preload("res://scenes/beat.tscn")
var quaverScene = preload("res://scenes/quaver.tscn")
var remainingHealth = 0
var nextLevel

func start(players):
	playerCount = players
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
