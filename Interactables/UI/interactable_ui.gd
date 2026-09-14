extends Label3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var hide_on_interact := true
@export var interactable: Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interaction_hovered.connect(on_interaction_ray_enter)
	interactable.interaction_unhovered.connect(on_interaction_ray_exit)
	interactable.interacted_with.connect(on_interact)

func on_interaction_ray_enter() -> void:
	animation_player.play("on_enter")
	
func on_interaction_ray_exit() -> void:
	animation_player.play("on_exit")
	
func on_interact() -> void:
	animation_player.play("on_interact")
	
	if hide_on_interact:
		animation_player.play("on_exit")
