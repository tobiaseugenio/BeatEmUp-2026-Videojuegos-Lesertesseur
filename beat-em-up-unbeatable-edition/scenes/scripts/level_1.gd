extends Node2D

@export var objective = 2 
@export var zones: Array[int] = [578, 1024, 2048]

var copsKilled = 0
var currentZone = 0
var transition = false
var cameraLocked = false

var camera : Camera2D

var beat
var jugador

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	beat = GameManager.beatScene.instantiate()
	#jugador = get_tree().get_first_node_in_group("jugadorBeat")
	add_child(beat)
	
	camera = beat.get_node("Camera2D")
	
	var spawner = $CopSpawner
	spawner.copDied.connect(copKilled)
	
	if GameManager.playerCount == 2:
		var quaver = GameManager.quaverScene.instantiate()
		add_child(quaver)
	await get_tree().process_frame
	print(beat)
	camera.global_position = beat.global_position
	camera.reset_smoothing()	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !cameraLocked:
		camera.global_position = beat.global_position

func copKilled():
	copsKilled += 1
	print("copsKilled -> ", copsKilled)
	if copsKilled >= objective:
		print("objetivo completado")
		zoneCompleted()

func changeZone(zonesIndex):
	currentZone = zonesIndex
	
func zoneCompleted():
	if transition:
		return
	transition = true

	var nextZone = currentZone + 1
	if nextZone >= zones.size():
		print("nivel completado")
		return
		
	currentZone = nextZone
	copsKilled = 0
	transition = false


func _configurarZona(zoneX: int):
	cameraLocked = true
	var halfScreen = get_viewport().get_visible_rect().size.x / 2.0
	camera.limit_left  = int(zoneX - halfScreen)
	camera.limit_right = int(zoneX + halfScreen)
	$StaticBody2D/leftBorder.global_position.x = zoneX - halfScreen
