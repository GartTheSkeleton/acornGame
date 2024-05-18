extends Node2D
var levelGrid = []
var roomGrid = [] #this logs what room is chosen for each level in levelGrid
var startRoomX = 0
var startRoomY = 0

var enemyCount = 0

var playerPosX = startRoomX
var playerPosY = startRoomY

var genericBlock = preload("res://genericsquare.tscn")

var room001 = preload("res://room_001.tscn")
var room002 = preload("res://room_002.tscn")
var treasure = preload("res://null_room.tscn")
var bossroom1 = preload("res://null_room.tscn")

var levelLibrary = {0:room001,1:treasure,2:bossroom1,3:room002}
var availableLevels = [0,3] #rooms availbe to be spawned in this level

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")

var currRoom = 0 #counter pointing to the room we want to spawn from levelLibrary

var currLevel #points to room node

var posX = startRoomX
var posY = startRoomY

var genLen = 10
var switch = false

func _ready():
	levelGrid.append(["start",startRoomX,startRoomY])
	
	var offsetAmounts = [1,2,2,3,-1,-2,-2,-3]
	var bossOffset = [3,4,-3,-4]
	
	var noisecount = 4
	
	levelGrid.append(["treasure",startRoomX+offsetAmounts.pick_random(),startRoomY+offsetAmounts.pick_random()])
	levelGrid.append(["boss",startRoomX+bossOffset.pick_random(),startRoomY+bossOffset.pick_random()])
	
	print(levelGrid)
	
	posX = 0
	posY = 0
	
	for i in genLen:
		var doorCount = [1,1,2,2,3].pick_random()
		var bossX = levelGrid[2][1]
		var bossY = levelGrid[2][2]
		
		var coinflip = [0,1].pick_random()
		if coinflip == 0:
			if posX != bossX:
				if posX < bossX:
					posX += 1
				if posX > bossX:
					posX -= 1 
			else:
				if posY != bossY:
					if posY < bossY:
						posY += 1
					if posY > bossY:
						posY -= 1
		else:
			if posY != bossY:
				if posY < bossY:
					posY += 1
				if posY > bossY:
					posY -= 1 
			else:
				if posX != bossX:
					if posX < bossX:
						posX += 1
					if posX > bossX:
						posX -= 1
		if posX == bossX and posY == bossY:
			pass
		else:
			var checkForDupes = false
			for ii in levelGrid.size():
				if posX == levelGrid[ii][1] and posY == levelGrid[ii][2]:
					checkForDupes = true
			if checkForDupes == false:
				levelGrid.append(["room",posX,posY])
	posX = startRoomX
	posY = startRoomY
	var treasureX = levelGrid[1][1]
	var treasureY = levelGrid[1][2]
	for i in genLen:
		var coinflip = [0,1].pick_random()
		if coinflip == 0:
			if posX != treasureX:
				if posX < treasureX:
					posX += 1
				if posX > treasureX:
					posX -= 1
		else:
			if posY != treasureY:
				if posY < treasureY:
					posY += 1
				if posY > treasureY:
					posY -= 1
		var checkForDupes = false
		for ii in levelGrid.size():
			if posX == levelGrid[ii][1] and posY == levelGrid[ii][2]:
				checkForDupes = true
		if checkForDupes == false:
			levelGrid.append(["room",posX,posY])
	
	var bhungus = levelGrid.size()/2
	
	posX = levelGrid[bhungus][1]
	posY = levelGrid[bhungus][2]
	
	if is_in_levelGrid(posX+1,posY) == false:
		levelGrid.append(["noise",posX+1,posY])
	else:
		if is_in_levelGrid(posX-1,posY) == false:
			levelGrid.append(["noise",posX-1,posY])
		else:
			if is_in_levelGrid(posX,posY+1) == false:
				levelGrid.append(["noise",posX,posY+1])
			else:
				if is_in_levelGrid(posX,posY-1) == false:
					levelGrid.append(["noise",posX,posY-1])
	
	bhungus = levelGrid.size()-2
	posX = levelGrid[bhungus][1]
	posY = levelGrid[bhungus][2]
	
	if is_in_levelGrid(posX+1,posY) == false:
		levelGrid.append(["noise",posX+1,posY])
	else:
		if is_in_levelGrid(posX-1,posY) == false:
			levelGrid.append(["noise",posX-1,posY])
		else:
			if is_in_levelGrid(posX,posY+1) == false:
				levelGrid.append(["noise",posX,posY+1])
			else:
				if is_in_levelGrid(posX,posY-1) == false:
					levelGrid.append(["noise",posX,posY-1])
	bhungus = levelGrid.size()-4
	posX = levelGrid[bhungus][1]
	posY = levelGrid[bhungus][2]
	
	if is_in_levelGrid(posX+1,posY) == false:
		levelGrid.append(["noise",posX+1,posY])
	else:
		if is_in_levelGrid(posX-1,posY) == false:
			levelGrid.append(["noise",posX-1,posY])
		else:
			if is_in_levelGrid(posX,posY+1) == false:
				levelGrid.append(["noise",posX,posY+1])
			else:
				if is_in_levelGrid(posX,posY-1) == false:
					levelGrid.append(["noise",posX,posY-1])
	
	print(levelGrid)
	
	rooms()
	
	level_transition(0,"center")
	
	#for i in levelGrid.size():
		#var chungus = genericBlock.instantiate()
		#chungus.roomType = levelGrid[i][0]
		#chungus.global_position.x = global_position.x + (levelGrid[i][1] * 32)
		#chungus.global_position.y = global_position.y + (levelGrid[i][2] * 32)
		#add_child(chungus)
	

func is_in_levelGrid(x,y):
	for i in levelGrid.size():
		if x == levelGrid[i][1] and y == levelGrid[i][2]:
			return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemyCount <= 0:
		print("All enemies dead")
	
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
		"center":
			player.global_position.x = 572
			player.global_position.y = 300
	player.visible = false
	
	if currLevel:
		currLevel.queue_free()
	
	await get_tree().create_timer(.1).timeout
	
	#targetLevel = 
	
	player.visible = true
	currLevel = levelLibrary[targetLevel].instantiate()
	currLevel.global_position.x = 0
	currLevel.global_position.y = 0
	get_parent().add_child(currLevel)
	switch = false
	currRoom = availableLevels.pick_random()

func rooms():
	for i in levelGrid.size():
		var nextroom = availableLevels.pick_random()
		
		roomGrid.append({"roomId":nextroom,"cleared":false})
		
	print(roomGrid)

func getRoomId():
	for i in levelGrid.size():
		var targetLevel
		if levelGrid[i][1] == playerPosX and levelGrid[i][2] == playerPosY:
			targetLevel = roomGrid[i].roomId
			return targetLevel
