extends Control

const constant_utils = preload('res://script/util/constants.gd')

const NUMBER_OF_CASES = 12
const ANGLE_PER_CASES = 360.0 / 12
const SPINNING_WHEEL_STATE = {
  WAITING_FOR_PLAYER = 'WAITING_FOR_PLAYER',
  PLAYER_SPINNING = 'PLAYER_SPINNING',
  WAITING_FOR_SPINNING = 'WAITING_FOR_SPINNING',
  SPINNING_DONE = 'SPINNING_DONE'
}

var TRANSITIONS = {
  WAITING_FOR_PLAYER = [SPINNING_WHEEL_STATE.PLAYER_SPINNING],
  PLAYER_SPINNING = [SPINNING_WHEEL_STATE.WAITING_FOR_SPINNING],
  WAITING_FOR_SPINNING = [SPINNING_WHEEL_STATE.SPINNING_DONE],
  SPINNING_DONE = []
}

signal state_changed()

signal wheel_spinned(card_type)

var static_data = load('res://data/classic.gd').get_data()
var __current_state = SPINNING_WHEEL_STATE.WAITING_FOR_PLAYER
var __angular_velocity = 0.0
var __current_player
var __card_type

var __pin_original_position
var __pin_head_original_position
var __sprite_original_position

func _ready():
  __pin_original_position = $wheel/pin.position
  __pin_head_original_position = $wheel/pin/pinHead.position
  __sprite_original_position = $wheel/pin/triangle.position

  connect('state_changed', _update_label)
  _update_label()

func initialize(player_index):
  __angular_velocity = 0.0
  __current_player = player_index
  __current_state = SPINNING_WHEEL_STATE.WAITING_FOR_PLAYER

  # Reset pin position
  $wheel/pin.position = __pin_original_position
  $wheel/pin/pinHead.position = __pin_head_original_position
  $wheel/pin/triangle.position = __sprite_original_position

  _activate_wheel(true)
  _update_label()

func _activate_wheel(value):
  if value:
    $wheelAnimation.play('setup')

  else:
    $wheelAnimation.play_backwards('setup')

  set_process_input(value)
  _show_guirlande(value)

func _show_guirlande(value):
  for child_node in $guirlande.get_children():
    child_node.play_animation(value)

func next_state(value):
  if TRANSITIONS[__current_state].has(value):
    __current_state = value
    emit_signal('state_changed')

func _input(event):
  if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
    match __current_state:
      SPINNING_WHEEL_STATE.WAITING_FOR_PLAYER:
        if event.pressed:
          next_state(SPINNING_WHEEL_STATE.PLAYER_SPINNING)

      SPINNING_WHEEL_STATE.PLAYER_SPINNING:
        if not event.pressed:
          __angular_velocity = max(__angular_velocity, randf_range(0.25, 0.8))
          next_state(SPINNING_WHEEL_STATE.WAITING_FOR_SPINNING)

  elif event is InputEventMouseMotion and __current_state == SPINNING_WHEEL_STATE.PLAYER_SPINNING:
    var relative_rotation = event.relative.x / -500.0 if event.position.y >= (get_viewport().get_size().y / 2.0) else event.relative.x / 500.0

    if event.position.x >= (get_viewport().get_size().x / 2.0):
      relative_rotation += event.relative.y / 500.0

    else:
      relative_rotation += event.relative.y / -500.0

    __angular_velocity = relative_rotation
    $wheel/circles.rotate(relative_rotation)

func _physics_process(delta):
  if __current_state == SPINNING_WHEEL_STATE.WAITING_FOR_SPINNING:
    $wheel/circles.rotate(__angular_velocity)
    __angular_velocity -= __angular_velocity * delta

    if __angular_velocity < 0.0001:
      next_state(SPINNING_WHEEL_STATE.SPINNING_DONE)

func _update_label():
  match __current_state:
    SPINNING_WHEEL_STATE.WAITING_FOR_PLAYER:
      $result.set_text('Waiting for player to spin the fortune wheel')

    SPINNING_WHEEL_STATE.WAITING_FOR_SPINNING:
      $result.set_text('Waiting for the wheel to stop itself')

    SPINNING_WHEEL_STATE.PLAYER_SPINNING:
      $result.set_text('Player is spinning the fortune wheel')

    SPINNING_WHEEL_STATE.SPINNING_DONE:
      var computed_angle = int(rad2deg(($wheel/circles/wheel.global_rotation - ($wheel/circles/wheel.global_position.angle_to_point($wheel/pin/triangle/collision/sprite/anchor.global_position) + PI / 2.0)) + (2 * PI))) % 360
      var case_index = int(floor(computed_angle / ANGLE_PER_CASES))
      var case_data = static_data.wheel[case_index]

      $result.set_text('Spinning done... computing result: %s (%s)' % [
        static_data.wheel[case_index].type, case_index
      ])

      __card_type = case_data.type
      emit_signal('wheel_spinned', __card_type)
      _activate_wheel(false)

func get_card_type():
  return __card_type

func pick_random_card():
  return static_data.cards.random[randi_range(0, static_data.cards.random.size() - 1)]

func pick_anarchy_card():
  return static_data.cards.anarchy[randi_range(0, static_data.cards.anarchy.size() - 1)]
