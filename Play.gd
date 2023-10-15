extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Ingame.checkpoint_pos = Vector2(320, 240)
	Ingame.checkpoints.clear()
	
	Ingame.level = 0
	
	Ingame.deaths = 0
	
	get_tree().change_scene_to_file("res://main.tscn")
