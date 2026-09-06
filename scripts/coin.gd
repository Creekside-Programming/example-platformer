@icon("res://icons/Coin.svg")
class_name Coin
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		var player: Player = area.get_parent()
		
		player.coins = player.coins + 1
		
		queue_free()
