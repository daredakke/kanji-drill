class_name Settings
extends Control


signal settings_closed

var _master_bus: int = AudioServer.get_bus_index("Master")

@onready var close_button: Button = %CloseButton
@onready var sfx_value: Label = %SFXValue
@onready var sfx_slider: HSlider = %SFXSlider
@onready var fullscreen_check_box: CheckBox = %FullscreenCheckBox
@onready var dark_mode_check_box: CheckBox = %DarkModeCheckBox
@onready var pause_check_box: CheckBox = %PauseCheckBox


func _ready() -> void:
	hide()
	
	close_button.pressed.connect(_on_settings_closed)
	sfx_slider.value_changed.connect(_on_music_slider_value_changed)
	fullscreen_check_box.toggled.connect(_on_toggle_fullscreen)


func focus_menu() -> void:
	show()
	sfx_slider.grab_focus()


func _on_settings_closed() -> void:
	hide()
	settings_closed.emit()


func _on_music_slider_value_changed(value: float) -> void:
	sfx_value.text = "(" + str(floor(value * 100)) + "%)"

	AudioServer.set_bus_volume_db(_master_bus, linear_to_db(value))
	AudioServer.set_bus_mute(_master_bus, value < 0.05)


func _on_toggle_fullscreen(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		ProjectSettings.set_setting("display/window/size/borderless", false)
		get_window().move_to_center()
