extends Sprite

const maxSpeed = 80

func _process(delta):

	if Input.is_action_pressed("move_up"): moveUp(delta)
	if Input.is_action_pressed("move_down"): moveDown(delta)
	if Input.is_action_pressed("move_left"): moveLeft(delta)
	if Input.is_action_pressed("move_right"): moveRight(delta)

func moveUp(delta):
	print("up")
	move(delta, 0, -1)

func moveDown(delta):
	move(delta, 0, 1)

func moveLeft(delta):
	move(delta, -1, 0)

func moveRight(delta):
	move(delta, 1, 0)

#x: positive for right, negative for left, 0 for none.
#y: positive for down, negative for up, 0 for none.
func move(delta, x, y):
	print("yes")
	var pos = get_pos()
	pos.x += x * maxSpeed * delta
	pos.y += y * maxSpeed * delta
	set_pos(pos)

func _ready():
	set_process(true)
	set_process_input(true)
