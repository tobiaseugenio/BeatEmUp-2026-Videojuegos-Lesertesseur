extends CharacterBody2D

@export var HEALTH = 100
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal died
var jugador
enum State {COMBAT, DAMAGE, IDLE, RUN}
var state = State.IDLE
var loopAnimations = [State.IDLE, State.RUN]

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
	chase()


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func chase():
	var direction = (jugador.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
	print("chase()")

func takeDamage(damage):
	print($".", "takeDamage BEFORE -> ", HEALTH)
	HEALTH -= damage 
	$AnimatedSprite2D.play("damage")
	print("takeDamage AFTER -> ", HEALTH)
	if HEALTH <= 0:			
		died.emit()
		queue_free()
