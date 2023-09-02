class_name PlaneStats
extends CharacterBody2D

@export var max_health_points = 100.0 : set = _set_state
@export var health_points = 100.0 : set = _set_state
@export var damage = 10.0

signal on_health_points_change(hp: float, max_hp: float)

func _set_state(val: float):
	health_points = val
	emit_signal("on_health_points_change", health_points, max_health_points)
