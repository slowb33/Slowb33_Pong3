extends KinematicBody2D

signal count_for_right
signal count_for_left

var velocity := Vector2(250,150)


func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		var collider_name = collision_info.collider.name
#		print(collider_name)
		if collider_name == "LeftPaddle" or collider_name == "RightPaddle":
			$BipSound.play()
		elif collider_name == "TopBoundary" or collider_name == "BottomBoundary":
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
	velocity *= -1
