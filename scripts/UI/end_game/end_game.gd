extends Control


@onready var pine_collect_score: Label = $pine_collect_score
@onready var deaths: Label = $deaths
@onready var no_death_bonus: Label = $no_death_bonus
@onready var score_multi: Label = $score_multi
@onready var total_score: Label = $total_score

func _ready() -> void:
	pine_collect_score.text = str(Global.score)
	score_multi.text = "x"+str(Global.difficulty[Global.difficulty_index].score_modifier)
	total_score.text = str(get_total())

func get_total() -> int:
	var score = Global.score
	var modifier = Global.difficulty[Global.difficulty_index].score_modifier
	return score * modifier
