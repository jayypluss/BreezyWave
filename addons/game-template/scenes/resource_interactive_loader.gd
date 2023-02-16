
# Transitions.
# You can tweak transition speed and appearance, just make sure to
# update `is_displayed`.
class_name ResourceInteractiveLoader
extends Node

signal resource_loaded(res)
signal resource_stage_loaded(current_stage, total_stages)

var _path
var _loader
var _current_stage = 0
var _resource: Resource
var _loader_status
var _stages_amount
var _elapsed = 0
const LOAD_STEP_DELAY = 2 # `_process` calls.
const MOCKED_STAGES_NUMBER = 1


func _ready() -> void:
	set_process(false)


func load_scene(p):
	_path = p
	_loader = ResourceLoader.load_threaded_request(_path)
	_loader_status = ResourceLoader.load_threaded_get_status(_path)
	set_process(true)
#	while _loader_status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
#		set_process(false)
	#	_stages_amount = float(_loader.get_stage_count())
		# set to fixed amount for new ResourceLoader doesn't have get_stage_count anymore
#		_stages_amount = MOCKED_STAGES_NUMBER
	#	set_process(true)


func _process(_delta: float):
	if _loader_status == ResourceLoader.THREAD_LOAD_FAILED or _loader_status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		print("Error while loading new scene.")
		_loader = null
		_loader_status = null
		_resource = null
		set_process(false)
		return
	elif _loader_status == ResourceLoader.THREAD_LOAD_LOADED:
		_resource = ResourceLoader.load_threaded_get(_path)
		
	if _resource:
		print ('resource lodaded')
		_on_background_loading_completed(_resource)
#	_elapsed += 1
#	if _elapsed >= LOAD_STEP_DELAY:
#		load_step()
#		_elapsed = 0


func load_step():
	print("RIL load_step")
	if _loader_status == null:
		return
	if _loader_status == ResourceLoader.THREAD_LOAD_LOADED or _loader_status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		_update_progress()
		_on_background_loading_completed(_resource)
		set_process(false)
		return
#	elif err == OK:
#		_update_progress()
	else: # Error during loading.
		print("Error while loading new scene.")
		_loader = null
		_loader_status = null
		_resource = null
		set_process(false)
		return


func _update_progress():
#	var stage = _loader.get_stage()
#	_stages_amount = _loader.get_stage_count()
	_stages_amount = MOCKED_STAGES_NUMBER
	emit_signal("resource_stage_loaded", _current_stage + 1, _stages_amount)


func _on_background_loading_completed(resource):
	emit_signal("resource_loaded", resource)
#	_current_stage += 1
	_loader = null
	_loader_status = null
	_resource = null
	set_process(false)
