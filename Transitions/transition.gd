extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal transition_finished

func change_scene_to_file(target: String) -> void:
	get_tree().paused = false
	animation_player.play("fade_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	transition_finished.emit()
	
# change_scene_to_packed is the used one
func change_scene_to_packed(target: PackedScene) -> void:
	get_tree().paused = false
	if target:
		animation_player.play("fade_in")
		await animation_player.animation_finished
		
		get_tree().change_scene_to_packed(target)
		print(target)
		
		animation_player.play_backwards("fade_in")
		await animation_player.animation_finished
		
		transition_finished.emit()
	else:
		print("target was null")

func reload_current_scene() -> void:
	animation_player.play("fade_in")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	transition_finished.emit()
	
func dummy_transition() -> void:
	animation_player.play("fade_in")
	await animation_player.animation_finished
	#get_tree().reload_current_scene()
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	transition_finished.emit()
