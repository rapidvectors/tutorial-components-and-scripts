extends StateNode

@export var player : Player
@export var animation_tree : AnimationTree

var gravity : int

func _ready() -> void:
	gravity = ProjectSettings.get("physics/3d/default_gravity")

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(delta : float) -> void:
	GameInputEvents.movement_input(player.transform)
	
	if !player.is_on_floor():
		player.velocity.y -= gravity * delta
	
	player.move_and_slide()


func _on_unhandled_input(_event: InputEvent) -> void:
	pass


func _on_next_transitions() -> void:
	if PlayerTransitions.is_falling(player):
		transition.emit("Fall")
	
	if PlayerTransitions.is_walking():
		transition.emit("Walk")
	
	if PlayerTransitions.is_running():
		transition.emit("Run")
	
	if PlayerTransitions.is_jumping():
		transition.emit("Jump")


func _on_enter() -> void:
	PlayerAnimationTreeTransitions.play_idle_animation(animation_tree)


func _on_exit() -> void:
	pass
