extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	set_y_sort_enabled(true)
	$AnimatedSprite2D.animation = "Walk"
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.flip_h = (linear_velocity.x < 0)
		

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
