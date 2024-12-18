const Companion = preload("res://scripts/companion.gd")

var companions = {
	"Cabanoir": {
		"Level": 1,
		"Type": "Magical",
		"Strength": 1,
		"Dexterity": 2,
		"Magic": 5,
		"Defense": 3,
		"AvatarPath": "res://assets/pets/Cabanoir/CabanoirAvatar.png",
		"SpritePath": "res://assets/pets/Cabanoir/CabanoirSprite128.png"
	},
	"Belceduck": {
		"Level": 1,
		"Type": "Dexterity",
		"Strength": 2,
		"Dexterity": 5,
		"Magic": 2,
		"Defense": 2,
		"AvatarPath": "res://assets/pets/Belceduck/BelceduckAvatar.png",
		"SpritePath": "res://assets/pets/Belceduck/BelceduckSprite123.png"
	}
}

func create_companion(name: String) -> Companion:
	var def = companions.get(name, null)
	if not def:
		print("Companion not found:", name)
		return null

	var companion = Companion.new(
		name,
		def["Level"],
		def["Type"],
		def["Strength"],
		def["Dexterity"],
		def["Magic"],
		def["Defense"],
		def["AvatarPath"],
		def["SpritePath"]
	)
	return companion
