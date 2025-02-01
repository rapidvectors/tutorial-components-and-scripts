extends StateNode

@export var player : Player
@export var animation_tree : AnimationTree

@export_category("Jump Settings")
@export var jump_height : float = 1.5
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.5

@export var velocity_multiplier : float = 2.0
@export var gravity_multiplier : float = 3.5

@onready var jump_velocity : float = (velocity_multiplier * jump_height) / jump_time_to_peak
@onready var jump_gravity : float = (gravity_multiplier * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var fall_gravity : float = (gravity_multiplier * jump_height) / (jump_time_to_descent * jump_time_to_descent)


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(delta : float) -> void:
	if player.is_on_floor():
		print("on floor jump")
		player.velocity.y = jump_velocity
		player.coyote_jump = false
	
	if player.coyote_jump:
		print("coyote jump")
		player.velocity.y = jump_velocity
		player.coyote_jump = false
	
	if !player.is_on_floor():
		player.velocity.y -= get_gravity() * delta
	
	player.move_and_slide()


func _on_unhandled_input(_event: InputEvent) -> void:
	pass


func _on_next_transitions() -> void:
	if !PlayerTransitions.is_falling(player):
		transition.emit("Idle")
	
	if PlayerTransitions.is_walking() and !PlayerTransitions.is_falling(player):
		transition.emit("Walk")
	
	if PlayerTransitions.is_running() and !PlayerTransitions.is_falling(player):
		transition.emit("Run")


func _on_enter() -> void:
	PlayerAnimationTreeTransitions.play_jump_animation(animation_tree)
	player.coyote_jump = true

func _on_exit() -> void:
	player.coyote_jump = false

func get_gravity() -> float:
	if player.velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity
