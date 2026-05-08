extends StaticBody2D

var coord: Vector2i
@export var res: PlantResouce
signal death(coord: Vector2i)

func setup (grid_coord: Vector2i, parent: Node2D, new_res: PlantResouce, plant_death_func):
	position = grid_coord * Data.TILE_SIZE + Vector2i(8,5)
	parent.add_child(self)
	coord = grid_coord
	res = new_res
	$FlashSprite2D.texture = res.texture
	death.connect(plant_death_func)
	
func grow(watered: bool):
	if watered:
		res.grow($FlashSprite2D)
	else:
		res.decay(self)


func _on_collision_area_body_entered(body: Node2D) -> void:
	if res.get_complete():
		$FlashSprite2D.flash(0.2, 0.4, queue_free)
		death.emit(coord)
		res.dead = true
		
		
