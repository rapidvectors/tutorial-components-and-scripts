class_name GameInputEvents
extends Node

static var direction : Vector3


static func movement_input(transform : Transform3D) -> Vector3:
	var move_direction : Vector2 = Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
	direction = (transform.basis * Vector3(move_direction.x, 0, move_direction.y)).normalized() 
	return direction

static func is_movement_input() -> bool:
	if direction == Vector3.ZERO:
		return false
	else:
		return true

static func run_input() -> bool:
	if Input.is_action_pressed("run"):
		return true
	else:
		return false

static func jump_input() -> bool:
	var jump_value : bool = Input.is_action_just_pressed("jump")
	return jump_value
