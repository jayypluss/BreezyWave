extends Node3D

# This level has 156 stars	

#@onready var player : Player = $Player
#@onready var win_game_screen : CanvasLayer = $GlobalLevelsScreens/WinGameScreen
#@onready var game_over_screen : CanvasLayer= $GlobalLevelsScreens/GameOverScreen
#@onready var music : AudioStreamPlayer = $Music
#@onready var moving_platform_1 : Node3D = $Interactables/MovingPlatform1
#@onready var moving_platform_2 : Node3D = $Interactables/MovingPlatformAbs
#@onready var secret_passage_platform_1 : CharacterBody3D = $Interactables/SecretPassagePlatform1

#var has_activate_secret_passage_1 = false


func _ready():
	GameState.current_level_name = self.name
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
