extends Node

@onready var interactable: Interactable = $"../StaticBody3D"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interacted_with.connect(on_interact)

func on_interact() -> void:
	animation_player.play("play")
