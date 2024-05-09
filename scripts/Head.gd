extends RigidBody2D

@onready var Body = $'../Body'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var agg_impulses : Vector2

func _physics_process(delta):
	
	agg_impulses = Vector2.ZERO

func _integrate_forces(state):
	for i in range(state.get_contact_count()):
		var collided_obj = state.get_contact_collider_object(i)
		Body.apply_central_impulse(-state.get_contact_impulse(i))
		#agg_impulses += 
		#print(state.get_contact_impulse(i).length())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
