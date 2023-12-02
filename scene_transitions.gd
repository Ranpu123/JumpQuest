extends CanvasLayer

var future_scene

func change_scene_to_file(target: String):
	future_scene = target
	$AnimationPlayer.play("swipe")
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "swipe":
		get_tree().change_scene_to_file(future_scene)
		$AnimationPlayer.play("swipe2")
