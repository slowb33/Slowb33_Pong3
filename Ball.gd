extends KinematicBody2D

signal count_for_right
signal count_for_left

export var speed = 250

var velocity := Vector2(speed,randi() % 100 + 100)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		
		var collider_name = collision_info.collider.name
#		print(collider_name)
		if collider_name == "LeftPaddle":
			var diff = collision_info.collider.position.y - position.y
			speed=speed+10
			var new_velocity = Vector2(speed, - diff * speed/50 )
			velocity = new_velocity
			print("new_velocity = ", new_velocity)
			print("speed = ", speed)
			$BipSound.play()
		elif collider_name == "RightPaddle":
			var diff = collision_info.collider.position.y - position.y
			speed=speed+10
			var new_velocity = Vector2(speed * -1, - diff * speed/50 )
			velocity = new_velocity
			print("new_velocity = ", new_velocity)
			print("speed = ", speed)
			$BipSound.play()
		elif collider_name == "TopBoundary" or collider_name == "BottomBoundary":
			velocity = velocity.bounce(collision_info.normal)
			$BupSound.play()
		elif collider_name == "LeftBoundary":
			emit_signal("count_for_right")
			reset_ball()
		elif collider_name == "RightBoundary":
			emit_signal("count_for_left")
			reset_ball()

func reset_ball() -> void:
	$BrrrtSound.play()
	position.x = 400
	position.y = randi() % 400 + 100
	speed = 250
#	velocity *= -1
	velocity = Vector2(speed,randi() % 100 + 100)* -1
	
