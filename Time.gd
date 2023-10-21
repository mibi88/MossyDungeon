extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Ingame.time = Time.get_ticks_msec() - Ingame.start_time
	
	var ms = Ingame.time%1000
	var sec = Ingame.time/1000
	var min = sec/60
	sec = sec%60
	
	Ingame.time_str = "Time: %d:%02d:%03d" % [min, sec, ms]
	
	set_text(Ingame.time_str)
