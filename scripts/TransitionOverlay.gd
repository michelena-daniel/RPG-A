extends Control

@onready var anim_player = $AnimationPlayer

func _ready():
	$FadeRect.color.a = 1
	anim_player.play("fade_in")
	anim_player.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_animation_finished(anim_name: String):
	if anim_name == "fade_in":
		hide()
