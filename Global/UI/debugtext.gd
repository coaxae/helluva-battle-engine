extends RichTextLabel

@export var statemachine : state_machine

func _process(delta: float) -> void:
	text="an dusttale engine\nfps: " + str(Engine.get_frames_per_second())+ "
state: " + statemachine.current_state.name +"
hell idfk what i'm doing here"
