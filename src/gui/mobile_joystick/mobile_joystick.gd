extends CanvasLayer

onready var right_joystick = $RightJoystick
onready var inner_circle = $InnerCircle

var move_vector = Vector2(0, 0)
var joystick_active = false

signal use_move_vector

#https://www.youtube.com/watch?v=_VXtUTwTxP0

func _ready():
    inner_circle.position.x = right_joystick.position.x + 80
    inner_circle.position.y = right_joystick.position.y + 80
    inner_circle.visible = false

func _input(event):
    if event is InputEventScreenTouch or event is InputEventScreenDrag:
        if right_joystick.is_pressed():
            move_vector = calculate_move_vector(event.position)
            joystick_active = true
            inner_circle.position = event.position
            inner_circle.visible = true
            
    if event is InputEventScreenTouch:
        if event.pressed == false:
            joystick_active = false
            inner_circle.visible = false
            
func _physics_process(_delta):
    if joystick_active:
        emit_signal("use_move_vector", move_vector)
            
func calculate_move_vector(event_position):
    var texture_center = right_joystick.position + Vector2(160, 160)
    return (event_position - texture_center).normalized()


func _on_RightJoystick_released():
    emit_signal("use_move_vector", Vector2.ZERO)
    joystick_active = false
