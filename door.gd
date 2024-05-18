extends Area2D

@export var roomPos = "top"

var wall_object = preload("res://wall.tscn")
@onready var level_handler : Node2D = get_tree().get_first_node_in_group("level_generator")

signal roomTransition
var triggered = false
var state = "open"

var xPos = 0
var yPos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	xPos = level_handler.playerPosX
	yPos = level_handler.playerPosY
	match roomPos:
		"top":
			if level_handler.is_in_levelGrid(xPos,yPos-1) == false:
				state = "wall"
		"bot":
			rotation_degrees = 180
			if level_handler.is_in_levelGrid(xPos,yPos+1) == false:
				state = "wall"
		"left":
			rotation_degrees = -90
			if level_handler.is_in_levelGrid(xPos-1,yPos) == false:
				state = "wall"
		"right":
			rotation_degrees = 90
			if level_handler.is_in_levelGrid(xPos+1,yPos) == false:
				state = "wall"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	level_handler = get_tree().get_first_node_in_group("level_generator")
	
	match state:
		"open":
			if get_overlapping_bodies():
				var overlaps = get_overlapping_bodies()
				for i in overlaps.size():
					if overlaps[i].is_in_group("Player") and triggered == false:
						match roomPos:
							"top":
								level_handler.playerPosY -= 1
							"bot":
								level_handler.playerPosY += 1
							"left":
								level_handler.playerPosX -= 1
							"right":
								level_handler.playerPosX += 1
						var chungus = level_handler.getRoomId()
						level_handler.level_transition(chungus,roomPos)
						print("DOOR COLLISION")
						triggered = true
		"closed":
			pass
		"wall":
			var chungus = wall_object.instantiate()
			chungus.wallPos = roomPos
			chungus.global_position = global_position
			get_parent().add_child(chungus)
			queue_free()
