extends CharacterBody2D

class_name Player

const SPEED = 300.0

@onready var mySprite = $Sprite

var moveLeft = 0
var moveRight = 0
var moveUp = 0
var moveDown = 0
var shootUp = 0
var shootDown = 0
var shootLeft = 0
var shootRight = 0

var movex
var movey

var shootx
var shooty 

var atkCooldown = 0
var cooldownTime = 50

var shotSpd = 7

var shotRange = 60

var shootDir

var hp = 3

var xp = 0

var targetXp = 8

var level = 1

var moveSpd = 4

var playerBullet = preload("res://bullet.tscn")

var time : float

var currRoom = 30

func _process(delta):
	
	if Input.is_action_just_pressed("1"):
		level_up()
		
	
	if xp >= targetXp:
		level_up()
	
	if Input.is_action_pressed("A"):
		moveLeft = 1
	else:
		moveLeft = 0
	if Input.is_action_pressed("D"):
		moveRight = 1
	else:
		moveRight = 0
	if Input.is_action_pressed("W"):
		moveUp = 1
	else:
		moveUp = 0
	if Input.is_action_pressed("S"):
		moveDown = 1
	else:
		moveDown = 0
		
	atkCooldown -= 1
	
	shootx = shootRight - shootLeft
	shooty = shootDown - shootUp
	
	shootDir = Vector2(shootx,shooty)
	
	if shootDir != Vector2(0,0):
		if atkCooldown <= 0:
			var spell = playerBullet.instantiate()
			#offset the bullet
			if shootDir.normalized() == Vector2(1,0) or shootDir.normalized() == Vector2(-1,0):
				if moveLeft == 0 and moveRight == 1:
					shootDir += Vector2(.2,0)
				if moveLeft == 1 and moveRight == 0:
					shootDir += Vector2(-.2,0)
				if moveUp == 1 and moveDown == 0:
					shootDir += Vector2(0,-.2)
				if moveUp == 0 and moveDown == 1:
					shootDir += Vector2(0,.2)
			if shootDir.normalized() == Vector2(0,1) or shootDir.normalized() == Vector2(0,-1):
				if moveLeft == 1 and moveRight == 0:
					shootDir += Vector2(-.2,0)
				if moveLeft == 0 and moveRight == 1:
					shootDir += Vector2(.2,0)
			spell.myDir = shootDir.normalized()
			spell.mySpd = shotSpd
			spell.myRange = shotRange
			spell.position = global_position
			get_parent().add_child(spell)
			atkCooldown = cooldownTime

func _physics_process(delta):
	if Input.is_action_pressed("Down"):
		shootDown = 1
	else:
		shootDown = 0
	if Input.is_action_pressed("Up"):
		shootUp = 1
	else:
		shootUp = 0
	if Input.is_action_pressed("Left"):
		shootLeft = 1
	else:
		shootLeft = 0
	if Input.is_action_pressed("Right"):
		shootRight = 1
	else:
		shootRight = 0
	
	movex = moveRight - moveLeft
	movey = moveDown - moveUp
	
	velocity = Vector2(movex, movey) * (moveSpd * 50)
	
	player_animate(delta)
	
	move_and_slide()

func level_up():
	Dialogic.VAR.Level += 1
	
	level += 1
	
	#Dialogic.start("levelUp")
	
	targetXp = targetXp * 2
	
	cooldownTime -= cooldownTime/4
	
	moveSpd += .5
	
	shotSpd += .5
	
	shotRange += 2
	
	print("~!Level Up!~")

func player_animate(delta):
	time += delta
	mySprite.scale = Vector2(get_sine()+1,get_sine()+1)
	if velocity.x > .1:
		if mySprite.flip_h != false:
			mySprite.flip_h = false
	if velocity.x < -.1:
		if mySprite.flip_h != true:
			mySprite.flip_h = true
			
func get_sine():
	return sin(time * 2) * .05
	
func hurt():
	print("OUCH! HP = " + str(hp))
