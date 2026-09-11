extends Label

@export var h_slider: HSlider

func _ready() -> void:
	update_text()

func _on_h_slider_value_changed(value: float) -> void:
	update_text()
	
func update_text() -> void:
	text = str(h_slider.value)
