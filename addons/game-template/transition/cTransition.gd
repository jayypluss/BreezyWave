# Transitions.
# You can tweak transition speed and appearance, just make sure to
# update `is_displayed`.
class_name Transition
extends CanvasLayer

signal progress_bar_filled()
signal transition_started(anim_name)
signal transition_finished(anim_name)

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var progress = $ColorRect/Progress
@onready var spinner_anim: AnimationPlayer = $ColorRect/Progress/Spinner/AnimationPlayer


# Tells if transition is currently displayed
func is_displayed() -> bool:
	var is_screen_black = $ColorRect.modulate.a == 1
	return anim.is_playing() or is_screen_black


func is_transition_in_playing():
	return anim.current_animation == 'transition-in' and anim.is_playing()


# appear
func fade_in(params = {}):
	progress.hide()
	if params and params.get('show_progress_bar') != null:
		if params.get('show_progress_bar') == true:
			progress.show()
	anim.play("transition-in")
	spinner_anim.stop(true)
	spinner_anim.play("spinner")


# disappear
func fade_out():
	if progress.visible and not progress.is_completed():
		await self.progress_bar_filled
	anim.connect("animation_finished",Callable(self,"_on_fade_out_finished").bind(),CONNECT_ONE_SHOT)
	anim.play("transition-out")


func _on_fade_out_finished(cur_anim):
	if cur_anim == "transition-out":
		progress.bar.value = 0


# progress_ratio: value between 0 and 1
func _update_progress_bar(progress_ratio):
	var tween = get_tree().create_tween()
	if tween and tween.is_active():
		tween.stop_all() # stop previous animation
	tween.interpolate_property(
		progress.bar,
		"value",
		progress.bar.value,
		progress_ratio,
		1,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT,
		0
	)
	tween.start()
	if progress_ratio == 1:
		await tween.finished
		emit_signal("progress_bar_filled")


# called by the scene loader
func _on_resource_stage_loaded(stage: int, stages_amount: int):
	if progress.visible:
		var percentage = float(stage) / float(stages_amount)
		_update_progress_bar(percentage)
	else:
		pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "transition-out":
		emit_signal("transition_finished", anim_name)


func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "transition-in":
		emit_signal("transition_started", anim_name)

