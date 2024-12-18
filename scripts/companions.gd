const Companion = preload("res://scripts/companion.gd")

var companions = {
	"Cabanoir": {
		"Level": 1,
		"Type": "Magical",
		"Strength": 3,
		"Dexterity": 5,
		"Magic": 8,
		"Defense": 4,
		"AvatarPath": "res://assets/pets/Cabanoir/CabanoirAvatar.png",
		"SpritePath": "res://assets/pets/Cabanoir/CabanoirSprite128.png"
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
