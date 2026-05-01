extends Node2D

@export var copScene: PackedScene
@export var active = true
signal copDied

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if active:
		spawnCop()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawnCop():
	if !active or !copScene:
		return
	var newCop = copScene.instantiate()
	newCop.died.connect(diedSpawner)
	add_child(newCop)
	#print("copSpawner.gd -> spawnCop()")

func diedSpawner():
	copDied.emit()	
	spawnCop()

func activate():
	active = true
	spawnCop()
	print("cop_spawner.gd -> activate()")
	
func deactivate():
	active = false
	print("cop_spawner.gd -> deactivate()")
