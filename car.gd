
extends Node2D

# Member variables
const INITIAL_SPEED = 80
var speed = INITIAL_SPEED
var screen_size = Vector2(640, 400)

# Default direction
var direction = Vector2(1, 0)
var size = Vector2(25, 16) #overwritten dynamically in ready function so this can be whatever


func _process(delta):
	
	# Get  position and pad rectangles
	var position = get_pos() #get_node("ball").get_pos()
	#var left_rect = Rect2(get_node("left").get_pos() - size*0.5, size)
	#var right_rect = Rect2(get_node("right").get_pos() - size*0.5, size)
	
	# Integrate new ball postion
	position += direction*speed*delta
	
	# Flip when touching roof or floor
	#if ((position.y < 0 and direction.y < 0) or (position.y > screen_size.y and direction.y > 0)):
	#	direction.y = -direction.y
	
	# Flip, change direction and increase speed when touching pads
	#if ((left_rect.has_point(position) and direction.x < 0) or (right_rect.has_point(position) and direction.x > 0)):
	#	direction.x = -direction.x
	#	speed *= 1.1
	#	direction.y = randf()*2.0 - 1
	#	direction = direction.normalized()
	
	set_pos(position) #get_node("ball").set_pos(position)
	
	# Move left pad
	#var left_pos = get_node("left").get_pos()
	
	#if (left_pos.y > 0 and Input.is_action_pressed("left_move_up")):
		#left_pos.y += -PAD_SPEED*delta
	#if (left_pos.y < screen_size.y and Input.is_action_pressed("left_move_down")):
		#left_pos.y += PAD_SPEED*delta
	
	#get_node("left").set_pos(left_pos)
	
	# Move right pad
	#var right_pos = get_node("right").get_pos()
	
	#if (right_pos.y > 0 and Input.is_action_pressed("right_move_up")):
		#right_pos.y += -PAD_SPEED*delta
	#if (right_pos.y < screen_size.y and Input.is_action_pressed("right_move_down")):
		#right_pos.y += PAD_SPEED*delta
	
	#get_node("right").set_pos(right_pos)


func _ready():
	screen_size = get_viewport_rect().size # Get actual size
	size = get_texture().get_size()
	print('size:', size)
	for child in get_children():
		print (child)
	set_process(true)
