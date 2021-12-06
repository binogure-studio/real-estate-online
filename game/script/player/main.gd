@tool
extends PathFollow3D

enum PLAYER_STATE {
  FREE,
  JAILED
}

const constant_utils = preload('res://script/util/constants.gd')
const number_utils = preload('res://script/util/number.gd')

const DICE_SCENE = preload('res://scene/dice/main.tscn')

const NUMBER_OF_CASES = 36.0
const ANIMATION_DURATION = 2.0
const PLAYER_POSITIONS = [
  Vector3(0.041, -0.002, -0.031),
  Vector3(0.158, -0.002, -0.045),
  Vector3(0.059, -0.002, 0.024),
  Vector3(0.172, -0.002, 0.015)
]

const PANEL_POSITIONS = [
  Vector2(0.0, 0.0),
  Vector2(1920 - 256, 0.0),
  Vector2(1920 - 256, 1080 - 96.0),
  Vector2(0.0, 1080 - 96.0)
]

var static_data = load('res://data/classic.gd').get_data()

@export var player_color : Color

signal player_end_of_turn(player_index)
signal player_bankrupt(player_index)
signal player_won(player_index)

signal player_play_case(player_index, case_number, callback)
signal player_jailed(player_index, callback)
signal player_in_jail(player_index, throw_dices, end_of_turn)

signal player_world_tour_ended(player_index)
signal currency_updated(currency)

var __name = 0
var __player_type = constant_utils.PLAYER_TYPE.HUMAN_LOCAL
var __player_state = PLAYER_STATE.FREE
var __number_of_turn = 0
var __currency = 200000
var __dice_threw = 0
var __turn_in_jail = 0

func _ready():
  var player_index = get_index()
  var standard_material = StandardMaterial3D.new()

  $origin.position = PLAYER_POSITIONS[player_index]
  $canvas/panel.rect_position = PANEL_POSITIONS[player_index]

  standard_material.albedo_color = player_color
  $origin/skeleton/mesh.set_surface_override_material(1, standard_material)

  $origin/skeleton/mesh/active.set_material_override(standard_material)
  $origin/skeleton/mesh/active.visible = false
  $canvas/panel/container/color.color = player_color

func set_player_data(player_data):
  __name = player_data.name
  __currency = player_data.currency

  $canvas/panel/container/container/name.set_text(player_data.name)
  $canvas/panel/container/container/currency.set_text(number_utils.format_currency(player_data.currency))

  if player_data.human and player_data.local:
    __player_type = constant_utils.PLAYER_TYPE.HUMAN_LOCAL

  elif player_data.human and not player_data.local:
    __player_type = constant_utils.PLAYER_TYPE.HUMAN_REMOTE

  elif not player_data.human and not player_data.local:
    __player_type = constant_utils.PLAYER_TYPE.COMPUTER_LOCAL

  elif not player_data.human and not player_data.local:
    __player_type = constant_utils.PLAYER_TYPE.COMPUTER_REMOTE

func begin_turn():
  __dice_threw += 1
  __turn_in_jail -= 1

  $origin/skeleton/mesh/active.visible = true

  if __dice_threw > static_data.number_of_double_before_jail:
    go_to_jail(_end_of_turn)

  elif is_player_in_jail():
    emit_signal('player_in_jail', get_index(), _throw_dice, _end_of_turn)

  else:
    _throw_dice()

func go_to_jail(callback):
  # Put player in jail
  __turn_in_jail = static_data.number_of_turn_in_prison
  __player_state = PLAYER_STATE.JAILED
  unit_offset = 9.0 / NUMBER_OF_CASES

  emit_signal('player_jailed', get_index(), callback)

func _throw_dice():
    # Instanciate dices
    # Change camera
    var dice_scene_instance = DICE_SCENE.instantiate()
    var root_node = get_tree().get_nodes_in_group('root_node')[0]

    dice_scene_instance.set_player_type(__player_type)
    dice_scene_instance.connect('throw_value', _dice_threw, [], CONNECT_ONESHOT)
    root_node.call_deferred('add_child', dice_scene_instance)

func get_turn_in_prison_left():
  return __turn_in_jail

func is_player_in_jail():
  return __player_state == PLAYER_STATE.JAILED

func free_player():
  __player_state = PLAYER_STATE.FREE
  __turn_in_jail = 0

func _dice_threw(dice_1, dice_2):
  var number_of_cases = dice_1 + dice_2

  if is_player_in_jail():
    if dice_1 == dice_2:
      # Free the player.
      free_player()
      _end_of_turn()

    else:
      __turn_in_jail -= 1
      _end_of_turn()
      # emit_signal('player_jailed', get_index(), _end_of_turn)

  else:

    var tween = create_tween()
    var to_case = unit_offset + number_of_cases / NUMBER_OF_CASES

    tween.set_parallel(true)
    tween.tween_property(self, 'unit_offset', to_case, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)

    if to_case >= 1.0:
      _world_tour_ended()

    if dice_1 == dice_2:
      tween.tween_callback(_play_case.bind(begin_turn)).set_delay(ANIMATION_DURATION * 2.0)

    else:
      tween.tween_callback(_play_case).set_delay(ANIMATION_DURATION * 2.0)

    tween.play()

func _world_tour_ended():
  emit_signal('player_world_tour_ended', get_index())
  __number_of_turn += 1

func player_move_to(case_number, callback):
  var computed_offset = case_number / NUMBER_OF_CASES

  if computed_offset < unit_offset:
    _world_tour_ended()

  unit_offset = computed_offset
  _play_case(callback)

func get_currency():
  return __currency

func update_currency(costs):
  __currency -= costs
  $canvas/panel/container/container/currency.set_text(number_utils.format_currency(__currency))

  emit_signal('currency_updated', __currency)

func get_number_of_turn():
  return __number_of_turn

func _play_case(callback = _end_of_turn):
  var case_number = int(round(unit_offset * NUMBER_OF_CASES))

  emit_signal('player_play_case', get_index(), case_number, callback)

func _end_of_turn():
  # TODO
  # Not yet implemented
  emit_signal('player_end_of_turn', get_index())

  __dice_threw = 0
  $origin/skeleton/mesh/active.visible = false

func get_player_color():
  return player_color
