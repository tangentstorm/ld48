extends Node2D

func _ready():
	$ernie/beam.visible = true
	Input.set_custom_mouse_cursor(preload("res://sprites/cursor-blocked.png"), 0, Vector2(64,64))
