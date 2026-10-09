extends Node

@onready var quit_button: Button = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quit_button.pressed.connect(on_pressed)

func on_pressed() -> void:
	get_tree().quit()
