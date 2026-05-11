extends Node2D
#CORRECCION: Idéntico a cop_spawner, tenés que parametrizar. Mirás todo lo distinto que tienen, lo hacés variable y ya. Lo más gracioso es que no tenés que hacer ningún cambio en estos. Quizá en cop.gd y guard.gd tampoco, sería increíble haber copiado dos scripts que programaste perfectos para parametrizar pero que elegiste no hacerlo.

@export var guardScene: PackedScene
@export var active = false
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

func diedSpawner():
	guardDied.emit()	
	spawnGuard()

func activate():
	active = true
	spawnGuard()
	print("guard_spawner.gd -> activate()")
	
func deactivate():
	active = false
	print("guard_spawner.gd -> deactivate()")
