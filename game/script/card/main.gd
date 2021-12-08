extends Control

const ANIMATION_DURATION = 0.334
const CARD_SCENE = preload('res://scene/card/item.tscn')

const signal_utils = preload('res://script/util/signal.gd')

@export var player_node_path : NodePath
@onready var player_node = get_node(player_node_path)

var __selected_card = null

signal done()
signal play_card(card_node, card_data)

func show_hand(value):
  if value:
    $animation.play('setup')

  else:
    $animation.play_backwards('setup')

func add_card(card_to_play, card_type, card_data, callback):
  signal_utils.disconnect_all($animation, 'animation_finished')

  $animation.connect('animation_finished', _add_card, [card_to_play, card_type, card_data, callback], CONNECT_ONESHOT)

  $action.visible = true
  show_hand(true)

func _add_card(_unused_1, card_to_play, card_type, card_data, callback):
  # Note
  # We need to release all the existing cards
  for child_node in $hand.get_children():
    child_node.release_card()

  var card_scene_instance = CARD_SCENE.instantiate()

  card_scene_instance.set_data(card_type, card_data)
  card_scene_instance.set_player_node(player_node)

  card_scene_instance.connect('card_selected', _card_selected, [], CONNECT_DEFERRED)
  card_scene_instance.connect('card_played', _card_played, [], CONNECT_DEFERRED)

  card_scene_instance.connect('tree_exited', _update_hand, [], CONNECT_DEFERRED | CONNECT_ONESHOT)
  card_scene_instance.connect('tree_entered', _update_hand, [], CONNECT_DEFERRED | CONNECT_ONESHOT)
  $hand.call_deferred('add_child', card_scene_instance)

  signal_utils.disconnect_all($action/play, 'pressed')
  signal_utils.disconnect_all($action/close, 'pressed')

  $action/close.visible = not card_to_play
  $action/play.visible = card_to_play

  if card_to_play:
    $action/play.connect('pressed', _play_card, [card_scene_instance, callback], CONNECT_ONESHOT)

  else:
    $action/close.connect('pressed', _done, [callback], CONNECT_ONESHOT)

func _play_card(card_to_play, callback):
  # Always hide the close button
  $action.visible = false
  mouse_filter = MOUSE_FILTER_IGNORE

  $animation.play_backwards('showhand')
  card_to_play.play_card(callback)

func _done(callback):
  # Always hide the close button
  mouse_filter = MOUSE_FILTER_STOP
  $action.visible = false

  show_hand(false)
  callback.call()

func _update_hand():
  var number_of_children = $hand.get_child_count()

  for card_node in $hand.get_children():
    card_node.set_number_of_card(number_of_children)

func _card_played(card_node, callback):
  # So we hide properly the hand
  $animation.play('RESET')

  # TODO
  # Improve card animation
  card_node.queue_free()
  callback.call()

func _card_selected(card_node):
  if __selected_card != null and __selected_card != card_node:
    __selected_card.release_card()

  __selected_card = card_node

func get_number_of_cards():
  return $hand.get_child_count()

func list_card_nodes():
  return $hand.get_children()

func is_there_a_playable_card():
  return false
