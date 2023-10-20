extends CheckBox


# Called when the node enters the scene tree for the first time.
func _ready():
	button_pressed = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	button_pressed = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED



func _on_pressed():
	var vsync = DisplayServer.window_get_vsync_mode()
	if vsync == DisplayServer.VSYNC_DISABLED:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
