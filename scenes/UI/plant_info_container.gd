extends Control


# Called when the node enters the scene tree for the first time.
func add(child: PanelContainer):
	$MarginContainer/ScrollContainer/VBoxContainer.add_child(child)
	
func update_all():
	for plant_info in $MarginContainer/ScrollContainer/VBoxContainer.get_children():
		plant_info.update()
