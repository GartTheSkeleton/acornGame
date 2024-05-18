extends CharacterBody2D

class_name Enemy

var enemyBullet = preload("res://enemy_bullet.tscn")

var shootDir = Vector2(0,0)
var shotSpd = 4
var atkCooldown = 12
var cooldownTime = 60

var hp = 3
var value = 2

var time : float

var shootDistance = 450
var shoots = false
var zooms = false

var fixedPos = true
var startPos = Vector2(0,0)

var knockbackTimer = 0
var knockbackVel = Vector2(0,0)

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var level_handler = get_tree().get_first_node_in_group("level_generator")

func _ready():
	startPos = global_position
	
	level_handler.enemyCount += 1

func _process(delta):
	
	if hp <= 0:
		level_handler.enemyCount -= 1
		queue_free()
		player.xp += value
	
	if player.global_position.x < global_position.x:
		if $Sprite2D.flip_h != false:
			$Sprite2D.flip_h = false
	if player.global_position.x > global_position.x:
		if $Sprite2D.flip_h != true:
			$Sprite2D.flip_h = true
	
	time += delta
	$Sprite2D.scale = Vector2(get_sine()+1,get_sine()+1)

func _physics_process(delta):
	move_and_slide()
	
func knockback(attackPosition):
	print("KNOCKBACK")
	knockbackVel = (global_position - attackPosition) * 64
	knockbackTimer = 18

func shoot(angle):
	print("BLAM")
	var spell = enemyBullet.instantiate()
	#shootDir = player.global_position - global_position
	spell.myDir = angle.normalized()
	spell.mySpd = shotSpd
	spell.position = global_position
	get_parent().add_child(spell)
	atkCooldown = cooldownTime
	
func hurt():
	print("OUCH! HP = " + str(hp))
	
func get_sine():
	return sin(time * 2) * .05
