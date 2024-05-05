extends Node2D
@export var FORCE_SCALAR = 100
@export var DAMP_SCALAR = 5
@export var NECKMAX_SCALAR : float = 1.2


@onready var Head: RigidBody2D = $Head
@onready var Body: RigidBody2D = $Body

@onready var NeckStart: Marker2D = $Body/NeckStart
@onready var NeckEnd: Marker2D = $Head/NeckEnd
@onready var NeckPath: Node = $NeckPath

var h_radius : float
var target_pos : Vector2

@onready var last_mpos : Vector2 = get_global_mouse_position()
@onready var last_target_delta : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	h_radius = NECKMAX_SCALAR * Head.global_position.distance_to(Body.global_position)
	pass # Replace with function body.

func _physics_process(delta):
	var curr_mpos = get_global_mouse_position()
	var body_delta = (curr_mpos - Body.global_position)
	target_pos = body_delta.normalized() * clampf(body_delta.length(), 0.2, h_radius) + Body.global_position
	
	var target_delta = target_pos - Head.global_position
	var force = FORCE_SCALAR * (1 + FORCE_SCALAR*(curr_mpos - last_mpos).length() * delta)
	Head.apply_force(target_delta * FORCE_SCALAR, Head.global_position)
	
	var v = Head.linear_velocity - Body.linear_velocity
	var damp = DAMP_SCALAR / (FORCE_SCALAR * target_delta.length() + 0.0001)
	Head.apply_force(-v * DAMP_SCALAR, Head.global_position)
	Head.apply_impulse((curr_mpos - last_mpos) * Head.mass, Head.global_position)
	
	if last_target_delta.dot(target_delta) < 0 or (Body.global_position - Head.global_position).length() > h_radius:
		Head.apply_impulse(-v*Head.mass, Head.global_position)
		
	
	last_target_delta = target_delta
	last_mpos = curr_mpos
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var p1 = NeckStart.global_position
	var p2 = NeckEnd.global_position
	
	var dists = [0.2, 0.5, 0.7]
	var scales= [1, 1, 1]
	for i in NeckPath.get_child_count():
		var segment : Sprite2D = NeckPath.get_child(i)

		segment.scale.y = (p1-p2).length() * scales[i] / h_radius
		segment.global_rotation = (p1 - p2).angle() + PI/2
		segment.global_position = p1.lerp(p2, dists[i]) 
	
	pass
