extends CharacterBody2D

var org_y

var speed = 1

var mov = 50

var dir = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	org_y = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += dir*speed
	
	if velocity.y > mov or velocity.y < -mov:
		dir = -dir
	
	move_and_slide()
	print(velocity.y)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.die()
	else:
		print(body.name)

func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		body.jump()
		queue_free()
	else:
		print(body.name)
