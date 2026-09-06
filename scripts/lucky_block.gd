class_name LuckyBlock
extends Node2D

@onready var unused_sprite: Sprite2D = $Unused
@onready var used_sprite: Sprite2D = $Used
@onready var anim: AnimationPlayer = $AnimationPlayer

var used = false

func _ready() -> void:
	# make sure these visibilities are correct
	unused_sprite.visible = true
	used_sprite.visible = false

func hit() -> void:
	if used:
		return
	
	used = true
	
	unused_sprite.visible = false
	used_sprite.visible = true
	anim.play("hit")
