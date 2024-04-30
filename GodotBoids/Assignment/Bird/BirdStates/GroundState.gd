extends State

class_name GroundState

func _enter():
	boid.pause = false
	boid.banking = 0
	boid.max_speed = 5
	var constrain = boid.find_child("Constrain")
	constrain.center_path = boid.ground.get_path()
	#change_behaviour("Constrain", true)
	change_behaviour("Wander", true)

func _think():
	pass

func _exit():
	pass
