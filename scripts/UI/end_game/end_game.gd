extends Control


@onready var pine_collect_score: Label = $pine_collect_score
@onready var deaths: Label = $deaths
@onready var no_death_bonus: Label = $no_death_bonus
@onready var score_multi: Label = $score_multi
@onready var total_score: Label = $total_score

func _ready() -> void:
	get_tree().root.get_node("Main_Game/GUI").visible = false
	pine_collect_score.text = "Pineapples collected score : " + str(Global.score)
	deaths.text = "Deaths : " + str(Global.deaths)
	no_death_bonus.text =  "No death bonus : Yes" if Global.deaths == 0 else "No death bonus: No"
	score_multi.text = "Score multiplayer : x" + str(Global.difficulty[Global.difficulty_index].score_modifier)
	total_score.text = "Total score : " + str(Global.get_total())
