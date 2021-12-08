extends Node

func series(function_list, callback):
  if function_list.size() > 0:
    var function_data = function_list.pop_front()

    # Match the function's signature
    match function_data[1].size():
      1:
        return function_data[0].call(function_data[1][0], series.bind(function_list, callback))

      2:
        return function_data[0].call(function_data[1][0], function_data[1][1], series.bind(function_list, callback))

      3:
        return function_data[0].call(function_data[1][0], function_data[1][1], function_data[1][2], series.bind(function_list, callback))

      4:
        return function_data[0].call(function_data[1][0], function_data[1][1], function_data[1][2], function_data[1][3], series.bind(function_list, callback))

      5:
        return function_data[0].call(function_data[1][0], function_data[1][1], function_data[1][2], function_data[1][3], function_data[1][4], series.bind(function_list, callback))

      6:
        return function_data[0].call(function_data[1][0], function_data[1][1], function_data[1][2], function_data[1][3], function_data[1][4], function_data[1][5], series.bind(function_list, callback))

      7:
        return function_data[0].call(function_data[1][0], function_data[1][1], function_data[1][2], function_data[1][3], function_data[1][4], function_data[1][5], function_data[1][6], series.bind(function_list, callback))

      8:
        return function_data[0].call(function_data[1][0], function_data[1][1], function_data[1][2], function_data[1][3], function_data[1][4], function_data[1][5], function_data[1][6], function_data[1][7], series.bind(function_list, callback))

  return callback.call()
