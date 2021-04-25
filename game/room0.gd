# script for room 0
extends Node

signal speak(who, msg)

var co # coroutine
var isPlaying : bool = true

func _ready():
	co = script()

func _on_step():
	if isPlaying:
		if co: co = co.resume()

func sleep(seconds):
	isPlaying = false
	yield(get_tree().create_timer(seconds), "timeout")
	isPlaying = true

func teddy(msg):
	emit_signal("speak", "teddy", msg)

func ernie(msg):
	emit_signal("speak", "ernie", msg)

func script():
	yield()
	teddy("Unnnnnnnghh... My poor head.")
	sleep(2)
	yield()
	teddy("Ernie? Are you okay?")
	yield()
	ernie("Was that an earthquake?")
	$"sprites/teleporter".visible = true
	$"sprites/teleporter".sleeping = false
