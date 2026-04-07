extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

var direccion = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var direction_x = Input.get_action_strength("rightArrowKey") - Input.get_action_strength("leftArrowKey")
	velocity.x = direction_x * SPEED
	
	
	if direction_x != 0:
		print(direction_x)
	
	if direction_x:
		$AnimatedSprite2D.play("runSide")
		move_and_slide()
			
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	

	
