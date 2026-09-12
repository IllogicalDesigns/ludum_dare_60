extends Node

@onready var player: Player = $".."
@export var default := 0.2

func _ready() -> void:
	UserSettings.setting_changed.connect(on_settings_changed)
	var current_val = UserSettings.get_value(Settings.Setting.MOUSE_SENSITIVITY, default)
	_apply_sens(current_val)
	
func on_settings_changed(_setting: Settings.Setting, _value: Variant) -> void:
	if Settings.Setting.MOUSE_SENSITIVITY == _setting:
		_apply_sens(_value)

func _apply_sens(value: float) -> void:
	player.sensitivity = value
