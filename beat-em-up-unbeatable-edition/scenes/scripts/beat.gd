extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	direction.x = Input.get_action_strength("dKey") - Input.get_action_strength("aKey")
	direction.y = Input.get_action_strength("sKey") - Input.get_action_strength("wKey")
	velocity = direction * SPEED
		 
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	
	if Input.is_action_just_pressed("spacebar"):
		combat()
	elif direction.length() > 0:
		$AnimatedSprite2D.play("runSide")
		move_and_slide()
	else: 
		$AnimatedSprite2D.play("idle")
		
func combat():
	if Input.is_action_pressed(	"spacebar"):
		$AnimatedSprite2D.play("attack")
		print("barra espaciadora")
