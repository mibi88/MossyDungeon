extends CharacterBody2D

var speed = 600
var gravity = 600

var dir = -1

var org_y

var max = 300

var wait = true

# Called when the node enters the scene tree for the first time.
func _ready():
	wait = true
	await get_tree().create_timer(randf_range(0, 5)).timeout
	wait = false
	
	velocity.y = -speed
	org_y = position.y
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not wait:
		velocity.y += gravity*delta
		move_and_slide()
		if $RayCast2D.is_colliding():
			dir = -dir
			scale.x = -scale.x
			print("switch")
		if position.y >= org_y:
			position.y = org_y
			wait = true
			await get_tree().create_timer(randf_range(0, 5)).timeout
			wait = false
			velocity.y = -speed

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.die()
	else:
		print(body.name)
