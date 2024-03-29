extends Area2D
signal hit

@export var speed = 400
var screen_size



# Called when the node enters the scene tree for the first time.
func _ready():
	set_y_sort_enabled(true)
	screen_size = get_viewport_rect().size
	hide()
	
	
func start(pos):
	position = pos
	show()
	$AnimatedSprite2D.play()
	$CollisionShape2D.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0 or velocity.y != 0:
		$AnimatedSprite2D.animation = "WalkR"
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.animation = "Idle"
		


func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
