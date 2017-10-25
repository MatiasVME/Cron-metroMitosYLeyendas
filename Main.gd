extends Node2D

onready var counter1 = get_node("Counter1")
onready var counter2 = get_node("Counter2")
onready var timer = get_node("Timer")

onready var btn_lbl_start = get_node("Start/Start")
onready var alarm = get_node("Alarm")

const MAX_TIME = 300

var current_time = 0
var minutes = 0
var seconds = 0

var is_stoped = true

func _ready():
	timer.set_wait_time(MAX_TIME)
	set_process(true)
	
func _process(delta):
	if not is_stoped:
		display_time()

func display_time():
	current_time = timer.get_time_left()
	
	minutes = int(current_time / 60)
	seconds = int(current_time) % 60
	
	counter1.set_text(str(str(minutes), ":", str(seconds)))
	counter2.set_text(str(str(minutes), ":", str(seconds)))

func _on_Reset_pressed():
	var current_time = 300
	timer.set_wait_time(MAX_TIME)
	
	if timer.is_active():
		timer.set_active(false)
		
	counter1.set_text("5:00")
	counter2.set_text("5:00")
	btn_lbl_start.set_text("start")
	
	is_stoped = true
	
func _on_Pause_pressed():
	if timer.is_active():
		timer.set_active(false)
	else:
		timer.set_active(true)

func _on_Start_pressed():
	is_stoped = false
	
	if not timer.is_active():
		timer.set_active(true)
	
	timer.start()
	timer.set_wait_time(MAX_TIME)
	btn_lbl_start.set_text("Siguiente turno")

func _on_Timer_timeout():
	alarm.play()
	timer.stop()