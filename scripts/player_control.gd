extends CharacterBody2D

const SPEED = 110.0
const JUMP_VELOCITY = -280.0

var perform_jump : bool

var health = 100
var coin: int
@export var coin_label: Label

@export var level_mgr: Node

func _physics_process(delta):
	if not level_mgr.over:
		velocity.x = move_toward(velocity.x, SPEED * Input.get_axis("ui_left", "ui_right"), 20)
		if velocity.x != 0:
			if is_on_floor(): $Body.play("walk")
			$Body.flip_h = velocity.x > 0
		else:
			if is_on_floor(): $Body.play("idle")
	else:
		velocity = Vector2(0, 0)
	
	if Input.is_action_just_pressed("ui_accept") and perform_jump and not level_mgr.over:
		velocity.y = JUMP_VELOCITY
		perform_jump = false
		$Body.scale = Vector2(0.5, 1.5)
		$"/root/JumpSfx".play()
		$"/root/JumpSfx".pitch_scale = randf_range(0.9, 1.1)
		
	if is_on_floor():
		perform_jump = true
	else:
		velocity += get_gravity() * delta
		$Body.play("jump")
	
	move_and_slide()
	$Body.scale = lerp($Body.scale, Vector2(1, 1), 0.1)
	
	if position.y >= 192:
		level_mgr.over = true
	
	if level_mgr.over:
		$Coll.disabled = true
	
	coin_label.text = str(coin)
