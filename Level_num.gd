extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text("Level: " + str(Ingame.level+1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
