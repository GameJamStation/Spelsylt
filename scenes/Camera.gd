extends Camera2D

# Constants
@export var RANDOM_SHAKE_STRENGTH: float = 30.0
@export var SHAKE_DECAY_RATE: float = 5.0
@export var TARGET_OFFSET: Vector2 = Vector2(0, -200.0)

@onready var rand = RandomNumberGenerator.new()

var noise_i: float = 0.0
var shake_strength: float = 0.0
var target: Node2D = null


# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	apply_shake(10)
	target = get_node('../CharacterBody2D') as Node2D
	pass # Replace with function body.

func apply_shake(strenght: float):
	self.shake_strength = strenght*5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)

	var target_position = self.global_position 
	if target != null:
		target_position = target.global_position + TARGET_OFFSET*3

	self.offset = target_position + get_noise_offset() 
	pass

func get_noise_offset():
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)

func set_target(new_target: Node2D):
	self.target = new_target
