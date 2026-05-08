extends CharacterBody2D

var direction: Vector2
var last_direction: Vector2

var speed := 50
var can_move: bool = true

@onready var move_state_machine = $Animation/AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var tool_state_machine = $Animation/AnimationTree.get("parameters/ToolStateMachine/playback")

signal tool_use(tool: Enum.Tool, pos: Vector2)
signal diagnose

var current_tool: Enum.Tool 
var current_seed: Enum.Seed 

func _physics_process(delta: float) -> void:
	if can_move:
		get_basic_input()
		move()
		animate()
		
	if direction:
		last_direction = direction

func move():
	direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	
func animate():
	if direction:
		move_state_machine.travel('Walk')
		var direction_animation = Vector2(round(direction.x), round(direction.y))
		$Animation/AnimationTree.set("parameters/MoveStateMachine/Idle/blend_position", direction_animation)
		$Animation/AnimationTree.set("parameters/MoveStateMachine/Walk/blend_position", direction_animation)
		for animation in Data.TOOL_STATE_ANIMATIONS.values():
			var animation_name: String = "parameters/ToolStateMachine/"+animation+"/blend_position"
			$Animation/AnimationTree.set(animation_name, direction_animation)
		
	else:
		move_state_machine.travel('Idle')
		

func get_basic_input():
	if Input.is_action_just_pressed("tool_forward") or Input.is_action_just_pressed("tool_backward"):
		var dir = Input.get_axis("tool_backward","tool_forward")
		current_tool = posmod((current_tool + int(dir)), Enum.Tool.size()) as Enum.Tool
		$ToolUI.reveal(true)
		
	if Input.is_action_just_pressed("seed_forward"):
		current_seed = posmod(current_seed + 1, Enum.Seed.size()) as Enum.Seed
		$ToolUI.reveal(false)
	
	
	if Input.is_action_just_pressed("action"):
		tool_state_machine.travel(Data.TOOL_STATE_ANIMATIONS[current_tool])
		$Animation/AnimationTree.set("parameters/ToolOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	
	if Input.is_action_just_pressed("diagnose"):
		diagnose.emit()

func tool_use_emit():
	tool_use.emit(current_tool,position + last_direction * 16 + Vector2(0,4))



func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	can_move = false


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	can_move = true
