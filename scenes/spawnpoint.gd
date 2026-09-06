@icon("res://icons/Spawnpoint.svg")
class_name Spawnpoint
extends Node2D

@onready var preview: Sprite2D = $EditorPreview

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		preview.visible = true
	else:
		preview.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
