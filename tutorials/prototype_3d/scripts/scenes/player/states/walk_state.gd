extends StateNode

const ROTATION_LERP_VALUE : float = 0.15

@export var player : Player
@export var player_skeleton : Skeleton3D
@export var animation_tree : AnimationTree
@export var camera_pivot : Node3D
@export var walk_speed : float = 2.0

var gravity : int

func _ready() -> void:
	gravity = ProjectSettings.get("physics/3d/default_gravity")

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(delta : float) -> void:
	var move_direction : Vector3 = GameInputEvents.movement_input(player.transform)
	move_direction = move_direction.rotated(Vector3.UP, camera_pivot.rotation.y)
	
	var horizontal_velocity :Vector3 = move_direction * walk_speed
	player.velocity.x = horizontal_velocity.x
	player.velocity.z = horizontal_velocity.z
	
	player.velocity.y -= gravity * delta
	
	if move_direction.length() > 0:
		player_skeleton.rotation.y = lerp_angle(player_skeleton.rotation.y, atan2(player.velocity.x, player.velocity.z), ROTATION_LERP_VALUE)
	
	player.apply_floor_snap()
	player.move_and_slide()


func _on_unhandled_input(_event: InputEvent) -> void:
	pass


func _on_next_transitions() -> void:
	if PlayerTransitions.is_idle():
		transition.emit("Idle")
	
	if PlayerTransitions.is_falling(player):
		transition.emit("Fall")
	
	if PlayerTransitions.is_running():
		transition.emit("Run")
	
	if PlayerTransitions.is_jumping():
		transition.emit("Jump")


func _on_enter() -> void:
	PlayerAnimationTreeTransitions.play_walk_animation(animation_tree)


func _on_exit() -> void:
	pass
