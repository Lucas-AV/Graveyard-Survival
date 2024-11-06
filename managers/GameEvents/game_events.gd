extends Node

signal player_damaged
signal meta_currency_upgrade_collected
signal experience_item_collected(value: float)

func emit_player_damaged():
	player_damaged.emit()

func emit_experience_item_collected(value: float): 
	experience_item_collected.emit(value)

func emit_meta_currency_upgrade_collected():
	meta_currency_upgrade_collected.emit()
