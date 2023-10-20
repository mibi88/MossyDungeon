class_name Player extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -1200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 4800.0

var tilemap

var tile_times = {}

var killing = [Vector2i(2, 1), Vector2i(0, 3)]
const CHECKPOINT = Vector2i(1, 2)
const CHECKPOINT_USED = Vector2i(2, 2)
const DOOR = Vector2i(1, 1)

var breakable = [Vector2i(0, 1)]

var LEVELS = ["res://level1.tscn", "res://level2.tscn"]

func _ready():
	tilemap = load(LEVELS[Ingame.level]).instantiate()
	$"../Level".add_child(tilemap)
	tile_times.clear()
	position = Ingame.checkpoint_pos
	for checkpoint in Ingame.checkpoints:
		tilemap.set_cell(0, checkpoint, 0, CHECKPOINT_USED)

const BREAKING_SPEED = 0.5
const ANIM_AMOUNT = 4

func die():
	var explosion = load("res://death.tscn").instantiate()
	add_child(explosion)
	$Sprite2D.visible = false
	$PointLight2D.visible = false
	await get_tree().create_timer(1).timeout
	remove_child(explosion)
	Ingame.deaths += 1
	get_tree().change_scene_to_file("res://main.tscn")

func jump():
	velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	var pos = tilemap.local_to_map(global_position)
	var on_player = pos
	pos.y += 1
	
	var tile = tilemap.get_cell_atlas_coords(0, pos)
	var tile_behind = tilemap.get_cell_atlas_coords(0, on_player)
	
	if tile == CHECKPOINT:
		tilemap.set_cell(0, pos, 0, CHECKPOINT_USED)
		Ingame.checkpoint_pos = position
		Ingame.checkpoints.append(pos)
	if tile_behind == CHECKPOINT and not tile in killing:
		tilemap.set_cell(0, on_player, 0, CHECKPOINT_USED)
		Ingame.checkpoint_pos = position
		Ingame.checkpoints.append(on_player)
	if tile in killing or tile_behind in killing:
		die()
	if tile_behind == DOOR:
		Ingame.level += 1
		Ingame.checkpoints.clear()
		if Ingame.level < LEVELS.size():
			Ingame.checkpoint_pos = Vector2(320, 240)
			Ingame.checkpoints.clear()
			
			get_tree().change_scene_to_file("res://main.tscn")
		else:
			get_tree().change_scene_to_file("res://game_end.tscn")
	if tile in breakable and is_on_floor():
		if tile_times.has(pos):
			if tile_times[pos] >= BREAKING_SPEED:
				print("break")
				tilemap.erase_cell(0, pos)
				tilemap.erase_cell(1, pos)
			else:
				tile_times[pos] += delta
				var id = floor(tile_times[pos]/BREAKING_SPEED*(ANIM_AMOUNT+1))
				if id > ANIM_AMOUNT:
					id = ANIM_AMOUNT
				tilemap.set_cell(1, pos, 0, Vector2(id-1, 0))
		elif tilemap.get_cell_source_id(0, pos) != -1:
			tile_times[pos] = 0.0
