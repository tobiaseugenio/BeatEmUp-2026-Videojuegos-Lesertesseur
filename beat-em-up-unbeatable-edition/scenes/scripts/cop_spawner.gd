extends Node2D

@export var copScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnCop()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawnCop():
	if copScene:
		#global_position = Vector2(200, 200)
		var newCop = copScene.instantiate()
		newCop.died.connect(diedSpawner)
		add_child(newCop)
		newCop.global_position = global_position

func diedSpawner():
	spawnCop()
	print(" cop_spawner.gd -> diedSpawner()")
