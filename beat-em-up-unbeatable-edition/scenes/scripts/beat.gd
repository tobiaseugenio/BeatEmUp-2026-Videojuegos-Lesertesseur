extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

var direction = Vector2.ZERO

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

func _physics_process(delta: float) -> void:
	input()
	movement()
	animation()
	flipSprite()
	move_and_slide()

func movement():
	if state == State.COMBAT:
		return
	
	if velocity.length() == 0:
		state = State.IDLE
	else:
		state = State.RUN
		
func input():
	direction.x = Input.get_action_strength("dKey") - Input.get_action_strength("aKey")
	direction.y = Input.get_action_strength("sKey") - Input.get_action_strength("wKey")

	velocity = direction * SPEED
	
	if Input.is_action_just_pressed("spacebar"):
		state = State.COMBAT
		
func animation():
	var animation = stateAnimations.get(state, "idle")
	if $AnimatedSprite2D.animation != animation:
		$AnimatedSprite2D.play(animation)
		var cantSprites = $AnimatedSprite2D.get_sprite_frames()
		print(cantSprites)
		
func flipSprite():
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.flip_h = true
		
#func _on_animated_sprite_2d_animation_finished() -> void:
	#if state == State.COMBAT:
		#state = State.IDLE
		#print("_on_animated_sprite_2d_animation_finished state -> ",  state)
