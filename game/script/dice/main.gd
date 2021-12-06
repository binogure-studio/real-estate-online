extends Node3D

const constant_utils = preload('res://script/util/constants.gd')

const DICE_THROW_DURATION = 2.0
const ANIMATION_DURATION = 0.667
const DEFAULT_CAMERA_DATA = {
  fov = 75.0,
  near = 0.05,
  far = 4000.0,
  position = Vector3(0.4134860038757324, 1.420259952545166, 0.3139640092849731),
  rotation = Vector3(deg2rad(-74.5), deg2rad(52.3), deg2rad(5))
}

const DICE_CAMERA_DATA = {
  fov = 35.0,
  near = 0.05,
  far = 4000.0,
  position = Vector3(0.0081785898655653, 1.7606600522994995, 0.2201520055532455),
  rotation = Vector3(deg2rad(-81.4), deg2rad(0), deg2rad(15))
}

const BOUNDING_BOX = 0.20
const THROW_FORCE = 1.0

@onready var dice_nodes = [get_node('0'), get_node('1')]
@onready var rotating_node = get_tree().get_nodes_in_group('rotating_node')[0]

var rng = RandomNumberGenerator.new()

var __retry = 2
var __dice_holder_freed = false
var __tutoriel_freed = false
var __catch_event = false
var __movement = Vector3(0.0, 0.0, 0.0)
var __board_camera
var __player_type
var __delta_acc = 0.0

signal throw_value(dice_1, dice_2)

func _ready():
  __board_camera = get_viewport().get_camera_3d()
  rotating_node.lock_rotation()

  roll_dices()
  set_process(false)
  set_process_unhandled_input(true)

func _exit_tree():
  rotating_node.unlock_rotation()

func _process(delta):
  __delta_acc += delta

  if __delta_acc > DICE_THROW_DURATION:
    if dice_nodes[0].is_entity_moving() or dice_nodes[1].is_entity_moving() or \
      dice_nodes[0].is_dice_broken() or dice_nodes[1].is_dice_broken():
      __delta_acc = 0.0

      if __retry > 0:
        __retry -= 1

      else:
        _reset_moving_dices()
        _reset_broken_dices()

        __retry = 2

    else:
      set_process(false)
      _dice_threw()

func _reset_moving_dices():
  for node in dice_nodes:
    if node.is_entity_moving():
      logger.debug('Dice still moving, resetting position')
      node.reset_dice()

func _reset_broken_dices():
  for node in dice_nodes:
    if node.is_dice_broken():
      logger.debug('Dice broken, resetting position')
      node.reset_dice()

func _dice_threw():
  var tween = create_tween()

  tween.set_parallel(true)
  tween.tween_property(__board_camera, 'fov', DEFAULT_CAMERA_DATA.fov, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)
  tween.tween_property(__board_camera, 'near', DEFAULT_CAMERA_DATA.near, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)
  tween.tween_property(__board_camera, 'far', DEFAULT_CAMERA_DATA.far, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)
  tween.tween_property(__board_camera, 'position', DEFAULT_CAMERA_DATA.position, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)
  tween.tween_property(__board_camera, 'rotation', DEFAULT_CAMERA_DATA.rotation, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)
  tween.play()

  # Note:
  # Ensure we are on the right camera before emitting any signal
  # Free the current dice since they are already been threw
  connect('tree_exited', emit_signal, ['throw_value', 4, 2], CONNECT_ONESHOT)
  # connect('tree_exited', emit_signal, ['throw_value', get_node('0').get_value(), get_node('1').get_value()], CONNECT_ONESHOT)
  tween.tween_callback(queue_free).set_delay(DICE_THROW_DURATION)

  for node in dice_nodes:
    node.stop_dice()

func _physics_process(delta):
  if __catch_event:
    $diceHolder.position += delta * __movement * Vector3(1.0, 0.0, 1.0)

    $diceHolder.position.x = clamp($diceHolder.position.x, -BOUNDING_BOX, BOUNDING_BOX)
    $diceHolder.position.z = clamp($diceHolder.position.z, -BOUNDING_BOX, BOUNDING_BOX)

    __movement = Vector3(0.0, 0.0, 0.0)

func __free_dice_holder():
  if not __dice_holder_freed:
    __dice_holder_freed = true
    __catch_event = false

    set_process_unhandled_input(false)
    set_process(true)
    $diceHolder.queue_free()

func __free_tutoriel():
  if not __tutoriel_freed:
    __tutoriel_freed = true

    $tutoriel.queue_free()

func _unhandled_input(event):
  if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
    if __catch_event and not event.pressed:
      get_node('0').angular_velocity.x = rng.randf_range(-PI, PI) * 2.0
      get_node('0').angular_velocity.y = rng.randf_range(-PI, PI) * 2.0
      get_node('0').angular_velocity.z = rng.randf_range(-PI, PI) * 2.0

      get_node('1').angular_velocity.x = rng.randf_range(-PI, PI) * 2.0
      get_node('1').angular_velocity.y = rng.randf_range(-PI, PI) * 2.0
      get_node('1').angular_velocity.z = rng.randf_range(-PI, PI) * 2.0

      get_node('0').linear_velocity.x = rng.randf_range(-THROW_FORCE, THROW_FORCE)
      get_node('0').linear_velocity.z = rng.randf_range(-THROW_FORCE, THROW_FORCE)

      get_node('1').linear_velocity.x = rng.randf_range(-THROW_FORCE, THROW_FORCE)
      get_node('1').linear_velocity.z = rng.randf_range(-THROW_FORCE, THROW_FORCE)

      __free_dice_holder()

    else:
      __catch_event = event.pressed
      __free_tutoriel()

    # get_tree().set_input_as_handled()

  elif event is InputEventMouseMotion and __catch_event:
    __movement.x += event.relative.x
    __movement.z += event.relative.y

    __movement.x = clamp(__movement.x, -THROW_FORCE, THROW_FORCE)
    __movement.z = clamp(__movement.z, -THROW_FORCE, THROW_FORCE)

func set_player_type(player_type):
  __player_type = player_type

func roll_dices():
  if constant_utils.PLAYER_TYPE.HUMAN_LOCAL == __player_type:
    var tween = create_tween()

    tween.set_parallel(true)
    tween.tween_property(__board_camera, 'fov', DICE_CAMERA_DATA.fov, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)
    tween.tween_property(__board_camera, 'near', DICE_CAMERA_DATA.near, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)
    tween.tween_property(__board_camera, 'far', DICE_CAMERA_DATA.far, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)
    tween.tween_property(__board_camera, 'position', DICE_CAMERA_DATA.position, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)
    tween.tween_property(__board_camera, 'rotation', DICE_CAMERA_DATA.rotation, ANIMATION_DURATION).set_trans(Tween.TRANS_SINE)

    tween.play()

  else:
    # TODO
    # Not yet implemented
    logger.warning('Not yet implemented')
