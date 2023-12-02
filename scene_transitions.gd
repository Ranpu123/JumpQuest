extends CanvasLayer

func change_scene(target: String):
	await $AnimationPlayer.play("swipe")
	get_tree().change_scene(target)
	$AnimationPlayer.play("swipe2")
	
