extends Area2D

var myDir = Vector2(0,0)
var mySpd = 5

@onready var myHitbox = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += myDir * mySpd
	
	if get_overlapping_bodies():
		var overlaps = get_overlapping_bodies()
		for i in overlaps.size():
			if overlaps[i].is_in_group("Player"):
				print("BLAM")
				overlaps[i].hurt()
				queue_free()
