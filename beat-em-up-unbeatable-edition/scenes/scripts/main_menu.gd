extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	$click.play()
	get_tree().quit() 


func _on_player_pressed() -> void:
	$click.play()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_2player_pressed() -> void:
	$click.play()
	get_tree().change_scene_to_file("res://scenes/2p_level_1.tscn")


func _on_player_mouse_entered() -> void:
	$hover.play()


func _on_2player_mouse_entered() -> void:
	$hover.play()


func _on_quit_mouse_entered() -> void:
	$hover.play()
