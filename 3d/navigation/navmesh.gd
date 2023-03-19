extends Node3D

const SPEED := 10.0

@export var show_path := true

var cam_rotation := 0.0
var path: PackedVector3Array

@onready var robot: CharacterBody3D = $NavigationRegion3D/LevelMesh/Cubio
@onready var camera: Camera3D = $CameraBase/Camera3D

func _ready():
	set_process_input(true)


func _physics_process(delta: float):
	pass

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var map := get_world_3d().navigation_map
		var from := camera.project_ray_origin(event.position)
		var to := from + camera.project_ray_normal(event.position) * 1000
		var target_point := NavigationServer3D.map_get_closest_point_to_segment(map, from, to)

		# Set the path between the robot's current location and our target.
#		path = NavigationServer3D.map_get_path(map, robot.position, target_point, false)
		robot.set_target(target_point)
		if show_path:
			draw_path(path)

	elif event is InputEventMouseMotion:
		if event.button_mask & (MOUSE_BUTTON_MASK_MIDDLE + MOUSE_BUTTON_MASK_RIGHT):
			cam_rotation += event.relative.x * 0.005
			$CameraBase.set_rotation(Vector3(0, cam_rotation, 0))


func draw_path(path_array: PackedVector3Array) -> void:
	pass
#	var im: ImmediateMesh = $DrawPath.mesh
#	im.clear_surfaces()
#	im.surface_begin(Mesh.PRIMITIVE_POINTS, null)
#	im.surface_add_vertex(path_array[0])
#	im.surface_add_vertex(path_array[path_array.size() - 1])
#	im.surface_end()
#	im.surface_begin(Mesh.PRIMITIVE_LINE_STRIP, null)
#	for current_vector in path:
#		im.surface_add_vertex(current_vector)
#	im.surface_end()
