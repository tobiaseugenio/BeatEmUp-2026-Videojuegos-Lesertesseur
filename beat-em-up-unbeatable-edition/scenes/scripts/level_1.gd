extends Node2D

@export var objective = 2 
@export var zones: Array[int] = [578, 1024, 1600]

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
	$StaticBody2D/leftBorder.global_position.x = beat.global_position.x - 20

	liberarCamara()
	configurarZona(zones[currentZone])

func configurarZona(zoneX: int):
	cameraLocked = true
	var halfScreen = get_viewport().get_visible_rect().size.x / 2.0
	camera.limit_left  = zoneX - halfScreen
	camera.limit_right = zoneX + halfScreen
	$StaticBody2D/leftBorder.global_position.x = zoneX - halfScreen
	$StaticBody2D/rightBorder.global_position.x = zoneX + halfScreen
	beat.global_position = Vector2($StaticBody2D/leftBorder.global_position.x + 20, beat.global_position.y)
	
func liberarCamara():
	cameraLocked = false
	camera.limit_left  = -10000000
	camera.limit_right =  10000000
