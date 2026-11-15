extends CharacterBody2D
var superJumpAnimation = false
func _process(delta):
	if Input.is_action_pressed("Right"):
		position.x += 3500 * delta
		$"MC walk Right".visible = true
		$"MC walk Left".visible = false
		$Idle.visible = false
		$GroundPound.visible = false
		$"Jump ready".visible = false
		$RighAirDash.visible = false
		$LeftAirDash.visible = false
	elif Input.is_action_pressed("Left"):
		position.x += -3500 * delta
		$"MC walk Left".visible = true
		$"MC walk Right".visible = false
		$Idle.visible = false
		$GroundPound.visible = false
		$"Jump ready".visible = false
		$RighAirDash.visible = false
		$LeftAirDash.visible = false
	elif superJumpAnimation == false:
		$Idle.visible = true
		$"MC walk Right".visible = false
		$"MC walk Left".visible = false
		$GroundPound.visible = false
		$"Jump ready".visible = false
		$RighAirDash.visible = false
		$LeftAirDash.visible = false
	if Input.is_action_pressed("GroundPound"):
		velocity.y = GROUND_POUND_SPEED
		$Idle.visible = false
		$"MC walk Right".visible = false
		$"MC walk Left".visible = false
		$GroundPound.visible = true
		$"Jump ready".visible = false
		$RighAirDash.visible = false
		$LeftAirDash.visible = false
	if Input.is_action_pressed("AirDash") and air_dash_number >= 1:
		if Input.is_action_pressed("Right"):
			$RighAirDash.visible = true
			$"MC walk Right".visible = false
			$"MC walk Left".visible = false
			$GroundPound.visible = false
			$"Jump ready".visible = false
			$LeftAirDash.visible = false
			velocity.x = AIR_DASH
			air_dash_number = 0
		elif Input.is_action_pressed("Left"):
			$LeftAirDash.visible = true
			$RighAirDash.visible = false
			$"MC walk Right".visible = false
			$"MC walk Left".visible = false
			$GroundPound.visible = false
			$"Jump ready".visible = false
			velocity.x = AIR_DASH * -1
			air_dash_number = 0
		elif Input.is_action_pressed("Jump"):
			velocity.y = AIR_DASH * -1
			air_dash_number = 0
const GRAVITY = 9800.0
const JUMP_POWER = -5000.0
const SUPER_JUMP_POWER = -10000.0
const GROUND_POUND_SPEED = 10000.0
const BASE_SPEED = 300.0
const BOOST_SPEED = 1600.0
const DECAY_RATE = 400.0 # Speed which it goes down
const AIR_DASH = 5000
var hold_counter = 0.0
var current_speed = BASE_SPEED
var air_dash_number = 1
var prev_frame_vel: Vector2 = Vector2.ZERO
var was_on_floor = true




func _physics_process(delta):

	await get_tree().create_timer(0.1).timeout
	if Input.is_action_pressed("Jump"):
		hold_counter += delta
	
	if Input.is_action_just_pressed("speed_boost"):
		current_speed = BOOST_SPEED
		
		current_speed = move_toward(current_speed, BASE_SPEED, DECAY_RATE * delta)
		
		var direction = Input.get_axis("Left", "Right")
		velocity.x = direction * current_speed
	
	var hold_time = 1.0
	#print (hold_counter)
	#print (velocity.y)
	#print(is_on_floor())
	if not is_on_floor():
		#print(velocity.y)
		velocity.y += GRAVITY * delta
	else: air_dash_number = 1
			
	if Input.is_action_just_released("Jump") and hold_counter >= hold_time and is_on_floor():
		velocity.y = SUPER_JUMP_POWER
		
	elif Input.is_action_just_released("Jump") and is_on_floor():
		velocity.y = JUMP_POWER
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()) *0.7
		
	move_and_slide()
	if abs(velocity.y) < 20: velocity.y = 0
	if not Input.is_action_pressed("Jump"):
		hold_counter = 0.0
	print(velocity.y)
	prev_frame_vel = velocity
	was_on_floor = is_on_floor()
	if hold_counter >= 1:
		$"MC walk Right".visible = false
		$"MC walk Left".visible = false
		$Idle.visible = false
		$GroundPound.visible = false 
		$"Jump ready".visible = true
		$RighAirDash.visible = false
		$LeftAirDash.visible =false
	superJumpAnimation = true
#   and hold_counter >= hold_time:  and is_on_floor()  
