extends CharacterBody2D
class_name Companion

var companionName: String
var level: int
var type: String
var strength: int
var dexterity: int
var magic: int
var defense: int
var avatar_path: String
var sprite_path: String

# Movement properties
var movement_speed = 50
var movement_direction = Vector2.ZERO

func _init(companionName, level, type, strength, dexterity, magic, defense, avatar_path, sprite_path):
	self.companionName = companionName
	self.level = level
	self.type = type
	self.strength = strength
	self.dexterity = dexterity
	self.magic = magic
	self.defense = defense
	self.avatar_path = avatar_path
	self.sprite_path = sprite_path

func spawn_companion(scene_parent: Node):
	scene_parent.add_child(self)
	
	position = Vector2(900, 1500)

	var sprite = Sprite2D.new()
	sprite.texture = load(sprite_path)
	add_child(sprite)
	
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = sprite.texture.get_size() / 2
	collision.shape = shape
	add_child(collision)
	
	self.collision_layer = 1
	self.collision_mask = 1

	# Start random movement
	_start_random_movement()

func _start_random_movement():
	_on_timer_timeout()
	var timer = Timer.new()
	timer.wait_time = 1.5
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	movement_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()

func _physics_process(delta):
	velocity = movement_direction * movement_speed
	move_and_slide()
	# Check for the last collision after moving
	var collision_info = get_last_slide_collision()
	if collision_info:
		print("Collision detected with:", collision_info.get_collider())
		# TODO: Handle collision
