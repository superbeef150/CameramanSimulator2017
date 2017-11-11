extends Node2D

var currentCamera = 0

func _process(delta):
	if (Input.is_action_pressed("camera_switch_up")):
		print("camera up")
	
func _input(ev):
	#if ev.type==InputEvent.MOUSE_BUTTON and ev.button_index == BUTTON_WHEEL_UP: #THIS DOUBLE FIRES!
	if Input.is_action_pressed("camera_switch_up"): cameraUp()
	if Input.is_action_pressed("camera_switch_down"): cameraDown()

func cameraDown():
	var cameraMen = get_node("cars").get_children()
	var cameras = cameraMen.size()
	currentCamera = currentCamera-1
	if currentCamera < 0: currentCamera = cameras - 1
	cameraMen[currentCamera].get_node("Camera2D").make_current()
	
func cameraUp():
	var cameraMen = get_node("cars").get_children()
	var cameras = cameraMen.size()
	currentCamera = currentCamera+1
	if currentCamera >= cameras: currentCamera = 0
	cameraMen[currentCamera].get_node("Camera2D").make_current()

func _ready():
	set_process(true)
	set_process_input(true)