class_name PlayerTransitions

static func is_idle() -> bool:
	if !GameInputEvents.is_movement_input():
		return true
	else:
		return false

static func is_walking() -> bool:
	if !GameInputEvents.run_input() and GameInputEvents.is_movement_input():
		return true
	else:
		return false

static func is_running() -> bool:
	if GameInputEvents.run_input() and GameInputEvents.is_movement_input():
		return true
	else:
		return false

static func is_falling(character : CharacterBody3D) -> bool:
	if !character.is_on_floor():
		return true
	else:
		return false

static func is_jumping() -> bool:
	if GameInputEvents.jump_input():
		return true
	else:
		return false
