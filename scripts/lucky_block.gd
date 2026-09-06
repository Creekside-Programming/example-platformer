class_name LuckyBlock
extends Node2D

enum Contents {
	COIN
}

@export var contents: Contents = Contents.COIN

@onready var unused_sprite: Sprite2D = $Unused
@onready var used_sprite: Sprite2D = $Used
@onready var coin_sprite: AnimatedSprite2D = $CoinSprite # for when contents == Contents.COIN
@onready var anim: AnimationPlayer = $AnimationPlayer

var used = false

func _ready() -> void:
	# make sure these visibilities are correct
	unused_sprite.visible = true
	used_sprite.visible = false

func hit(player: Player) -> void:
	if used:
		return
	
	used = true
	
	unused_sprite.visible = false
	used_sprite.visible = true
	if contents == Contents.COIN:
		coin_sprite.visible = true
		player.coins = player.coins + 1
	anim.play("hit")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		coin_sprite.visible = false
