extends CanvasLayer
@onready var progressBar = $healthBar
@onready var player = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progressBar.max_value = player.HEALTH
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progressBar.value = player.HEALTH
	
