extends GridContainer

const OFFSET = 2 # Number of children to skip in GridContainer

var names = []
var scores = []

func _ready() -> void:
	api.fetch_top_ten()
	api.top_ten_ready.connect(set_labels)

	
func set_labels(xml_bytes : PackedByteArray) -> void:	
	var children = self.get_children() 
	fill_arrays(xml_bytes)
	for i in range(names.size()):
		var score_label = children[OFFSET + (i * 2 + 1)] # odd index
		var name_label = children[OFFSET + (i * 2)] # even index

		if score_label is Label:
			score_label.text = str(scores[i])
		if name_label is Label:
			name_label.text = names[i]

func fill_arrays(xml_bytes : PackedByteArray) -> void:
	var parser = XMLParser.new()
	var err = parser.open_buffer(xml_bytes)
	if err != OK:
		push_error("Failed to open XML buffer")
		return

	names.clear() 
	scores.clear()
	var inside_entry = false
	var current_tag = ""
	var current_name = ""
	var current_score = 0

	while true:
		var status = parser.read()
		if status == ERR_FILE_EOF:
			break
		elif status != OK:
			push_error("XML parsing error: " + str(parser.get_error_message()))
			return

		match parser.get_node_type():
			XMLParser.NODE_ELEMENT:
				current_tag = parser.get_node_name()
				if current_tag == "entry":
					inside_entry = true
					current_name = ""
					current_score = 0

			XMLParser.NODE_TEXT:
				if inside_entry:
					var text = parser.get_node_data().strip_edges()
					if current_tag == "name":
						current_name = text
					elif current_tag == "score":
						current_score = int(text)

			XMLParser.NODE_ELEMENT_END:
				if parser.get_node_name() == "entry":
					# Finished one entry, add to arrays
					inside_entry = false
					names.append(current_name)
					scores.append(current_score)
