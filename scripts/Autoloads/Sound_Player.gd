extends Node

const POOL_SIZE = 5
var sfx_players = []
var music_player: AudioStreamPlayer  # Dedicated player for background music

func _ready():
	# Create a pool of 5 AudioStreamPlayers
	for i in range(POOL_SIZE):
		var p = AudioStreamPlayer.new()
		p.bus = "insert1"
		add_child(p)
		sfx_players.append(p)
		
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	music_player = AudioStreamPlayer.new()
	music_player.bus = "insert2"
	music_player.volume_db = -10
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(music_player)

func play_sfx(sound: AudioStream):
	for p in sfx_players:
		if not p.playing:
			p.stream = sound
			p.play()
			return
	# Optional: If all are busy, overwrite the first
	sfx_players[0].stream = sound
	sfx_players[0].play()
	
func play_music(music: AudioStream):
	if music_player.stream == music and music_player.playing:
		return  # already playing this music
	music.loop = true  # loops the track
	music_player.stream = music
	music_player.play()
