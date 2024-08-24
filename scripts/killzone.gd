extends Area2D
@onready var timer = $Timer
signal bridge_over
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		body.get_node("CollisionShape2D").queue_free() #relieves the body of its collisionShape, making it fall down because of gravity and no collsion
		Engine.time_scale = 0.5 #to manipulate time scale (slow-mo, fast-mo) of the entire game
		timer.start()
	elif body is BridgePart:
		bridge_over.emit()

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
