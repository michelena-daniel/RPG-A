extends Label

func _ready():
	visible = false

func _on_line_edit_text_change_rejected(rejected_substring):
	visible = true
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 1.5
	timer.start()
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _on_timer_timeout():
	visible = false
