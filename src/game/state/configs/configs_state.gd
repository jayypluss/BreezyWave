extends Node


var audio_configs : Dictionary = {
	"master_volume": 100
}

func _ready():
	restore()

func persist():
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	# Store some values.
	config.set_value("Configs", "audio_configs", audio_configs)

	# Save it to a file (overwrite if already exists).
	config.save("user://configs.cfg")
	print("saved config: ", config)


func restore():
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://configs.cfg")

	# If the file didn't load, ignore it.
	if err != OK:
		return

	# Iterate over all sections.
	for section in config.get_sections():
		# Fetch the data for each section.
		var master_volume = config.get_value(section, "audio_configs")
		
		audio_configs[master_volume] = master_volume
		
	print("restored config: ", config)
	print("audio_configs: ", audio_configs)
