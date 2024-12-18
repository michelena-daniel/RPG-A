extends LineEdit

var is_updating = false

func _ready():
	# Connect the text_changed signal to the handler
	connect("text_changed", Callable(self, "_on_text_changed"))

func _on_text_changed(new_text: String) -> void:
	if is_updating:
		return  # Prevent recursion

	var uppercase_text = new_text.to_upper()
	if uppercase_text != new_text:
		is_updating = true
		text = uppercase_text
		is_updating = false
