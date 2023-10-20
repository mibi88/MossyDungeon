extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = speed
	velocity.y = 0

var speed = 9375
var gravity = 4800

var dir = 1

var done = false

func _physics_process(delta):
	move_and_slide()
	if ($RayCast2D2.is_colliding() or not $RayCast2D.is_colliding()) and not done:
		dir = -dir
		velocity.x = dir*(speed*delta)
		scale.x = -scale.x
		done = true
	else:
		done = false
	
	if not is_on_floor():
		velocity.y += gravity*delta
	else:
		velocity.y = 0

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
