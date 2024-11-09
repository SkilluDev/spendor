extends Area2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
@export var rot=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size=get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("rotate_left"):
		rot_left()
	if Input.is_action_pressed("rotate_right"):
		rot_right()
	if Input.is_action_pressed("shoot"):
		shoot()
	if Input.is_action_just_released("shoot"):
		stand()
	

func rot_right():
	rot+=0.05
	set_rotation(rot)
func rot_left():
	rot-=0.05
	set_rotation(rot)
	
func shoot():
	$AnimatedSprite2D.animation="shoot"
	$laser.show()
	$laser/lascol.disabled=false
	
func stand():
	$AnimatedSprite2D.animation="stand"
	$laser.hide()
	$laser/lascol.disabled=true
	
func start(pos):
	position=pos
	show()
	$CollisionShape2D.disabled=false


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
