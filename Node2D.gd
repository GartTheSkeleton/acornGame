extends Enemy

#behavior: Idle - Shoots - Runs a bit towards player - Idle

var state = "idle"

var idleCounter = 0
var idleCooldown = 45
var chaseCounter = 0
var chaseCooldown = 80

var shootChase = true

func _ready():
	randomize()
	super()
	
	idleCooldown += randi_range(-4,4)
	idleCounter += randi_range(-6,6)
	chaseCooldown += randi_range(-4,4)
	chaseCounter += randi_range(-6,6)
	
	shoots = true
	fixedPos = false

func _process(delta):
	super(delta)
	
	shootDir = player.global_position - global_position
	
	match(state):
		"idle":
			velocity = Vector2(0,0)
			idleCounter += 1
			if idleCounter >= idleCooldown:
				idleCounter = 0
				if shootChase == true:
					state = "shoot"
					shootChase = false
				else:
					state = "chase"
					shootChase = true
		"shoot":
			var shotVector = shootDir
			var angle_degrees = 10
			var angle_radians = deg_to_rad(angle_degrees)
			var cos_angle = cos(angle_radians)
			var sin_angle = sin(angle_radians)
			
			var rotatedVector = Vector2(
				shotVector.x * cos_angle - shotVector.y * sin_angle,
				shotVector.x * sin_angle + shotVector.y * cos_angle
			)
			
			angle_degrees = -10
			angle_radians = deg_to_rad(angle_degrees)
			cos_angle = cos(angle_radians)
			sin_angle = sin(angle_radians)
			
			var rotatedVector2 = Vector2(
				shotVector.x * cos_angle - shotVector.y * sin_angle,
				shotVector.x * sin_angle + shotVector.y * cos_angle
			)
			
			shoot(rotatedVector2)
			shoot(rotatedVector)
			
			
			state = "idle"
		"chase":
			velocity = shootDir.normalized() * 30
			
			chaseCounter += 1
			
			if chaseCounter >= chaseCooldown:
				chaseCounter = 0
				state = "idle"
			
