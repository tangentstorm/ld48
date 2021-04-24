# script for room 0
extends Node

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

onready var dialog = $"/root/scene/dialog"

func teddy(msg):
	speak("Teddy", msg)

func speak(who, msg):
	dialog.text = who + ": " + msg

func script():
	dialog.text = ""
	yield()
	teddy("Unnnnnnnghh...\n My poor head...")
	sleep(2)
	yield()
	teddy("It's dangerous to go alone. Take this!")
	$teleporter.visible = true
	$teleporter.sleeping = false
