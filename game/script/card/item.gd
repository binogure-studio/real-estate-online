extends PathFollow2D

const common_colors_util = preload('res://script/util/common-colors.gd')
const constant_utils = preload('res://script/util/constants.gd')
const number_utils = preload('res://script/util/number.gd')
const signal_utils = preload('res://script/util/signal.gd')

var static_data = load('res://data/classic.gd').get_data()

var _CARD_THEME = [{
  sprite = load('res://assets/theme/icon/card-random-407x512.png'),
  description_color = common_colors_util.DARK_YELLOW_COLOR,
  title_color = common_colors_util.DARK_YELLOW_COLOR
}, {
  sprite = load('res://assets/theme/icon/card-anarchy-407x512.png'),
  description_color = common_colors_util.DARK_RED_COLOR,
  title_color = common_colors_util.ULTRA_LIGHT_RED_COLOR
}]

enum BUTTON_STATE {
  IDLE,
  HOVERED,
  PRESSED
}

const ANIMATION_DURATION = 0.334

signal card_selected(card_node)
signal card_played(card_node, callback)

var __card_type = constant_utils.CARD_TYPE.RANDOM
var __initialized = false
var __state = BUTTON_STATE.PRESSED
var __data
var __player_node
var __number_of_card = 0
var __hovered = false
var __original_z_index = 0

var __linked_case_index = constant_utils.INVALID_CASE_ID
var __linked_player_index = constant_utils.BANK_ID
var __linked_side_index = constant_utils.INVALID_CASE_ID

func _ready():
  $sprite/button.pressed = true
  __original_z_index = z_index

  _initialize()
  _connect_signals()

func _disconnect_signals():
  signal_utils.disconnect_all($sprite/button, 'mouse_entered')
  signal_utils.disconnect_all($sprite/button, 'mouse_exited')
  signal_utils.disconnect_all($sprite/button, 'toggled')

func _connect_signals():
  _disconnect_signals()

  $sprite/button.connect('mouse_entered', _update_is_hovered, [true])
  $sprite/button.connect('mouse_exited', _update_is_hovered, [false])
  $sprite/button.connect('toggled', _update_state)

func _update_is_hovered(value):
  __hovered = value

  _update_state()

func set_player_node(player_node):
  __player_node = player_node

func set_data(card_type, data):
  __data = data
  __card_type = card_type

  if is_inside_tree():
    _initialize()

func get_data():
  return __data

func _initialize():
  # Guardian clause
  if __data == null or __initialized:
    logger.debug('Cannot initialize card node: %s / %s', [__data, __initialized])
    return

  __initialized = true

  var card_theme = _CARD_THEME[__card_type]
  var card_description = tr(__data.description)
  var card_filters = _compute_card_filters()

  if __data.effects.has('currency'):
    card_description = card_description % [
      number_utils.format(__data.effects.currency)
    ]

  elif __data.effects.has('move_player'):
    card_description = card_description % [
      abs(__data.effects.move_player)
    ]

  elif __data.effects.has('turn_with_no_rent_on_case'):
    # Pick owned case name (random pick)
    __linked_case_index = __player_node.pick_random_case(card_filters.case, card_filters.player, card_filters.house)

    var case_name = tr(static_data.cases[__linked_case_index].name) if __linked_case_index > constant_utils.INVALID_CASE_ID else '-'

    card_description = card_description % [
      case_name, abs(__data.effects.turn_with_no_rent_on_case)
    ]

  elif __data.effects.has('turn_with_pandemie'):
    card_description = card_description % [
      abs(__data.effects.turn_with_pandemie)
    ]

  elif __data.effects.has('taxes_mode') and __data.effects.taxes_mode == 1:
    card_description = card_description % [
      number_utils.format(static_data.taxes_mode[1].costs)
    ]

  elif __data.effects.has('to_jail'):
    card_description = card_description % [
      __player_node.pick_random_player_name(),
      number_utils.format(static_data.world_tour_salary)
    ]

  elif __data.effects.has('case_index'):
    var case_name = tr(static_data.cases[__data.effects.case_index].name)

    card_description = card_description % [
      case_name
    ]

  $sprite.texture = card_theme.sprite

  $sprite/title.text = tr(__data.title)
  $sprite/title.set('theme_override_colors/font_color', card_theme.title_color)

  $sprite/effect.text = card_description
  $sprite/effect.set('theme_override_colors/default_color', card_theme.description_color)

func _compute_card_filters():
  var case_filter = constant_utils.NO_FILTER
  var player_filter = constant_utils.NO_FILTER
  var house_action = constant_utils.HOUSE_ACTION.NO_ACTION
  var card_action = constant_utils.ACTION_TYPE.SELECT_NOTHING

  if __data.effects.has('protect_case') or __data.effects.has('turn_with_no_rent_on_case'):
    case_filter = constant_utils.CASE_TYPE.WONDER | constant_utils.CASE_TYPE.PROPERTY
    player_filter = constant_utils.PLAYER_TYPE.OWNED_BY_PLAYER
    card_action = constant_utils.ACTION_TYPE.SELECT_CASE

  elif __data.effects.has('festival'):
    case_filter = constant_utils.CASE_TYPE.WONDER | constant_utils.CASE_TYPE.PROPERTY
    player_filter = constant_utils.PLAYER_TYPE.OWNED_BY_PLAYER | constant_utils.PLAYER_TYPE.NO_OWNER
    card_action = constant_utils.ACTION_TYPE.SELECT_CASE

  elif __data.effects.has('house_bonus'):
    case_filter = constant_utils.CASE_TYPE.PROPERTY
    player_filter = constant_utils.PLAYER_TYPE.OWNED_BY_PLAYER
    house_action = constant_utils.HOUSE_ACTION.BUILD_HOUSE
    card_action = constant_utils.ACTION_TYPE.SELECT_CASE

  elif __data.effects.has('steal_card') or (__card_type == constant_utils.CARD_TYPE.ANARCHY and \
      (__data.effects.has('taxes_mode') or __data.effects.has('currency_loss_ratio'))):
    card_action = constant_utils.ACTION_TYPE.SELECT_PLAYER
    player_filter = constant_utils.PLAYER_TYPE.OWNED_BY_ANOTHER_PLAYER

  elif __data.effects.has('side_no_renter'):
    card_action = constant_utils.ACTION_TYPE.SELECT_SIDE

  elif __data.effects.has('free_wonder'):
    case_filter = constant_utils.CASE_TYPE.WONDER
    card_action = constant_utils.ACTION_TYPE.SELECT_CASE

  elif __data.effects.has('free_property'):
    case_filter = constant_utils.CASE_TYPE.WONDER | constant_utils.CASE_TYPE.PROPERTY
    card_action = constant_utils.ACTION_TYPE.SELECT_CASE

  elif __data.effects.has('free_house'):
    case_filter = constant_utils.CASE_TYPE.PROPERTY
    house_action = constant_utils.HOUSE_ACTION.FREE_HOUSE
    card_action = constant_utils.ACTION_TYPE.SELECT_CASE

  return {
    action = card_action,
    case = case_filter,
    player = player_filter,
    house = house_action
  }

func _case_selected():
  pass

func play_card(callback):
  # Note:
  # So the button is no more active, if the player can
  # cancel his/her action then we can plug the signals back using
  # the _connect_signals() function.
  _disconnect_signals()

  var card_filters = _compute_card_filters()

  if not __player_node.apply_card_filters(card_filters, _card_played.bind(card_filters.action, callback)):
    # TODO
    # Burn the card
    # Card is not playable
    emit_signal('card_played', self, callback)

func _apply_on_nothing(callback):
  var function_list = []

  if __data.effects.has('cancel_olympics'):
    function_list.push_back([__player_node.organize_olympics, [null]])

  if __data.effects.has('currency_loss_ratio'):
    var costs = __player_node.get_currency() * __data.effects.currency_loss_ratio

    function_list.push_back([__player_node.set_currency, [constant_utils.BANK_ID, -costs]])

  if __data.effects.has('taxes_mode'):
    function_list.push_back([__player_node.set_taxe_mode, [__data.effects.taxes_mode]])

  if __data.effects.has('to_jail'):
    function_list.push_back([__player_node.go_to_jail])

  if __data.effects.has('free_jail'):
    function_list.push_back([__player_node.free_player])

  if __data.effects.has('move_player'):
    function_list.push_back([__player_node.player_move_to, [__player_node.get_case_index() + __data.effects.move_player]])

  if __data.effects.has('currency'):
    function_list.push_back([__player_node.set_currency, [constant_utils.BANK_ID, __data.effects.currency]])

  if __data.effects.has('case_index'):
    function_list.push_back([__player_node.player_move_to, [__data.effects.case_index]])

  if __data.effects.has('next_rent_canceled'):
    function_list.push_back([__player_node.inc_number_of_canceled_rent, [__data.effects.next_rent_canceled]])

  if __data.effects.has('turn_with_pandemie'):
    function_list.push_back([__player_node.inc_turn_with_pandemie, [__data.effects.turn_with_pandemie]])

  async.series(function_list, callback)

func _apply_on_side(case_node_list, callback):
  var function_list = []

  if __data.effects.has('side_no_rent'):
    var no_rent_in_case = __data.effects.side_no_rent

    for case_node in case_node_list:
      function_list.push_back([case_node.inc_turn_with_no_rent, [no_rent_in_case]])

  async.series(function_list, callback)

func _apply_on_case(case_node, callback):
  var function_list = []

  if __data.effects.has('protect_case'):
    function_list.push_back([case_node.protect_case])

  if __data.effects.has('turn_with_no_rent_on_case'):
    function_list.push_back([case_node.inc_turn_with_no_rent, [__data.effects.turn_with_no_rent_on_case]])

  if __data.effects.has('festival'):
    pass

  if __data.effects.has('house_bonus'):
    function_list.push_back([case_node.inc_number_of_house, [__data.effects.house_bonus]])

  if __data.effects.has('free_wonder') or __data.effects.has('free_property'):
    function_list.push_back([case_node.free_property])

  if __data.effects.has('free_house'):
    function_list.push_back([case_node.inc_number_of_house, [-__data.effects.free_house]])

  if __data.effects.has('currency'):
    function_list.push_back([__player_node.set_currency, [constant_utils.BANK_ID, __data.effects.currency]])

  async.series(function_list, callback)

func _apply_on_player(player_node, callback):
  if __data.effects.has('steal_card'):
    function_list.push_back([player_node.steal_card, [player_node.get_index()]])

  if __data.effects.has('currency_loss_ratio'):
    var costs = player_node.get_currency() * __data.effects.currency_loss_ratio

    function_list.push_back([player_node.set_currency, [constant_utils.BANK_ID, -costs]])

  if __data.effects.has('taxes_mode'):
    function_list.push_back([player_node.set_taxe_mode, [__data.effects.taxes_mode]])

  async.series(function_list, callback)

func _card_played(selected_item, action_type, callback):
  # Note:
  # selected_item depends on the action_type.
  # It can be a player node, a case node, or a even a case list
  match action_type:
    constant_utils.ACTION_TYPE.SELECT_NOTHING:
      _apply_on_nothing(_card_played_emit_signal.bind(callback))

    constant_utils.ACTION_TYPE.SELECT_SIDE:
      _apply_on_side(selected_item, _card_played_emit_signal.bind(callback))

    constant_utils.ACTION_TYPE.SELECT_CASE:
      _apply_on_case(selected_item, _card_played_emit_signal.bind(callback))

    constant_utils.ACTION_TYPE.SELECT_PLAYER:
      _apply_on_player(selected_item, _card_played_emit_signal.bind(callback))

func _card_played_emit_signal(callback):
  emit_signal('card_played', self, callback)

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
  __tween.chain().tween_callback(_update_visual)

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
  $sprite/button.pressed = false

  _update_state()

func _emit_signals():
  if __state == BUTTON_STATE.PRESSED:
    emit_signal('card_selected', self)

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
      z_index = __original_z_index

func get_linked_player_index():
  return __linked_player_index

func get_linked_case_index():
  return __linked_case_index

func get_linked_side_index():
  return __linked_side_index
