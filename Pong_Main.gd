extends Node2D

var linie_rect
var horizontal_max
var vertical_max
var box_height
var box_width
var counter_player_left = 0
var counter_player_right = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	horizontal_max = int(get_viewport().size.x)
	vertical_max  = int(get_viewport().size.y)
	box_height = vertical_max/50
	box_width = 8
#Check if a Joystick is connected
	Input.connect("joy_connection_changed",self,"joy_con_changed")

func joy_con_changed(deviceid, isConnected):
	if isConnected:
		print("Joystick "+str(deviceid)+" connected")
		if Input.is_joy_known(0):
			print("Recognized controller")
			print(Input.get_joy_name(0)+" device found")
	else:
		print("Controller disconnected")

func _draw():
	draw_rect(Rect2(0,0,horizontal_max,vertical_max),"000000",true)
	for n in range(box_height,vertical_max - box_height,box_height*2):
		linie_rect = Rect2(horizontal_max/2 - box_width/2,n, box_width, box_height)
		draw_rect(linie_rect, "000000", true)
		linie_rect = Rect2(horizontal_max/2 - box_width/2,n, box_width, box_height)
		draw_rect(linie_rect, "ffffff", true)

#warning-ignore:unused_argument
# warning-ignore:unused_argument
func _physics_process(delta):
	pass

func _on_Ball_count_for_left():
	counter_player_left += 1
	$HUD.count_for_left(counter_player_left)

func _on_Ball_count_for_right():
	counter_player_right += 1
	$HUD.count_for_right(counter_player_right)
