extends CharacterBody2D

@export var HEALTH = 100
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal died

enum State {COMBAT, DAMAGE, IDLE, RUN}
var state = State.IDLE
var loopAnimations = [State.IDLE, State.RUN]
const stateAnimations={
	State.IDLE : "idle",
	State.RUN:    "runSide",
	State.COMBAT: "combat",
	State.DAMAGE: "damage",
}

func _physics_process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func takeDamage(damage):
	print($".", "takeDamage BEFORE -> ", HEALTH)
	HEALTH -= damage 
	$AnimatedSprite2D.play("damage")
	print("takeDamage AFTER -> ", HEALTH)
	if HEALTH <= 0:			
		died.emit()
		queue_free()
