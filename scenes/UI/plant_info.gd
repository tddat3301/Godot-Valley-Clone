extends PanelContainer
var res: PlantResouce

# Called when the node enters the scene tree for the first time.
func setup(new_res: PlantResouce):
	res = new_res
	$HBoxContainer/VBoxContainer/NameLabel.text = res.name
	$HBoxContainer/IconTexture.texture = res.icon_texture
	
	$HBoxContainer/VBoxContainer/GrowthBar.max_value = res.h_frames
	$HBoxContainer/VBoxContainer/DeathBar.max_value = res.death_max
	
	update()
	res.connect("changed", queue_free)
	
func update():
	$HBoxContainer/VBoxContainer/GrowthBar.value = res.age
	$HBoxContainer/VBoxContainer/DeathBar.value = res.death_count
	

	
