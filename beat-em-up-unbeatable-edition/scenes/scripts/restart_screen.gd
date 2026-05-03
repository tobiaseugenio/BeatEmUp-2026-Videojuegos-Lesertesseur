extends Control

@onready var labelRemainingHealth = $CanvasLayer/remainingHealthValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_quit_pressed() -> void:
	$arcadeAccept.play()
	get_tree().quit() 


func _on_quit_mouse_entered() -> void:
	$arcadeNav.play()


func _on_next_level_mouse_entered() -> void:
	$arcadeNav.play()


func _on_next_level_pressed() -> void:
	$arcadeAccept.play()
	get_tree().change_scene_to_file(GameManager.nextLevel)


func _on_restart_level_mouse_entered() -> void:
	$arcadeNav.play()


func _on_restart_level_pressed() -> void:
	$arcadeAccept.play()
	get_tree().change_scene_to_file(GameManager.currentLevel)
