extends Area2D

@export_multiline var message: String = "Message"

var player_inside = false
var message_displayed = false

var up_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_inside and Input.is_action_pressed("ui_up") and not message_displayed:
		print(position)
		print(get_parent())
		var panel = get_node("/root/Node2D/CanvasLayer/Control/PanelContainer")
		panel.visible = true
		panel.get_node("Label").set_text(message)
		message_displayed = true
	elif (Input.is_action_pressed("ui_down") or not player_inside) and message_displayed:
		var panel = get_node("/root/Node2D/CanvasLayer/Control/PanelContainer")
		panel.visible = false
		message_displayed = false

func _on_body_entered(body):
	player_inside = true
	$Button.visible = true

func _on_body_exited(body):
	player_inside = false
	$Button.visible = false
