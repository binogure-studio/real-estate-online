extends Sprite2D

func play_animation(show_lightbulb):
  var from_position = get_position()
  var to_position = Vector2(from_position.x, 76.0) if show_lightbulb else Vector2(from_position.x, -96.0)
  var node_index = get_index()

  var tween = create_tween()
  var animation_duration = randf_range(0.0, 0.5) + (sqrt(node_index)) / 10.0

  tween.set_parallel(true)
  tween.tween_property(self, 'position', to_position, animation_duration).set_trans(Tween.TRANS_SINE)

  if show_lightbulb:
    $light.set_energy(0.0)
    tween.tween_method($light.set_energy, 0.0, 1.0, animation_duration).set_trans(Tween.TRANS_BACK).set_delay(animation_duration)

    if randf() > 0.5:
      tween.tween_method($light.set_energy, 1.0, 0.5, animation_duration).set_trans(Tween.TRANS_BACK).set_delay(animation_duration * 2.0)
      tween.tween_method($light.set_energy, 0.5, 1.0, animation_duration).set_trans(Tween.TRANS_BACK).set_delay(animation_duration * 3.0)

  tween.play()
