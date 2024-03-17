extends CanvasItem
@export var mob_scene: PackedScene
var score



# Called when the node enters the scene tree for the first time.
func _ready():
	set_y_sort_enabled(true)
	new_game()
	
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	direction = direction + randf_range(-PI / 4, PI / 4)
	
	var velocity = Vector2(randf_range(150.0, 200.0), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()