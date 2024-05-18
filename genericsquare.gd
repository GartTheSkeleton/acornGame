extends Node2D
var roomType = "room"

# Called when the node enters the scene tree for the first time.
func _ready():
	match roomType:
		"room":
			$Icon.play("default")
		"noise":
			$Icon.play("noise")
		"treasure":
			$Icon.play("treasure")
		"start":
			$Icon.play("start")
		"boss":
			$Icon.play("boss")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
