extends Node2D

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")

var level001 = preload("res://room_001.tscn")
var level002 = preload("res://room_002.tscn")
var store = preload("res://null_room.tscn")
var bossroom1 = preload("res://null_room.tscn")

var levelLibrary = {0:level001,1:store,2:bossroom1,3:level002}

var availableLevels = [0,3]

var switch = true
var roomHolder = 0
var currLevel
var doorPos = "bot"
var nextRoom

var startRoom = 30
var currRoom = startRoom

var roomArray = []

var genLen = 10

func _ready():
	randomize()
	roomHolder = availableLevels.pick_random()
	#while roomArray.size() < genLen:
		#var nextDir = [0,1,2,3].pick_random()
		#match nextDir:
			#0:
				#pass

func _process(delta):
	if Input.is_action_just_pressed("2"):
		level_transition(nextRoom,doorPos)
	if switch == true:
		currLevel = levelLibrary[roomHolder].instantiate()
		currLevel.global_position.x = 0
		currLevel.global_position.y = 0
		get_parent().add_child(currLevel)
		switch = false
		nextRoom = availableLevels.pick_random()
		
			
	
func level_transition(targetLevel,doorPos):
	match doorPos:
		"top":
			player.global_position.x = 572
			player.global_position.y = 470
		"bot":
			player.global_position.x = 572
			player.global_position.y = 140
		"left":
			player.global_position.x = 980
			player.global_position.y = 300
		"right":
			player.global_position.x = 160
			player.global_position.y = 300
	player.visible = false
	currLevel.queue_free()
	
	await get_tree().create_timer(.1).timeout
	
	player.visible = true
	currLevel = levelLibrary[targetLevel].instantiate()
	currLevel.global_position.x = 0
	currLevel.global_position.y = 0
	get_parent().add_child(currLevel)
	switch = false
	nextRoom = availableLevels.pick_random()

#var levelGrid = {
		#0:{"room":-1,"leftSide":false,"upSide":false,"rightSide":true,"downSide":true},1:{"room":-1,"leftSide":true,"upSide":false,"rightSide":true,"downside":true},2:{"room":-1,"leftSide":true,"upSide":false,"rightSide":true,"downside":true},3:{"room":-1,"leftSide":true,"upSide":false,"rightSide":true,"downside":true},4:{"room":-1,"leftSide":true,"upSide":false,"rightSide":true,"downside":true},5:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},6:{"room":-1,"xPos":6,"yPos":0,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},7:{"room":-1,"xPos":7,"yPos":0,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},8:{"room":-1,"xPos":8,"yPos":0,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},9:{"room":-1,"xPos":9,"yPos":0,"leftSide":true,"upSide":true,"rightSide":false,"downSide":true},
		#
		#10:{"room":-1,"leftSide":false,"upSide":true,"rightSide":true,"downSide":true},11:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},12:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},13:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},14:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},15:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},16:{"room":-1,"xPos":6,"yPos":1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},17:{"room":-1,"xPos":7,"yPos":1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},18:{"room":-1,"xPos":8,"yPos":1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},19:{"room":-1,"xPos":9,"yPos":1,"leftSide":true,"upSide":true,"rightSide":false,"downSide":true},
		#
		#20:{"room":-1,"leftSide":false,"upSide":true,"rightSide":true,"downSide":true},21:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},22:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},23:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},24:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},25:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},26:{"room":-1,"xPos":6,"yPos":2,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},27:{"room":-1,"xPos":7,"yPos":2,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},28:{"room":-1,"xPos":8,"yPos":2,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},29:{"room":-1,"xPos":9,"yPos":2,"leftSide":true,"upSide":true,"rightSide":false,"downSide":true},
		#
		#30:{"room":-1,"leftSide":false,"upSide":true,"rightSide":true,"downSide":true},31:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},32:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},33:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},34:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},35:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},36:{"room":-1,"xPos":6,"yPos":3,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},37:{"room":-1,"xPos":7,"yPos":3,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},38:{"room":-1,"xPos":8,"yPos":3,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},39:{"room":-1,"xPos":9,"yPos":3,"leftSide":true,"upSide":true,"rightSide":false,"downSide":true},
		#
		#40:{"room":-1,"leftSide":false,"upSide":true,"rightSide":true,"downSide":true},41:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},42:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},43:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},44:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},45:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},46:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},47:{"room":-1,"xPos":7,"yPos":4,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},48:{"room":-1,"xPos":8,"yPos":4,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},49:{"room":-1,"leftSide":true,"upSide":true,"rightSide":false,"downSide":true},
		#
		#50:{"room":-1,"leftSide":false,"upSide":true,"rightSide":true,"downSide":true},51:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},52:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},53:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},54:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},55:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},56:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},57:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},58:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":true},59:{"room":-1,"leftSide":true,"upSide":true,"rightSide":false,"downSide":true},
		#
		#60:{"room":-1,"leftSide":false,"upSide":true,"rightSide":true,"downSide":false},61:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":false},62:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":false},63:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":false},64:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":false},65:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":false},66:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":false},67:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":false},68:{"room":-1,"leftSide":true,"upSide":true,"rightSide":true,"downSide":false},69:{"room":-1,"leftSide":true,"upSide":true,"rightSide":false,"downSide":false}
		#}
#
#var startRoom = 30
#
#var currRoom = startRoom
#
#var roomArray = []
#
#var printed = false
#
#
#
#var recursionCounter = 0 # Counter to stave off recursive logic (This is bad programming)
#
#func _ready():
	#randomize()
	#
	#roomArray.append(currRoom)
	#levelGrid[currRoom].room = currRoom
	#
	#for i in genLen:
		#levelGrid[currRoom].room = [0,3].pick_random()
		#print("Room " + str(i))
		#reroll()
		#if i == genLen - 1:
			#levelGrid[currRoom].room = 2
			#print("Boss room placed at " + str(currRoom))
		#print(roomArray)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if printed == false:
		#print(levelLibrary[0])
		#printed = true
		#for i in roomArray.size():
			#var currLevel = levelLibrary[levelGrid[roomArray[i]].room].instantiate()
			#if roomArray[i] >= 10:
				#currLevel.global_position.x = int(str(roomArray[i]).split()[0]) * 1152
				#currLevel.global_position.y = int(str(roomArray[i]).split()[1]) * 648
			#else:
				#currLevel.global_position.x = int(str(roomArray[i]).split()[0]) * 1152
				#
			#get_parent().add_child(currLevel)
			#print("Spawned " + str(currLevel))
		##var currLevel = level001.instantiate()
		##get_parent().add_child(currLevel)
		#
#func level_transition():
	#print("WOAGH")
	#
	#
#func reroll():
	#if roomArray.size() == 5: #PLACE STORE
		#if levelGrid[currRoom].upSide == true and levelGrid[currRoom - 10].room == -1:
			#levelGrid[currRoom-10].room = 1
			#print("Store placed at " + str(currRoom-10))
		#else:
			#if levelGrid[currRoom].leftSide == true and levelGrid[currRoom - 1].room == -1:
				#levelGrid[currRoom-1].room = 1
				#print("Store placed at " + str(currRoom-1))
			#else:
				#if levelGrid[currRoom].rightSide == true and levelGrid[currRoom + 1].room == -1:
					#levelGrid[currRoom+1].room = 1
					#print("Store placed at " + str(currRoom+1))
				#else:
					#if levelGrid[currRoom].downSide == true:
						#levelGrid[currRoom+10].room = 1
						#print("Store placed at " + str(currRoom+10))
					#else:
						#levelGrid[currRoom-10].room = 1
						#print("Store placed at " + str(currRoom-10))
						#
	#if recursionCounter >= 5:
		#recursionCounter = 0
		#return
	#recursionCounter += 1
	#
	#var nextStep = randi_range(0,3)
	#if nextStep == 0:
		#if levelGrid[currRoom].leftSide == true and levelGrid[currRoom - 1].room == -1:
			#currRoom = currRoom - 1
			#roomArray.append(currRoom)
			#levelGrid[currRoom].room = 0
			#print("Step Left into " + str(currRoom))
			#print("Room Array - " + str(roomArray))
		#else:
			#print("NO STEP SOMETHIGN ALREADY THERE!!!1!")
			#print("Time to reroll.")
			#reroll()
	#if nextStep == 1:
		#if levelGrid[currRoom].upSide == true and levelGrid[currRoom - 10].room == -1:
			#currRoom = currRoom - 10
			#roomArray.append(currRoom)
			#levelGrid[currRoom].room = 0
			#print("Step Up into " + str(currRoom))
			#print("Room Array - " + str(roomArray))
		#else:
			#print("NO STEP SOMETHIGN ALREADY THERE!!!1!")
			#print("Time to reroll.")
			#reroll()
	#if nextStep == 2:
		#if levelGrid[currRoom].rightSide == true and levelGrid[currRoom + 1].room == -1:
			#currRoom = currRoom + 1
			#roomArray.append(currRoom)
			#levelGrid[currRoom].room = 0
			#print("Step Right into " + str(currRoom))
			#print("Room Array - " + str(roomArray))
		#else:
			#print("NO STEP SOMETHIGN ALREADY THERE!!!1!")
			#print("Time to reroll.")
			#reroll()
	#if nextStep == 3:
		#if levelGrid[currRoom].downSide == true and levelGrid[currRoom + 10].room == -1:
			#currRoom = currRoom + 10
			#roomArray.append(currRoom)
			#levelGrid[currRoom].room = 0
			#print("Step Down into " + str(currRoom))
			#print("Room Array - " + str(roomArray))
		#else:
			#print("NO STEP SOMETHIGN ALREADY THERE!!!1!")
			#print("Time to reroll.")
			#reroll()
#
