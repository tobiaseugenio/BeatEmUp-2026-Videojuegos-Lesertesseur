extends Control

@onready var labelRemainingHealth = $CanvasLayer/remainingHealthValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	labelRemainingHealth.text = str(GameManager.remainingHealth) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	#$click.play()
	get_tree().quit() 
