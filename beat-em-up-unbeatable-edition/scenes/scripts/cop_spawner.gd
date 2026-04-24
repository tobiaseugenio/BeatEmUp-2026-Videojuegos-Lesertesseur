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
		var newCop = copScene.instantiate()
		newCop.died.connect(diedSpawner)
		add_child(newCop)
		newCop.global_position = global_position
		print("copSpawner.gd -> spawnCop()")

func diedSpawner():
	print(" cop_spawner.gd -> diedSpawner()")
	spawnCop()
