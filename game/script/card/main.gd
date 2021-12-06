@tool
extends Control

const CARD_SCENE = preload('res://scene/card/item.tscn')

var __selected_card = null

func _ready():
  $button.connect('pressed', add_card, [{}])

func add_card(card_data):
  var card_scene_instance = CARD_SCENE.instantiate()

  card_scene_instance.set_data(card_data)
  card_scene_instance.connect('card_selected', _card_selected, [card_scene_instance], CONNECT_DEFERRED)

  card_scene_instance.connect('tree_exited', _update_hand, [], CONNECT_DEFERRED | CONNECT_ONESHOT)
  card_scene_instance.connect('tree_entered', _update_hand, [], CONNECT_DEFERRED | CONNECT_ONESHOT)
  $hand.call_deferred('add_child', card_scene_instance)

func _update_hand():
  var number_of_children = $hand.get_child_count()

  for card_node in $hand.get_children():
    card_node.set_number_of_card(number_of_children)

func _card_selected(card_node):
  if __selected_card != null and __selected_card != card_node:
    __selected_card.release_card()

  __selected_card = card_node
