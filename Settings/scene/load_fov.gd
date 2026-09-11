extends Node

@onready var camera_3d: Camera3D = $".."
@export var default := 85.0

func _ready() -> void:
	UserSettings.setting_changed.connect(on_settings_changed)
	var current_val = UserSettings.get_value(Settings.Setting.FOV, default)
	_apply_fov(current_val)
	
func on_settings_changed(_setting: Settings.Setting, _value: Variant) -> void:
	if Settings.Setting.FOV == _setting:
		_apply_fov(_value)

func _apply_fov(value: float) -> void:
	camera_3d.fov = value
