extends StaticBody2D

var appear: bool

@export var start_time = 1.0
@export var appear_time = 1.0

func _ready():
	$StartTimer.wait_time = start_time
	$AppearTimer.wait_time = appear_time
	$StartTimer.start()

func _on_start_timer_timeout():
	$AppearTimer.start()

func _on_appear_timer_timeout():
	appear = not appear
	$Sprite2D.visible = appear
	$CollisionShape2D.disabled = not appear
	if appear:
		$AudioStreamPlayer2D.play()
