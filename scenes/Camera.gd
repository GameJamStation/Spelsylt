extends Camera2D

# Constants
@export var RANDOM_SHAKE_STRENGTH: float = 30.0
@export var SHAKE_DECAY_RATE: float = 5.0

@onready var rand = RandomNumberGenerator.new()

var noise_i: float = 0.0
var shake_strength: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	apply_shake(10)
	pass # Replace with function body.

func apply_shake(strenght: float):
	self.shake_strength = strenght*5
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):

	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)

	self.offset = get_noise_offset() 
	pass

func get_noise_offset():
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
