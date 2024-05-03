extends Node2D
@export var FORCE_SCALAR = 10


@onready var Head: RigidBody2D = $Head
@onready var Body: RigidBody2D = $Body
var spring: DampedSpringJoint2D
var h_radius : float


# Called when the node enters the scene tree for the first time.
func _ready():
	h_radius = Head.global_position.distance_to(Body.global_position)
	spring = Body.get_node("HeadSpring") as DampedSpringJoint2D
	spring.length = h_radius
	pass # Replace with function body.

func _physics_process(delta):
	var target_pos = (Body.global_position - Head.global_position).normalized() * h_radius + Head.global_position
	
	Head.apply_force(Head.global_position - target_pos, Head.global_position)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
