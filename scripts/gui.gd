extends CanvasLayer

@onready var coin_counter: Label = $Control/CoinCounter

func _on_player_coins_changed(coins: int) -> void:
	coin_counter.text = "Coins: " + str(coins)
