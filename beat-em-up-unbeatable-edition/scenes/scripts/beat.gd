extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var HEALTH = 100
@export var HIT = 102
@export var direction = Vector2.ZERO

signal died
signal damageEmitted

enum State {COMBAT, DAMAGE, FALL, IDLE, JUMP, RUN, WAKEUP}
var state = State.IDLE
var loopAnimations = [State.IDLE, State.RUN]
const stateAnimations={
	State.IDLE : "idle",
	State.RUN:    "runSide",
	State.COMBAT: "combat",
	State.JUMP:   "jump",
	State.DAMAGE: "damage",
	State.WAKEUP: "wakeup",
}

func _ready():
	global_position = Vector2(100, 200)

func _physics_process(delta: float) -> void:
	input()
	movement()
	animation()
	flipSprite()
	move_and_slide()

func movement():
	if state == State.COMBAT:
		return
	if state == State.DAMAGE:
		return
	if velocity.length() == 0:
		state = State.IDLE
	else:
		state = State.RUN
		
func input():
	direction.x = Input.get_action_strength("dKey") - Input.get_action_strength("aKey")
	direction.y = Input.get_action_strength("sKey") - Input.get_action_strength("wKey")

	velocity = direction * SPEED
	
	if state == State.COMBAT or state == State.DAMAGE:
		velocity=Vector2.ZERO
		return
	
	
	if Input.is_action_just_pressed("spacebar"):
		state = State.COMBAT
		attack()
		
func animation():
	var animation = stateAnimations.get(state, "idle")
	if $AnimatedSprite2D.animation != animation:
		$AnimatedSprite2D.play(animation)
		$AnimatedSprite2D.sprite_frames.set_animation_loop(animation, state in loopAnimations)
				
func flipSprite():
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.flip_h = true
		
func _on_animated_sprite_2d_animation_finished() -> void:
	if state == State.COMBAT:
		state = State.IDLE
	elif state == State.DAMAGE:
		state = State.IDLE
		
func attack():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("enemigo"):
			#print("ENEMIGO attack")
			body.takeDamage(HIT)
		#else:
			#print("ALIDADO attack")
			
func takeDamage(damage):
	$damageSFX.play()
	HEALTH -= damage 
	#print("beat.gd HEALTH ->", HEALTH)
	state = State.DAMAGE
	if HEALTH <= 0:			
		died.emit()
		queue_free()
