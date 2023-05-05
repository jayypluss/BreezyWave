extends Control
class_name GlobalLevelsScreens

@onready var pause_screen = $PauseScreen
@onready var game_over_screen = $GameOverScreen
@onready var win_game_screen = $WinGameScreen
@onready var level_name_indicator: LevelNameIndicator = $LevelNameIndicator

func _ready():
	GameState.global_levels_screens = self
	level_name_indicator.present_level_name()
