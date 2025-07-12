extends Node

var difficulty = [
	{"name":"Easy", "life":5, "pineapple_score":100, "score_modifier":1},
	{"name":"Normal", "life":3, "pineapple_score":200, "score_modifier":1.5},
	{"name":"Hard", "life":1, "pineapple_score":300, "score_modifier":2},
	{"name":"Nightmare", "life":1, "pineapple_score":300, "score_modifier":4}
]
var levels: Node = null # Refrence to the level's node in Main_Game scene
var transition : CanvasLayer = null # Refrence to the transition's node in Main_Game scene
var difficulty_index = 0
var life = 3
var position = Vector2.ZERO  # Store player's position data 
var score = 0
var deaths = 0
var pineapples_in_level := {} 
var pineapples_left = 0
var pineapples_collected = 0

func set_levels_reference(node: Node) -> void:
	levels = node

func set_transition_reference(node: CanvasLayer) -> void:
	transition = node
	
# This functions integer as argument (0 - decrement, 1 - increment)
func select_difficulty(number: int)-> void:
	if number == 0 and difficulty_index > 0:
		difficulty_index -= 1;
		
	if number == 1 and difficulty_index < difficulty.size()-1:
		difficulty_index += 1;
		
func set_life() -> void:
	life = difficulty[difficulty_index].life
	
func get_total() -> int:
	var modifier = difficulty[difficulty_index].score_modifier
	var bonus = get_no_death_bonus()
	return score * modifier + bonus
	
func get_no_death_bonus() -> int:
	if deaths != 0:
		return 0
	var modifier = difficulty[difficulty_index].score_modifier
	var pineapple_value = difficulty[difficulty_index].pineapple_score
	return pineapple_value * pineapples_collected * (modifier * 0.5)
