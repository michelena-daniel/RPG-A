extends Timer

@export var min_spawn_time: float = 5.0  
@export var max_spawn_time: float = 10.0

func _ready():
	# Connect the timeout signal to the handler
	connect("timeout", Callable(self, "_on_SpawnTimer_timeout"))
	# Schedule the first spawn
	schedule_next_spawn()

func schedule_next_spawn():
	# Generate a random wait time between min and max spawn times
	var wait_time = randf_range(min_spawn_time, max_spawn_time)
	self.wait_time = wait_time
	self.start()

func _on_SpawnTimer_timeout():
	# Call the companion spawn lifecycle
	GameState.StartCompanionSpawnLifeCycle()
	# Schedule the next spawn
	schedule_next_spawn()
