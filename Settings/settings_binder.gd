class_name SettingsBinder
extends Node

## Drag the UI element (Slider/Button) into this slot in the inspector
@onready var target_node: Control = $".."
@export var setting: Settings.Setting
@export var default_value: Variant

# We define which signal to look for via an Enum
enum Mode { SLIDER, BUTTON, CHECKBOX, LINEEDIT, REMAP }
@export var mode: Mode = Mode.SLIDER

func _ready() -> void:
	if not target_node:
		push_error("SettingsBinder: No target node assigned!")
		return

	# 1. Load and Apply
	var saved_val = UserSettings.get_value(setting, default_value)
	_apply_value(saved_val)

	# 2. Connect Signal
	match mode:
		Mode.SLIDER:
			target_node.value_changed.connect(_on_changed)
		Mode.BUTTON, Mode.CHECKBOX:
			target_node.toggled.connect(_on_changed)
		Mode.LINEEDIT:
			target_node.text_submitted.connect(_on_changed)
		Mode.REMAP:
			target_node.key_remapped.connect(_on_remap_changed)

func _apply_value(val: Variant) -> void:
	#TODO can we apply validation here?
	if target_node is Slider:
		target_node.value = val
	elif target_node is RemapButton:
		target_node.update_key_text()
	elif target_node is CheckButton or target_node is Button:
		target_node.button_pressed = val
	elif target_node is LineEdit:
		target_node.text = str(val)
	

func _on_changed(new_val: Variant) -> void:
	UserSettings.set_value(setting, new_val)

func _on_remap_changed(action: String, event: InputEvent) -> void:
	var keymap = UserSettings.get_value(Settings.Setting.KEYMAP, {})
	keymap[action] = event
	UserSettings.set_value(Settings.Setting.KEYMAP, keymap)
