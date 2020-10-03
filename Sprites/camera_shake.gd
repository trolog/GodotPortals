extends Camera2D

onready var timer_shake_length = $timer_shake_length
onready var timer_wait_times = $timer_wait_times
onready var tween_shake = $tween_camera_shake
onready var flash_image = $flash_sprite

var reset_speed = 0
var strength = 0
var doing_shake = false

#connect out timer signal timeouts
func _ready():
	timer_wait_times.connect("timeout",self,"timeout_wait_times")
	timer_shake_length.connect("timeout",self,"timeout_shake_length")
	
#This will stop the shake, and return camera offset to original value
func timeout_shake_length():
	doing_shake = false
	reset_camera()
	
#This function does the tween shaking between intervals
func timeout_wait_times():
	if(doing_shake):
		tween_shake.interpolate_property(self,"offset",offset, Vector2(rand_range(-strength,strength),rand_range(-strength,strength)),reset_speed,Tween.TRANS_SINE,Tween.EASE_OUT)
		tween_shake.start()
		
#once we've finished shaking the screen, tween to original offset
func reset_camera():
	tween_shake.interpolate_property(self,"offset",offset, Vector2(0,0),reset_speed,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween_shake.start()
	
#we're telling the camera to start the shake, and pass some varibles to used in functions else where
func start_shake(time_of_shake,speed_of_shake,strength_of_shake):
	doing_shake = true
	strength = strength_of_shake
	reset_speed = speed_of_shake
	timer_shake_length.start(time_of_shake)
	timer_wait_times.start(speed_of_shake)
	
#This is our flash tween, we tween up, then once we reach up, yield will fire, and we'll tween back down
func start_flash(speed,strength):
	tween_shake.interpolate_property(flash_image,"modulate:a",0,strength,speed,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween_shake.start()
	
	yield(get_tree().create_timer(speed),"timeout")
	tween_shake.interpolate_property(flash_image,"modulate:a",strength,0,speed,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween_shake.start()



