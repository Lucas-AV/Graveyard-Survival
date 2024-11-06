extends Node

signal player_damaged
signal meta_currency_upgrade_collected

func emit_player_damaged():
	player_damaged.emit()

func emit_meta_currency_upgrade_collected():
	meta_currency_upgrade_collected.emit()
