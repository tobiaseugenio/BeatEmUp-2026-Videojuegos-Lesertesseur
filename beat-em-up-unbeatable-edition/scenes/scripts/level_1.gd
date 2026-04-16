extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var beat = GameManager.beatScene.instantiate()
	add_child(beat)
	
	if GameManager.playerCount == 2:
		var quaver = GameManager.quaverScene.instantiate()
		add_child(quaver)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
