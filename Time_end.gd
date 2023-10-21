extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(Ingame.time_str)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
