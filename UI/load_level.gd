extends Node

@onready var button: Button = $".."
@export var level_to_load: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(load_level)

func load_level() -> void:
	Transition.change_scene_to_file(level_to_load)
