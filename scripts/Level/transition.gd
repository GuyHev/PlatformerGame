extends  CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

func fade_in() -> void:
	color_rect.modulate = Color(1,1,1,1)
	animation_player.play('fade2')
	await $AnimationPlayer.animation_finished
	
func fade_out() -> void:
	$AnimationPlayer.play_backwards('fade2')
	await $AnimationPlayer.animation_finished
