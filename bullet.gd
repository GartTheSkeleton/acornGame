extends Area2D

var myDir = Vector2(0,0)
var mySpd = 8
var myRange = 20

var rangeTimer = 0

var damage = 1

@onready var myHitbox = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rangeTimer += 1
	
	if rangeTimer > myRange:
		queue_free()
	
	global_position += myDir * mySpd
	
	if get_overlapping_bodies():
		var overlaps = get_overlapping_bodies()
		for i in overlaps.size():
			if overlaps[i].is_in_group("Enemies"):
				print("BLAM")
				overlaps[i].hp -= damage
				overlaps[i].knockback(global_position)
				queue_free()
			if overlaps[i].is_in_group("Wall"):
				queue_free()

