extends Control

@export var settings: Control
@export var pause_screen: VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused: unpause()
		else: pause()

func pause() -> void:
	ensure_main_pause_screen()
	
	get_tree().paused = true
	show()
	
func unpause() -> void:
	ensure_main_pause_screen()
	
	get_tree().paused = false
	hide()
	
func ensure_main_pause_screen() -> void:
	if settings.visible: 
		settings.hide()
		pause_screen.show()

func _on_resume_button_pressed() -> void:
	unpause()
