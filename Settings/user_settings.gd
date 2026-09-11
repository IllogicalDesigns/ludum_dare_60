class_name Settings
extends Node

signal setting_changed(setting: Setting, value: Variant)

enum Setting {
	# Audio
	MASTER_VOLUME,
	MUSIC_VOLUME,
	SFX_VOLUME,

	# Video / graphics
	RESOLUTION,
	WINDOW_MODE,
	VSYNC,
	VOLUMETRIC_FOG,

	# Input
	MOUSE_SENSITIVITY,
	INVERT_Y,
	KEYMAP,

	# Gameplay
	FOV,
}

const _MAP: Dictionary = {
	Setting.MASTER_VOLUME: ["audio", "master"],
	Setting.MUSIC_VOLUME: ["audio", "music"],
	Setting.SFX_VOLUME: ["audio", "sfx"],

	Setting.RESOLUTION: ["video", "resolution"],
	Setting.WINDOW_MODE: ["video", "window_mode"],
	Setting.VSYNC: ["video", "vsync"],
	Setting.VOLUMETRIC_FOG: ["video", "volumetric_fog"],

	Setting.MOUSE_SENSITIVITY: ["input", "mouse_sensitivity"],
	Setting.INVERT_Y: ["input", "invert_y"],
	Setting.KEYMAP: ["input", "keymap"],

	Setting.FOV: ["gameplay", "fov"],
}

const SAVE_PATH: String = "user://settings.cfg"

var _config: ConfigFile
var _is_loaded: bool = false


func _ready() -> void:
	ensure_config()


func ensure_config() -> void:
	# Avoid reloading the file every time a setting is read or written.
	if _is_loaded:
		return

	_config = ConfigFile.new()

	var error: Error = _config.load(SAVE_PATH)

	match error:
		OK:
			print("Found settings config.")

		ERR_FILE_NOT_FOUND:
			print("No settings config found. Creating a new one.")

		_:
			push_warning(
				"Could not load settings config. Error code: %s"
				% error
			)

	_is_loaded = true


func set_value(setting: Setting, value: Variant) -> void:
	ensure_config()

	if not _MAP.has(setting):
		push_error("Unknown setting: %s" % setting)
		return

	var data: Array = _MAP[setting]
	var section: String = data[0]
	var key: String = data[1]

	_config.set_value(section, key, value)

	var error: Error = _config.save(SAVE_PATH)

	if error != OK:
		push_error("Could not save settings config. Error code: %s" % error)
		return

	setting_changed.emit(setting, value)


func get_value(setting: Setting, default: Variant = null) -> Variant:
	ensure_config()

	if not _MAP.has(setting):
		push_error("Unknown setting: %s" % setting)
		return default

	var data: Array = _MAP[setting]
	var section: String = data[0]
	var key: String = data[1]

	return _config.get_value(section, key, default)
