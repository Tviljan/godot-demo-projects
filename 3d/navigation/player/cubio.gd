extends CharacterBody3D

var path: PackedVector3Array
var moveSpeed := 200.0
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")
var movement_delta: float


### path from NavigationServer3D.map_get_closest_point_to_segment
func set_path(path: PackedVector3Array) -> void:
	self.path = path
	
func set_target(target: Vector3) -> void:
	$NavigationAgent3D.set_target_position(target)
	
func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return
	if not navigation_agent.is_target_reachable():
		print ("blocked!!")

	movement_delta = moveSpeed * delta
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var current_agent_position: Vector3 = global_transform.origin
	var new_velocity: Vector3 = (next_path_position - current_agent_position).normalized() * movement_delta
	navigation_agent.set_velocity(new_velocity)
	#velocity = new_velocity


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	print ("Vel: ", velocity)
	var blocked = move_and_slide()
	if (blocked):
		print  ("blocked")


func _on_navigation_agent_3d_link_reached(details):
	print ("link_reached") #pass # Replace with function body.


func _on_navigation_agent_3d_waypoint_reached(details):
	print ("waypoint_reached") #pass # Replace with function body.
