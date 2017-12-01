
extends Node2D

# Member variables
const RIGHT = 1
const LEFT = -1
const NAH = 0
const INITIAL_SPEED = 80
const TURNING_SPEED = 50
const TURN_LENGTH = .3 #delta
var speed = INITIAL_SPEED
var turning = 0 #0 for not turning, otherwise delta til turning is done
const TURNING_COOLDOWN_TIME = 1
var turningCooldown = 0
var screen_size = Vector2(640, 400)


# Default direction
var direction = Vector2(1, 0)
var size = Vector2(25, 16) #overwritten dynamically in ready function so this can be whatever

# Check if we should turn. Return the direction
func checkIfInTurnInRoad(position):
	var leftTurns = get_node("/root/level/roads/turns/left").get_children()
	var rightTurns = get_node("/root/level/roads/turns/right").get_children()
	for leftTurn in leftTurns:
		var texture = leftTurn.get_texture()
		var size = Vector2(texture.get_width(), texture.get_height())
		var collisionBox = Rect2(leftTurn.get_pos() - size*0.5, size)
		if (collisionBox.has_point(position)): return LEFT
	for rightTurn in rightTurns: #this should be refactored bc copypasta
		var texture = rightTurn.get_texture()
		var size = Vector2(texture.get_width(), texture.get_height())
		var collisionBox = Rect2(rightTurn.get_pos() - size*0.5, size)
		if (collisionBox.has_point(position)): return RIGHT
	return NAH

# Returns new Vector2 indicating new direction. Assumes only up, down, left, and right as directions (no angles)
# currentDir should be a vector indicating current direction of object, turnDir is an int indicating left or right
func turn(currentDir, turnDir):
	print(currentDir, turnDir)
	if (currentDir.x > 0): #moving right, ie: Vector2(1, 0)
		if (turnDir == RIGHT): return Vector2(currentDir.y, currentDir.x) #Go Down
		return Vector2(currentDir.y, currentDir.x * - 1) #Go Up
	if (currentDir.x < 0): #moving left, ie: Vector2(-1, 0)
		if (turnDir == RIGHT): return Vector2(currentDir.y * -1, currentDir.x) #Go Up
		return Vector2(currentDir.y, currentDir.x * - 1) #Go Down
	if (currentDir.y > 0): #moving down, ie: Vector2(0, 1)
		if (turnDir == RIGHT): return Vector2(currentDir.y * - 1, currentDir.x) #Go Left
		return Vector2(currentDir.y, currentDir.x) #Go Right
	if (currentDir.y < 0): #moving up, ie: Vector2(0, -1)
		if (turnDir == RIGHT): return Vector2(currentDir.y * -1, currentDir.x) #Go Right
		return Vector2(currentDir.y, currentDir.x) #Go Left

func _process(delta):
	var position = get_pos()
	
	# Integrate new car postion
	position += direction*speed*delta
	
	set_pos(position) #get_node("ball").set_pos(position)
	
	#if turning and almost done, finish the turn by changing directions and set cooldown timer
	if (turning > 0 and (turning - delta <= 0)):
		var directionToTurn = checkIfInTurnInRoad(position)
		if (directionToTurn != NAH):
			direction = turn(direction, directionToTurn)
			speed = INITIAL_SPEED
			turning = 0
			turningCooldown = TURNING_COOLDOWN_TIME
	
	#Decrement *ALL* the timers!
	if (turning > 0): turning = turning - delta
	if (turningCooldown > 0): turningCooldown = turningCooldown - delta
	
	#If not turning, see if we're hitting a turn in the road, start to turn, and start timer to when to stop turning
	if (turning <= 0 and turningCooldown <= 0):
		var directionToTurn = checkIfInTurnInRoad(position)
		if (directionToTurn != NAH):
			turning = TURN_LENGTH
			speed = TURNING_SPEED
			print('skrrrt')

func _ready():
	screen_size = get_viewport_rect().size # Get actual size
	size = get_texture().get_size()
	print('size:', size)
	for child in get_children():
		print (child)
	set_process(true)
