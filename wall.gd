extends RigidBody2D

@export var wallPos = "top"

var spawned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawned == false:
		spawned = true
		match wallPos:
			"bot":
				$mySprite.play("botWall_01")
			"botLeft":
				$mySprite.play("botLeftCorner")
			"left":
				$mySprite.play("leftWall_01")
			"topLeft":
				$mySprite.play("topLeftCorner")
			"top":
				$mySprite.play("topWall_01")
			"topRight":
				$mySprite.play("topRightCorner")
			"right":
				$mySprite.play("rightWall_01")
			"botRight":
				$mySprite.play("botRightCorner")
