@icon("res://icons/Spring.svg")
extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var reset_timer: Timer = $ResetTimer

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().velocity.y = -500
		sprite.play("up")
		reset_timer.start()


func _on_reset_timer_timeout() -> void:
	sprite.play("down")
