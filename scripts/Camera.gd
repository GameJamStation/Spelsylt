extends Camera2D

# Constants
@export var RANDOM_SHAKE_STRENGTH: float = 30.0
@export var SHAKE_DECAY_RATE: float = 5.0
@export var TARGET_OFFSET: Vector2 = Vector2(0, -200.0)
@export var TARGET: Node2D = null
@export var LERP_SPEED: float = 5.0
@export var IS_STATIC: bool = false

@onready var rand = RandomNumberGenerator.new()

var noise_i: float = 0.0
var shake_strength: float = 0.0
var target: Node2D = null
var cock: Cock = null


# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	apply_shake(10)
	cock = get_node("../Cock") as Cock
	target = get_node('../Scenes/first_scene') as Node2D
	cock.new_scene_entered.connect(set_target)
	pass # Replace with function body.

func apply_shake(strenght: float):
	self.shake_strength = strenght*5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	#self.global_position = target_position 
	self.offset = get_noise_offset()
	pass

func get_noise_offset():
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)

func set_target(new_target: Node2D):
	self.target = new_target
	self.global_position = new_target.global_position

