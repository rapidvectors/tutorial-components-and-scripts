extends StateNode

@export var player : Player
@export var animation_tree : AnimationTree

@export_category("Fall State")
@export var coyote_time : float = 0.1

var gravity : int

func _ready() -> void:
	gravity = ProjectSettings.get("physics/3d/default_gravity")


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(delta : float) -> void:
	if !player.is_on_floor():
		get_coyote_time()
		player.velocity.y -= gravity * delta
	
	player.move_and_slide()


func _on_unhandled_input(_event: InputEvent) -> void:
	pass


func _on_next_transitions() -> void:
	if !PlayerTransitions.is_falling(player):
		transition.emit("Idle")


func _on_enter() -> void:
	PlayerAnimationTreeTransitions.play_fall_animation(animation_tree)
	player.coyote_jump = true


func _on_exit() -> void:
	pass

func get_coyote_time() -> void:
	await get_tree().create_timer(coyote_time).timeout
	player.coyote_jump = false
