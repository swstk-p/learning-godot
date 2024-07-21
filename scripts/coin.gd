extends Area2D

var og_scale = scale
# Called when the node enters the scene tree for the first time.
func _ready():
	print("here") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass




func _on_body_entered(_body):
	scale = og_scale if scale==og_scale*2 else og_scale*2
