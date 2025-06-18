extends  CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade_in() -> void:
	animation_player.play('fade')
	await $AnimationPlayer.animation_finished
	#get_tree().change_scence(target)
	#$AnimationPlayer.play_backwards('fade')
func fade_out() -> void:
	$AnimationPlayer.play_backwards('fade')
	await $AnimationPlayer.animation_finished
