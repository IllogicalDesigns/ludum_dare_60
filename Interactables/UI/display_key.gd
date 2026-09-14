extends Node

@export var interactable_ui: Label3D
const INTERACT_ACTION: StringName = &"interact"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable_ui.interactable.interaction_hovered.connect(update_interact_prompt)
	

func update_interact_prompt() -> void:
	var key_text := get_action_key_text(INTERACT_ACTION)

	if key_text.is_empty():
		interactable_ui.text = "Interact"
	else:
		interactable_ui.text = key_text
	

func get_action_key_text(action: StringName) -> String:
	if not InputMap.has_action(action):
		return ""

	for input_event: InputEvent in InputMap.action_get_events(action):
		if input_event is InputEventKey:
			var key_event := input_event as InputEventKey

			# Use the type configured in the Input Map.
			if key_event.key_label != KEY_NONE:
				return key_event.as_text_key_label()

			if key_event.physical_keycode != KEY_NONE:
				return key_event.as_text_physical_keycode()

			if key_event.keycode != KEY_NONE:
				return key_event.as_text_keycode()

	return ""
