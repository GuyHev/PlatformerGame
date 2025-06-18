extends BaseState

func enter(_prev_state: BaseState) -> void:
	#player.sprite.play("dead")
	Global.life = 3
	Global.picked_pineapples = 0
	#player.get_tree().reload_current_scene()
	LevelManager.reload_current_level(Global.levels)
	player.current_state = player.normal_state
