extends BaseState

var gravity = 900.0

func enter(_prev_state: BaseState) -> void:
	player.collision_layer = false
	player.collision_mask = false
	player.sprite.play("dead")
	player.velocity = Vector2(0, -300)
	
	# Timer Section
	var timer := Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	add_child(timer)  # Add it to the current scene or a node like player
	timer.timeout.connect(_on_death_timer_timeout)
	timer.start()
	
func physics_update(delta: float) -> void:
	player.velocity.y += gravity * delta  # apply gravity
	player.move_and_slide()  
	
func _on_death_timer_timeout():
		Global.deaths += 1
		if Global.difficulty[Global.difficulty_index].name == "Nightmare":
			LevelManager.load_end_scene(Global.levels)
			return
		Global.set_life()
		LevelManager.reload_current_level(Global.levels) # This also resets collision_layer and collision_mask back to true
		player.current_state = player.normal_state
