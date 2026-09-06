class_name LuckyBlock
extends Node2D

## All the different types of items that can be inside a lucky block.
enum Contents {
	COIN
}

## The item that is inside this lucky block.
@export var contents: Contents = Contents.COIN

@onready var unused_sprite: Sprite2D = $Unused
@onready var used_sprite: Sprite2D = $Used
@onready var coin_sprite: AnimatedSprite2D = $CoinSprite # for when contents == Contents.COIN
@onready var anim: AnimationPlayer = $AnimationPlayer

## This is true if the lucky block has been hit and its [member contents] have been depleted.
var used = false

func _ready() -> void:
	# make sure these visibilities are correct
	unused_sprite.visible = true
	used_sprite.visible = false

## Runs whenever the lucky block has been hit by a player. Sets [member used] to [code]true[/code] once it runs. If [member used] is already [code]true[/code], then this will not run a second time.
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
