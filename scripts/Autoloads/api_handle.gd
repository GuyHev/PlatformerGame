extends Node
class_name API

var key
var public_key

func _ready() -> void:
	var config = ConfigFile.new()
	var err = config.load("res://config/api_keys.cfg")
	if err == OK:
		key = config.get_value("keys", "key")
		public_key = config.get_value("keys", "public_key")

func upload_score(player_name: String, score: int) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	var url = key + "add/%s/%d" % [player_name, score]
	print("Requesting URL:", url)

	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request: %s" % error)

func get_data() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	
	var url = public_key + "pipe"
	print("Requesting URL:", url)

	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request: %s" % error)

func clear_data() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	var url = key + "clear"
	print("Requesting URL:", url)

	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request: %s" % error)

func _http_request_completed(result, response_code, headers, body):
	print("HTTP Request Completed")
	print("Result:", result)
	print("Response Code:", response_code)
	print("Headers:", headers)
	print("Body:", body.get_string_from_utf8())
