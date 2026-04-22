extends CharacterBody2D

@export var HEALTH = 30
const SPEED = 200.0
const JUMP_VELOCITY = -400.0

signal died
var jugador
enum State {COMBAT, DAMAGE, IDLE, RUN}
var state = State.IDLE
var loopAnimations = [State.IDLE, State.RUN]
var direction = Vector2.ZERO

const stateAnimations={
	State.IDLE : "idle",
	State.RUN:    "runSide",
	State.COMBAT: "combat",
	State.DAMAGE: "damage",
}

func _ready() -> void:
	call_deferred("find_player")

func find_player():
	jugador = get_tree().get_first_node_in_group("jugadorBeat")

func _physics_process(delta: float) -> void:
	movement()
	chase()
	animation()
	flipSprite()

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func chase():
	if state == State.DAMAGE:
		velocity = Vector2.ZERO
		return
		
	direction = (jugador.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
	#print("chase()")

func takeDamage(damage):
	print("takeDamage COP BEFORE -> ", HEALTH)
	HEALTH -= damage 
	state = State.DAMAGE
	print("takeDamage COP AFTER -> ", HEALTH)
	if HEALTH <= 0:			
		died.emit()
		queue_free()

func movement():
	if state == State.COMBAT:
		return
	if state == State.DAMAGE:
		return
	if velocity.length() == 0:
		state = State.IDLE
	else:
		state = State.RUN
		
func animation():
	var animation = stateAnimations.get(state, "idle")
	if $AnimatedSprite2D.animation != animation:
		$AnimatedSprite2D.play(animation)
		$AnimatedSprite2D.sprite_frames.set_animation_loop(animation, state in loopAnimations)

func _on_animated_sprite_2d_animation_finished() -> void:
	if state == State.COMBAT:
		state = State.IDLE
	if state == State.DAMAGE:
		state = State.IDLE
		
func flipSprite():
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.flip_h = true
