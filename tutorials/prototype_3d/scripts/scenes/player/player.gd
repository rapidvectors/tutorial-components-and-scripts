class_name Player
extends CharacterBody3D

@export var head_collision_shape : CollisionShape3D

var coyote_jump : bool

func _ready() -> void:
	head_collision_shape.disabled = true
