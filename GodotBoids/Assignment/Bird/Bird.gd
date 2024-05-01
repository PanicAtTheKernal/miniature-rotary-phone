extends Boid

class_name Bird

@export_category("Behaviours")
@export
var centre_point: Marker3D
@export
var take_off_point: Marker3D
@export
var ground: Ground
@export
var ground_speed: float = 5
@export
var flight_speed: float = 10


@onready
var boid: Boid = $"."
@onready
var body = %MeshInstance3D
@onready
var collider: CollisionShape3D = $CollisionShape3D

@export_range(0,360)
var wind_direction: float = 0:
	set(new_value):
		wind_direction_update.emit(new_value)
		wind_direction = new_value
	get:
		return wind_direction

var height: float

signal wind_direction_update(new_direction: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	height = collider.shape.size.y+0.5
	Parameters.BIRD_PROPERTY_CHANGED.connect(_on_bird_property_changed)
	#setup_constrain()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func setup_constrain() -> void:
	var constrain_node: Constrain = boid.find_child("Constrain")
	if constrain_node == null:
		return
	constrain_node.center_path = centre_point.get_path()

func _on_bird_property_changed(node_name,property_name,value):
	if node_name != "self":
		set_child_property(node_name, property_name, value)
	else:
		set_self(property_name, value)

func set_child_property(node_name,property_name,value):
	var node = find_child(node_name)
	if node == null:
		print("Node ",node_name," doesn't exist")
		return
	node.set(property_name, value)

func set_self(property_name, value):
	set(property_name, value)
	if (property_name == "ground_speed") and body.state == "Walking":
		speed = value
	if (property_name == "flying_speed") and body.state == "Flying":		 
		speed = value
