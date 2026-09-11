extends Node

@export var bus := "Master"
@export var setting: Settings.Setting
@export var default := 0.8

func _ready() -> void:
	UserSettings.setting_changed.connect(on_settings_changed)
	var current_val = UserSettings.get_value(setting, default)
	_apply_volume(current_val)
	
func on_settings_changed(_setting: Settings.Setting, _value: Variant) -> void:
	if setting == _setting:
		_apply_volume(_value)

func _apply_volume(value: float) -> void:
	var bus_index = AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

	
