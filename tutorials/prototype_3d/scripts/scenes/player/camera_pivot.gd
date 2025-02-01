extends Node3D

@export var player :  Player
@export var camera_spring_arm : SpringArm3D
@export var camera : Camera3D

@export_category("Camera Field Of View")
@export var enable_fov_on_run : bool
@export var normal_fov : float = 70.0
@export var run_fov : float = 85.0

@export_category("Camera Settings")
@export var camera_blend : float = 0.05
@export_range(-45, 0, 1, "degrees") var min_rotation_x : float = rad_to_deg(-PI/4)
@export_range(0, 45, 1, "degrees") var max_rotation_x :  float = rad_to_deg(PI/10)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("capture_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event.is_action_pressed("release_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.005)
		camera_spring_arm.rotate_x(-event.relative.y * 0.005)
		camera_spring_arm.rotation.x = clamp(camera_spring_arm.rotation.x, deg_to_rad(min_rotation_x), deg_to_rad(max_rotation_x))

func _physics_process(_delta: float) -> void:
	if enable_fov_on_run:
		#if player.is_on_floor():
			if GameInputEvents.run_input():
				camera.fov = lerp(camera.fov, run_fov, camera_blend)
			else:
				camera.fov  = lerp(camera.fov, normal_fov, camera_blend)
		#else:
		#	camera.fov = lerp(camera.fov, normal_fov, camera_blend)
		
