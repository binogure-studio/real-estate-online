extends Object
# To import this script
# const signal_utils = preload('res://script/util/signal.gd')

static func disconnect_all(node, signal_name):
  for connection_item in node.get_signal_connection_list(signal_name):
    node.disconnect(signal_name, connection_item.callable)
