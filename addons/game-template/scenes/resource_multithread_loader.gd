extends Node

signal resource_loaded(res)
signal resource_stage_loaded(current_stage, total_stages)

const SIMULATED_DELAY_MS = 32 # ms

var thread: Thread = null
var stages_amount: int


func _ready() -> void:
	thread = Thread.new()


func load_scene(path):
	var state = thread.start(Callable(self,"_thread_load").bind(path))
	if state != OK:
		print("Error while starting thread: " + str(state))


func _thread_load(path):
	var requestErr = ResourceLoader.load_threaded_request(path, '', true)
	while true:
		OS.delay_msec(SIMULATED_DELAY_MS)
		var status = ResourceLoader.load_threaded_get_status(path)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			break
		if status == ResourceLoader.THREAD_LOAD_FAILED:
			print("There was an error loading resource for path: ", path)
			break

	var res = ResourceLoader.load_threaded_get(path)
	res.set_meta('path', path)
	call_deferred("_thread_done", res)


func _thread_done(resource):
	assert(resource)
	# Always wait for threads to finish, this is required checked Windows.
	thread.wait_to_finish()
	emit_signal("resource_stage_loaded", stages_amount, stages_amount)
	# Instantiate new scene.
	emit_signal("resource_loaded", resource)


func _exit_tree() -> void:
	if thread and thread.is_alive():
		thread.wait_to_finish()
