extends CharacterBody2D

@export var HEALTH = 30
@export var HIT = 5
const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var jugador
var attackCooldown = false 
@export var timeCooldown = 2 

signal died

enum State {COMBAT, DAMAGE, IDLE, RUN}
var state = State.RUN
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
	combatRange()
	animation()
	flipSprite()

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func chase():
	if state == State.DAMAGE or state == State.COMBAT or ! is_instance_valid(jugador) :
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	direction = (jugador.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()

func combatRange():
	if state == State.DAMAGE or state == State.COMBAT or attackCooldown:
		return	
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("jugadorBeat"):
			state = State.COMBAT
			attackCooldown = true
			return

func attack():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("jugadorBeat"):
			state = State.COMBAT
			#print("cop.gd -> attack()")
			
func takeDamage(damage):
	#print("cop.gd takeDamage() -> ", state)
	HEALTH -= damage 
	if state != State.COMBAT:
		state = State.DAMAGE
	if HEALTH <= 0:
		#print("takeDamage -> HEALTH <= 0")
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
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group("jugadorBeat"):
				body.takeDamage(HIT)
		state = State.RUN
		await get_tree().create_timer(timeCooldown).timeout
		attackCooldown = false
	elif state == State.DAMAGE:
		state = State.RUN
		
func flipSprite():
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.flip_h = true

func _on_died() -> void:
	pass
	#died.emit()
	#print("cop.gd -> _on_died()")
