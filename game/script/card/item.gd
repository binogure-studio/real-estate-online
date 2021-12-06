extends PathFollow2D

enum BUTTON_STATE {
  IDLE,
  HOVERED,
  PRESSED
}

const ANIMATION_DURATION = 0.334

signal card_selected()

var __state = BUTTON_STATE.IDLE
var __data
var __number_of_card = 0
var __hovered = false

func _ready():
  $sprite/button.connect('mouse_entered', _update_is_hovered, [true])
  $sprite/button.connect('mouse_exited', _update_is_hovered, [false])
  $sprite/button.connect('toggled', _update_state)

  _initialize()

func _update_is_hovered(value):
  __hovered = value

  _update_state()

func set_data(data):
  __data = data

  if is_inside_tree():
    _initialize()

func get_data():
  return __data

func _initialize():
  # Guardian clause
  if __data == null:
    return

  # TODO
  logger.debug('Not yet implemented')

func set_number_of_card(value):
  __number_of_card = value
  _update_position()

func _update_position():
  if __number_of_card < 1:
    logger.error('Invalid number of cards: %s', [__number_of_card])
    return

  var computed_unit_offset = (1.0 / (__number_of_card + 1)) * (get_index() + 1)
  var __tween = create_tween()

  __tween.set_parallel(true)
  __tween.tween_property(self, 'unit_offset', computed_unit_offset, ANIMATION_DURATION).set_trans(Tween.TRANS_QUAD)

  _update_visual()

func _update_state(arg0 = null):
  var previous_state = __state

  if $sprite/button.is_pressed():
    __state = BUTTON_STATE.PRESSED

  elif __hovered:
    __state = BUTTON_STATE.HOVERED

  else:
    __state = BUTTON_STATE.IDLE

  if previous_state != __state:
    logger.debug('(%s) Button state: %s (frame: %s)', [get_index(), __state, Engine.get_frames_drawn()])

    _update_visual()
    _emit_signals()

func release_card():
  $sprite/button.set_pressed(false)
  _update_state()

func _emit_signals():
  if __state == BUTTON_STATE.PRESSED:
    emit_signal('card_selected')

func _update_visual():
  var __tween = create_tween()

  __tween.set_parallel(true)

  match __state:
    BUTTON_STATE.PRESSED:
      var to_position = Vector2(1920 / 2.0, 1080 / 2.0) - global_position

      __tween.tween_property($sprite, 'rotation', get_rotation() * -1.0, ANIMATION_DURATION).set_trans(Tween.TRANS_QUAD)
      __tween.tween_property($sprite, 'position', to_position, ANIMATION_DURATION).set_trans(Tween.TRANS_QUAD)

      z_index = 128

    BUTTON_STATE.HOVERED:

      __tween.tween_property($sprite, 'rotation', get_rotation() * -1.0, ANIMATION_DURATION).set_trans(Tween.TRANS_QUAD)
      __tween.tween_property($sprite, 'position', Vector2(0, -64), ANIMATION_DURATION).set_trans(Tween.TRANS_QUAD)
      z_index = 128

    BUTTON_STATE.IDLE:

      __tween.tween_property($sprite, 'rotation', 0.0, ANIMATION_DURATION).set_trans(Tween.TRANS_QUAD)
      __tween.tween_property($sprite, 'position', Vector2(0, 0), ANIMATION_DURATION).set_trans(Tween.TRANS_QUAD)
      z_index = get_index()
