extends Node2D

@export var objective = 2
@export var zones: Array[int] = [578, 1024, 1900, 2300]

var copsKilled = 0
var currentZone = 0
var transition = false
var cameraLocked = false

var camera : Camera2D

var beat
var quaver
var jugador
@onready var spawner = $CopSpawner
@onready var spawner2 = $CopSpawner2
@onready var spawner3 = $CopSpawner3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	GameManager.currentLevel = "res://scenes/level_1.tscn"
	beat = GameManager.beatScene.instantiate()
	add_child(beat)
	
	camera = beat.get_node("Camera2D")
	
	spawner.copDied.connect(copKilled)
	spawner2.copDied.connect(copKilled)
	spawner3.copDied.connect(copKilled)
	
	if GameManager.playerCount == 2:
		quaver = GameManager.quaverScene.instantiate()
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

func spawnZoneOneEnemies():
	spawner.global_position = Vector2($StaticBody2D/rightBorder.global_position.x - 20, spawner.global_position.y)

func spawnZoneTwoEnemies():
	spawner.global_position = Vector2($StaticBody2D/rightBorder.global_position.x - 40, spawner.global_position.y + 70)
	spawner2.global_position = Vector2($StaticBody2D/rightBorder.global_position.x - 30, spawner2.global_position.y + 50)
	
	spawner2.activate()
	objective = 3

func spawnZoneThreeEnemies():
	spawner.global_position = Vector2($StaticBody2D/rightBorder.global_position.x - 20, spawner.global_position.y + 70)
	spawner2.global_position = Vector2($StaticBody2D/rightBorder.global_position.x - 20, spawner2.global_position.y - 90)
	spawner3.global_position = Vector2($StaticBody2D/rightBorder.global_position.x - 20, spawner2.global_position.y - 50)
	
	objective = 4
	spawner3.activate()
	

func changeZone(zonesIndex):
	currentZone = zonesIndex
	if zonesIndex == 0:
		spawnZoneOneEnemies()
		print("changeZone(zonesIndex) -> spawnZoneOneEnemies()")
	elif zonesIndex == 1:
		spawnZoneTwoEnemies()
		print("changeZone(zonesIndex) -> spawnZoneTwoEnemies()")
	elif zonesIndex == 2:
		spawnZoneThreeEnemies()
		print("changeZone(zonesIndex) -> spawnZoneThreeEnemies()")
	elif zonesIndex == 3:
		spawnZoneThreeEnemies()
		print("changeZone(zonesIndex) -> spawnZoneThreeEnemies()")

func zoneCompleted():
	if transition:
		return
	transition = true

	var nextZone = currentZone + 1
	if nextZone >= zones.size():
		print("nivel completado")
		GameManager.remainingHealth = beat.HEALTH
		GameManager.nextLevel = "res://scenes/level_2.tscn"
		get_tree().change_scene_to_file("res://scenes/finish_level.tscn")
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
	if GameManager.playerCount == 2:
		quaver.global_position = Vector2($StaticBody2D/leftBorder.global_position.x + 20, quaver.global_position.y)
	changeZone(currentZone)
	
func liberarCamara():
	cameraLocked = false
	camera.limit_left  = -10000000
	camera.limit_right =  10000000
