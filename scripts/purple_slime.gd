extends Area2D
class_name PurpleSlime
@onready var ray_cast_2d_left = $RayCast2DLeft
@onready var ray_cast_2d_right = $RayCast2DRight
@onready var sprite = $AnimatedSprite2D
var speed = 50
var direction = 1
var no_ray_casts:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ray_cast_2d_left.collide_with_bodies=false
	ray_cast_2d_right.collide_with_bodies=false
	ray_cast_2d_left.collide_with_areas=true
	ray_cast_2d_right.collide_with_areas=true	
   

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not no_ray_casts:
		direction = -1 if ray_cast_2d_right.is_colliding() else 1 if ray_cast_2d_left.is_colliding() else direction
	sprite.flip_h = true if direction==-1 else false
	position.x+=direction*speed*delta
