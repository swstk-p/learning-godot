extends Node

var score = 0
@onready var score_label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score_label.text = "you got "+str(score)+"\nDID YOU GET THEM ALL?	"

func add_score():
	score += 1


func _on_bridge_detection_body_entered(body):
# the bridge must fall
	print("player detected on bridge")
