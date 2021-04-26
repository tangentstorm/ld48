extends KinematicBody2D

signal reach_object(body)
signal leave_object(body)

var focus : Node2D # whatever we're looking at
var was_on_floor: bool = false
var dxy : Vector2 = Vector2(0,0)
const G : Vector2 = Vector2(0,98)
const SPEED = 150
const JUMP  = G * -8
const GROUND_FRICTION = Vector2(0.8,1)
const AIR_FRICTION = Vector2(0.9,1)

const QWERTY = {
	'up': KEY_W,
	'lf': KEY_A,
	'dn': KEY_S,
	'rt': KEY_D,
	'ex': KEY_E }

const DVORAK = {  # guess which keyboard layout I use...
	'up': KEY_COMMA,
	'lf': KEY_A,
	'dn': KEY_O,
	'rt': KEY_E,
	'ex': KEY_PERIOD }

var keys = QWERTY
var useDvorak = false

var interacting = false

func _input(event):
	# teleporter
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				BUTTON_RIGHT: $beam.visible = true
				BUTTON_LEFT:
					if $beam.visible:
						position = event.position
						$beam.visible = false
		elif event.button_index == BUTTON_RIGHT:
			$beam.visible = false


func _physics_process(_delta):
	var vp = get_viewport()
	$beam.points[0] = Vector2.ZERO
	$beam.points[1] = vp.get_mouse_position() - position

	dxy = move_and_slide(dxy + G, Vector2.UP)

	var goL = Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(keys['lf'])
	var goR = Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(keys['rt'])

	if is_on_floor() or is_on_wall():
		if is_on_wall(): dxy.x = 0
		if goL: dxy += Vector2.LEFT * SPEED
		if goR: dxy += Vector2.RIGHT * SPEED
	if is_on_floor():
		dxy *= GROUND_FRICTION
	if is_on_floor() or was_on_floor: # "coyote time" jumps
		if Input.is_key_pressed(KEY_SPACE): dxy += JUMP
	if not is_on_floor():
		dxy *= AIR_FRICTION
		# allow small amount of steering in the air
		if goL: dxy += Vector2.LEFT * SPEED/3
		if goR: dxy += Vector2.RIGHT * SPEED/3

	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().reload_current_scene()

	if Input.is_key_pressed(KEY_9):
		useDvorak = not useDvorak
		keys = QWERTY if useDvorak else DVORAK

	if Input.is_key_pressed(KEY_1):
		Input.set_custom_mouse_cursor(preload("res://sprites/cursor-blocked.png"), 0, Vector2(64,64))
	if Input.is_key_pressed(KEY_2):
		Input.set_custom_mouse_cursor(preload("res://sprites/cursor.png"), 0, Vector2(64,64))
	if Input.is_key_pressed(KEY_3):
		Input.set_custom_mouse_cursor(null, Input.CURSOR_ARROW)
		
	if Input.is_key_pressed(keys['ex']):
		if focus and !interacting:
			interacting = true
			focus.on_interact_begin()
	elif interacting:
		interacting = false
		focus.on_interact_end()

	was_on_floor = is_on_floor()

func _on_area_body_entered(body):
	emit_signal("reach_object", body)
	focus = body

func _on_area_body_exited(body):
	emit_signal("leave_object", body)
	if interacting:
		interacting = false
		focus.on_interact_end()
	focus = null
