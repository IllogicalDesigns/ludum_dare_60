extends Node3D

@export var main_menu: Control
@export var settings: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu.open_settings.connect(main_menu_open_settings)
	settings.on_back.connect(settings_on_back)

func main_menu_open_settings() -> void:
	main_menu.hide()
	settings.show()

func settings_on_back() -> void:
	main_menu.show()
	settings.hide()
