extends Node
class_name API

var key
var public_key
signal top_ten_ready(xml_data: PackedByteArray)

func _ready() -> void:
	var config = ConfigFile.new()
	var err = config.load("res://config/api_keys.cfg")
	if err == OK:
		key = config.get_value("keys", "key")
		public_key = config.get_value("keys", "public_key")
		
#func get_top_10() -> PackedByteArray:
	#return xml

func upload_score(player_name: String, score: int) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed.bind(0))

	var url = key + "add/%s/%d" % [player_name, score]
	print("Requesting URL:", url)

	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request: %s" % error)

func fetch_data() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed.bind(0))
	
	var url = public_key + "pipe"
	print("Requesting URL:", url)

	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request: %s" % error)

func clear_data() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed.bind(0))

	var url = key + "clear"
	print("Requesting URL:", url)

	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request: %s" % error)
		
func fetch_top_ten() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed.bind(1))
	var url = public_key + "xml/10"
	print("Requesting URL:", url)

	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request: %s" % error)

func _http_request_completed(result, response_code, headers, body, request_type):
	print("HTTP Request Completed")
	print("Result:", result)
	print("Response Code:", response_code)
	
	if result != OK or response_code != 200:
		print("Request failed.")
		return
		
	print("Headers:", headers)
	print("Body:", body.get_string_from_utf8())
	
	if request_type == 1:
		var xml = body
		emit_signal("top_ten_ready", xml)
