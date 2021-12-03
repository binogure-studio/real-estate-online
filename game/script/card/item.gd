extends PathFollow2D

const ANIMATION_DURATION = 0.334

var __data
var __number_of_card = 0

func _ready():
  $sprite/button.connect('mouse_entered', _card_hovered, [true])
  $sprite/button.connect('mouse_exited', _card_hovered, [false])

  _initialize()

func set_data(data):
  __data = data

  if is_inside_tree():
    _initialize()

func _initialize():
  # Guardian clause
  if __data == null:
    return

  # TODO
  logger.debug('Not yet implemented')

func _card_hovered(is_hover):
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
