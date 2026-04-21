extends Node2D

var jugador

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var beat = GameManager.beatScene.instantiate()
	jugador = get_tree().get_first_node_in_group("jugadorBeat")
	add_child(beat)
	
	if GameManager.playerCount == 2:
		var quaver = GameManager.quaverScene.instantiate()
		add_child(quaver)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
