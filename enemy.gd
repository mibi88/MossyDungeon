extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = speed

var speed = 150

var dir = 1

var done = false

func _physics_process(delta):
	if (move_and_slide() or not $RayCast2D.is_colliding()) and not done:
		dir = -dir
		velocity.x = dir*speed
		scale.x = -scale.x
		done = true
	else:
		done = false

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
