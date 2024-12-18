extends Control

@onready var player_name_label = $VBoxContainer/NavTop/Panel/PlayerName
@onready var player_class_avatar = $VBoxContainer/NavTop/NinePatchRect/PlayerAvatar
@onready var player_level_label = $VBoxContainer/NavTop/Panel/PlayerLevel
@onready var heart_container = $VBoxContainer/NavTop/Panel/HeartContainer
@onready var grid_overlay = $Modals/GridOverlay

var run_hp: int = 4:
	set(value):
		run_hp = value
		update_hearts()
	get:
		return run_hp

# Dictionary to map avatar images
var class_images = {
	"Fighter": preload("res://assets/avatars/fighteravatar.webp"),
	"Wizard": preload("res://assets/avatars/wizardavatar.webp"),
	"Rogue": preload("res://assets/avatars/rogueavatar.webp"),
	"Druid": preload("res://assets/avatars/druidavatar.webp"),
	"Nigromant": preload("res://assets/avatars/nigromantavatar.webp"),
	"Vampire": preload("res://assets/avatars/vampireavatar.webp")
}

func _ready():
	player_name_label.text = PlayerData.player_name
	player_level_label.text = "Lvl. %d" % [PlayerData.player_level]
	var class_image = class_images.get(PlayerData.player_class, preload("res://assets/avatars/fighteravatar.webp"))
	player_class_avatar.texture = class_image	
	# Initialize HP and hearts
	run_hp = run_hp  # This will trigger the setter and call `update_hearts`
	
	var factory = load("res://scripts/companions.gd").new()
	StartCompanionSpawnLifeCycle(factory)

func StartCompanionSpawnLifeCycle(factory):
	#TODO select random companion from level where companion matches class
	var companionToSpawn = factory.create_companion("Belceduck")
	var gameplay_node = $VBoxContainer/Center/SubViewportContainer/SubViewport
	
	if companionToSpawn:
		companionToSpawn.spawn_companion(gameplay_node)
	else:
		print("Failed to create companion")
 
func lose_hp(hp_lost):
	run_hp -= hp_lost  # Automatically triggers setter

func gain_hp(hp_gained):
	run_hp += hp_gained  # Automatically triggers setter

func update_hearts():
	# Remove all existing children in the heart container
	for child in heart_container.get_children():
		child.queue_free() 

	# Add hearts based on current HP
	for i in run_hp:
		var heart = TextureRect.new()
		heart.texture = preload("res://assets/images/Health/heart_16x16.png")
		heart.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		heart.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		heart.set_custom_minimum_size(Vector2(16, 16))
		heart_container.add_child(heart)
	
	if run_hp <= 0:
		get_tree().change_scene_to_file("res://scenes/MainTitle.tscn")

func _on_return_pressed():
	get_tree().change_scene_to_file("res://scenes/PlayerSelection.tscn")


func _on_close_grid_pressed():
	grid_overlay.visible = false
	GameState.is_grid_open = grid_overlay.visible
