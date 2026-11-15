extends Label

var elapsed := 0.0

func _process(delta):
	elapsed += delta
	var minutes = int(elapsed) / 60
	var seconds = int(elapsed) % 60
	text = "%02d:%02d" % [minutes, seconds]
	if Input.is_action_just_released("Ending"):
		set_process(false)  # stops _process, so the timer freezes
