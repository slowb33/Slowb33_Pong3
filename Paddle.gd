extends KinematicBody2D

export var speed = 400  # How fast the paddle will move

func _physics_process(delta):
# Called every frame. 'delta' is the elapsed time since the previous frame.
	var paddle = get_name()
	var velocity = Vector2()  # The player's movement vector.
	
	if Input.is_action_pressed(paddle+"_ui_down"):
		velocity.y += 1
	if Input.is_action_pressed(paddle+"_ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
#		print(collision_info.collider.name)
		
		
