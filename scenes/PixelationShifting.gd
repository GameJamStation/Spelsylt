extends Node2D

@onready var shader_material: ShaderMaterial = self.material
@export var base_pixel_size: int = 3
@export var period: float = 2.0
@export var amplitude: float = 1.0
var time_passed: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_passed += delta

	#var offset: float = cos(time_passed * 1.2) 
	var offset: float = (4.0/PI) * ( sin((PI*time_passed)/period) + (1.0/3.0) * sin(3*PI*time_passed/period) ) 
	var step: int  = int(round(offset*amplitude))
	shader_material.set_shader_parameter("pixelSize", base_pixel_size + step)



	pass
