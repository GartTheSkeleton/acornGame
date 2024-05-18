extends Enemy

var state = "idle"

var chaseCounter = 0
var chaseCooldown = 45

var waitCounter = 0
var waitCooldown = 120

var myDir : Vector2

var speed = 180

func _ready():
	randomize()
	super()
	
	waitCooldown += randi_range(-4,4)
	waitCounter += randi_range(-6,6)
	chaseCooldown += randi_range(-4,4)
	chaseCounter += randi_range(-6,6)
	
	shoots = true
	fixedPos = false

func _process(delta):
	super(delta)
	
	myDir = player.global_position - global_position
	
	match(state):
		"idle":
			print("I am Idle")
		"waiting":
			waitCounter += 1
			
			if waitCounter >= 30:
				velocity -= velocity/2
				if velocity.x <= .5 and velocity.x >= -.5 and velocity.y <= .5 and velocity.y >= -.5:
					velocity = Vector2(0,0)
					atkCooldown -= 1
					if atkCooldown <= 0:
						shoot(myDir)
						atkCooldown = cooldownTime
			if waitCounter >= waitCooldown:
				state = "chasing"
				waitCounter = 0
		"chasing":
			var targetPos = player.global_position
			chaseCounter += 1
			if chaseCounter >= chaseCooldown:
				dash(targetPos)
				chaseCounter = 0
				state = "waiting"
	

func _physics_process(delta):
	super(delta)
	var distance = abs(player.global_position - global_position)
	if distance <= Vector2(shootDistance,shootDistance):
		if state == "idle":
			state = "chasing"

func dash(target):
	print("Dashing")
	var angle = (target-global_position ).normalized()
	velocity = angle * speed

func get_sine():
	return sin(time * 2) * .05
