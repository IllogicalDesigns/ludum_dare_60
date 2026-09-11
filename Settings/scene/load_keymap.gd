extends Node

func _ready() -> void:
	UserSettings.setting_changed.connect(on_settings_changed)
	_load_and_apply_keymap()

func on_settings_changed(setting: Settings.Setting, _value: Variant) -> void:
	if setting == Settings.Setting.KEYMAP:
		_load_and_apply_keymap()

func _load_and_apply_keymap() -> void:
	var keymap = UserSettings.get_value(Settings.Setting.KEYMAP, {})
	
	# Optional: Clear current bindings if you want a clean slate
	# However, usually you'd want to keep default bindings for actions not in the dict.
	# For simplicity, we just add/overwrite what's in the dict.
	
	for action in keymap.keys():
		var event = keymap[action]
		if event is InputEvent:
			# Clear existing to prevent stacking
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
