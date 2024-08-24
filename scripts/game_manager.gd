extends Node

var score = 0
var bridge_parts:int = -2
var current_bridge_part = -1
var bridge_slime_new_boundary_entered_count:int = 0
@onready var score_label = $ScoreLabel
@onready var bridge = $"../Bridge"
@onready var bridge_timer = $"../BridgeTimer"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score_label.text = "you got "+str(score)+"\nDID YOU GET THEM ALL?	"

func add_score():
	score += 1


func _on_bridge_detection_body_entered(_body):
# the bridge must fall
	print("player detected on bridge")
	bridge_parts = bridge.get_child_count()
	current_bridge_part = 0	
	bridge_timer.start()
# the detector is deleted
	var bridge_detection = $"../BridgeDetection"
	bridge_detection.queue_free()


func _on_bridge_timer_timeout():
	if current_bridge_part == 0:
		# world boundary deletes
		var world_collision_3 = $"../SlimeCollisionBoundaries/WorldCollision3"
		world_collision_3.queue_free()
		# new world boundary activates
		var world_collision_5 = $"../SlimeCollisionBoundaries/WorldCollision5"
		world_collision_5.collision_mask = 1
		world_collision_5.collision_layer = 2
		# slime raycasts disabled
		var purple_slime_4 = $"../Slimes/PurpleSlime4"
		purple_slime_4.no_ray_casts = true
		# slime goes to safe place
		purple_slime_4.direction = 1
	if current_bridge_part != -1:
		bridge.get_child(current_bridge_part).gravity_scale = 2.5
		if(current_bridge_part == (bridge_parts - 1)):
			bridge.get_child(current_bridge_part).collision_layer = 2
		current_bridge_part+=1
		if current_bridge_part<bridge_parts:
			bridge_timer.start()
		else:
			bridge_timer.stop()


func _on_killzone_bridge_over():
#delete bridge
	bridge.queue_free()
#delete timer
	bridge_timer.queue_free()


func _on_world_collision_5_area_entered(area):
	if area is PurpleSlime and bridge_slime_new_boundary_entered_count <= 2:
		bridge_slime_new_boundary_entered_count+=1
		if bridge_slime_new_boundary_entered_count == 2: 
			var purple_slime_4 = $"../Slimes/PurpleSlime4"
			purple_slime_4.direction = -1
			purple_slime_4.no_ray_casts = false
