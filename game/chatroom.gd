extends ScrollContainer

const names = {
	'teddy': 'Teddy Tetraminus',
	'ernie': 'Ernie Goldsmile',
	'ivan' : 'Ivan C. Punchko' }
	
const icons = {
	'teddy': preload("res://sprites/teddy-chat.png"),
	'ernie': preload("res://sprites/ernie-chat.png"),
	'ivan' : preload("res://sprites/ivan-chat.png")}

func _on_room0_speak(who, msg):
	var card = $"../card".duplicate()
	var name = names.get(who)
	if name == null: push_error('unknown cast member: ' + who)
	else:
		var text = "[b][color=#999]" + name + "[/color][/b]: " + msg
		var icon = icons[who]   #$"/root/scene/room/sprites".get_node(who).get_node("sprite").texture
		card.get_node("grid/icon").texture = icon
		card.get_node("text").bbcode_text = text
		card.visible = true
		$vbox.add_child(card)
