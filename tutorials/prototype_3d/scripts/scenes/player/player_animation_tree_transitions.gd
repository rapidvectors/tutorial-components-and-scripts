class_name PlayerAnimationTreeTransitions


static func play_idle_animation(animation_tree : AnimationTree) -> void:
	animation_tree["parameters/player_transition_states/transition_request"] = "state_idle"

static func play_walk_animation(animation_tree : AnimationTree) -> void:
	animation_tree["parameters/player_transition_states/transition_request"] = "state_walk"

static func play_run_animation(animation_tree : AnimationTree) -> void:
	animation_tree["parameters/player_transition_states/transition_request"] = "state_run"

static func play_fall_animation(animation_tree : AnimationTree) -> void:
	animation_tree["parameters/player_transition_states/transition_request"] = "state_fall"

static func play_jump_animation(animation_tree : AnimationTree) -> void:
	animation_tree["parameters/player_transition_states/transition_request"] = "state_jump"
