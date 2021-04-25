# script for room 0
extends Node

signal speak(who, msg)
signal helptext(msg)

var co # coroutine
var isPlaying : bool = true
var count : int = 0

func _ready():
	co = script()

func _on_step():
	if isPlaying:
		if co: co = co.resume()
		count += 1

func sleep(seconds):
	isPlaying = false
	var lastCount = count
	yield(get_tree().create_timer(seconds), "timeout")
	if count == lastCount:
		isPlaying = true

func find(name):
	return $sprites.get_node(name)

func shake(frames=300):
	$"../camshaker".shake = frames

func shaking():
	return $"../camshaker".shake > 0

func teddy(msg):
	emit_signal("speak", "teddy", msg)

func ernie(msg):
	emit_signal("speak", "ernie", msg)


func helptext(msg):
	emit_signal("helptext", msg)

func _process(_delta):
	if Input.is_key_pressed(KEY_0):
		shake(0)
		isPlaying = true

# --------------------------------------
# logic specific to this room
# --------------------------------------
signal showchat(flag)

func script():
	emit_signal("showchat", false)
	shake()
	while shaking():
		sleep(1); yield()
	emit_signal("showchat", true)
	sleep(2); yield()
	teddy("Unnnnnnnghh... My poor head."); sleep(4); yield()
	ernie("Was that an earthquake?"); sleep(2); yield()
	teddy("Ernie! Are you okay?"); sleep(4); yield()
	ernie("I... uh... Yeah, I think I can move now.")
	helptext("Use W/A/S/D (or ,/A/O/E) keys to move")
	sleep(10); yield()
	teddy("Ernie, that wasn't an earthquake."); sleep(2); yield()
	find("teddy").rotation_degrees = 0
	teddy("I'm afraid I've placed you, me, and everyone we know in terrible, terrible danger."); sleep(4); yield()
	teddy("I need you to get back outside at once, and let Ivan know what happened!"); sleep(4); yield()
	ernie("But... I don't know what happened. Plus... well... I think I'm stuck in this hole."); sleep(4); yield()
	teddy("Tell Ivan it was the [b]Gravitron Generator[/b]. He'll know what has to be done."); sleep(4); yield()
	var teleporter = find("teleporter")
	teleporter.visible = true
	teleporter.sleeping = false
	teddy("Now be quick! Grab hold of this device and DO NOT LET go!"); sleep(2); yield()
	teddy("Hurry, Ernie! The entire town might be at stake!"); yield()
