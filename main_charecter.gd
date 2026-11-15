extends CharacterBody2D
func _process(delta):
	if Input.is_action_pressed("Right"):
		position.x += 3500 * delta
		$"MC walk Right".visible = true
		$"MC walk Left".visible = false
		$Idle.visible = false
	elif Input.is_action_pressed("Left"):
		position.x += -3500 * delta
		$"MC walk Left".visible = true
		$"MC walk Right".visible = false
		$Idle.visible = false
	else:
		$Idle.visible = true
		$"MC walk Right".visible = false
		$"MC walk Left".visible = false

const GRAVITY = 9800.0
const JUMP_POWER = -5000.0
const SUPER_JUMP_POWER = -10000.0
var hold_counter = 0.0

func _physics_process(delta):
	if Input.is_action_pressed("Jump"):
		hold_counter += delta
	
	var hold_time = 1.0
	print (hold_counter)
	print (velocity.y)
	print(is_on_floor())
	if not is_on_floor():
		print(velocity.y)
		velocity.y += GRAVITY * delta
	if Input.is_action_just_released("Jump") and hold_counter >= hold_time and is_on_floor():
		velocity.y = SUPER_JUMP_POWER
		
	elif Input.is_action_just_released("Jump") and is_on_floor():
		velocity.y = JUMP_POWER
	move_and_slide()
	
	if not Input.is_action_pressed("Jump"):
		hold_counter = 0.0
#   and hold_counter >= hold_time:  and is_on_floor()  
