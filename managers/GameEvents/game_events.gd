extends Node

signal player_damaged
signal on_meta_currency_upgrade_collected

func emit_player_damaged():
	player_damaged.emit()
