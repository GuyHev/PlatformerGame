extends GridContainer

const OFFSET = 2
@export var leaderboard_name: String = "leaderboard"

func _ready() -> void:
	await Talo.leaderboards.get_entries(leaderboard_name)
	set_labels()

func set_labels() -> void:
	var count = 0
	var children = get_children()
	var entries = Talo.leaderboards.get_cached_entries(leaderboard_name)

	for i in range(min(entries.size(), (children.size() - OFFSET) / 2)):
		if count == 20:
			return
		var entry = entries[i]
		var name_label = children[OFFSET + (i * 2)]
		var score_label = children[OFFSET + (i * 2 + 1)]

		if name_label is Label:
			name_label.text = entry.player_alias.identifier

		if score_label is Label:
			score_label.text = str(entry.score)
		count += 1
