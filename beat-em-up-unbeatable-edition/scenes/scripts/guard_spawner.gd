extends Node2D

@export var guardScene: PackedScene
@export var active = true
signal guardDied

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if active:
		spawnGuard()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawnGuard():
	if !active or !guardScene:
		return
	var newGuard = guardScene.instantiate()
	newGuard.died.connect(diedSpawner)
	add_child(newGuard)
	#print("copSpawner.gd -> spawnCop()")

func diedSpawner():
	guardDied.emit()	
	spawnGuard()

func activate():
	active = true
	spawnGuard()
	print("cop_spawner.gd -> activate()")
	
func deactivate():
	active = false
	print("cop_spawner.gd -> deactivate()")
