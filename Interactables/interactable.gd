extends StaticBody3D
class_name Interactable

signal interacted_with
signal interaction_hovered
signal interaction_unhovered

var can_be_interacted_with := true
@export var associated_hint := "empty hint"

func interact_with() -> void:
	if !can_be_interacted_with: return
	interacted_with.emit()

# Instead of "ui_show", we signal that a hover has occurred
func on_hover_enter() -> void:
	if !can_be_interacted_with: return
	interaction_hovered.emit()

# Instead of "ui_hide", we signal that the hover has ended
func on_hover_exit() -> void:
	interaction_unhovered.emit()
