extends CanvasLayer
@onready var progressBar = $CanvasLayer/ProgressBar
@onready var player = $".."
@onready var playerHealth = player.HEALTH


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progressBar.value = playerHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
