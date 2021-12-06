const constant_utils = preload('res://script/util/constants.gd')
const common_colors_util = preload('res://script/util/common-colors.gd')

static func get_data():
  return {
    currency = 200000,
    world_tour_salary = 20000,
    number_of_cases = 36,
    number_of_double_before_jail = 3,
    number_of_turn_in_prison = 4,
    prison_costs = 5000,

    cards = {
      anarchy = [{
        title = 'LABEL_CARD_ANARCHY_0_TITLE',
        description = 'LABEL_CARD_ANARCHY_0_DESCRIPTION',
        effects = [{
          house = -1
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_1_TITLE',
        description = 'LABEL_CARD_ANARCHY_1_DESCRIPTION',
        effects = [{
          currency = -50000,
          free_property = 1
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_2_TITLE',
        description = 'LABEL_CARD_ANARCHY_2_DESCRIPTION',
        effects = [{
          steal_card = 1
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_3_TITLE',
        description = 'LABEL_CARD_ANARCHY_3_DESCRIPTION',
        effects = [{
          cancel_olympics = 1
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_4_TITLE',
        description = 'LABEL_CARD_ANARCHY_4_DESCRIPTION',
        effects = [{
          currency_loss_ratio = 0.5
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_5_TITLE',
        description = 'LABEL_CARD_ANARCHY_5_DESCRIPTION',
        effects = [{
          taxes_mode = 0
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_6_TITLE',
        description = 'LABEL_CARD_ANARCHY_6_DESCRIPTION',
        effects = [{
          taxes_mode = 1
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_7_TITLE',
        description = 'LABEL_CARD_ANARCHY_7_DESCRIPTION',
        effects = [{
          jail = false
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_8_TITLE',
        description = 'LABEL_CARD_ANARCHY_8_DESCRIPTION',
        effects = [{
          side_no_rent = 1
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_9_TITLE',
        description = 'LABEL_CARD_ANARCHY_9_DESCRIPTION',
        effects = [{
          festival = 1
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_10_TITLE',
        description = 'LABEL_CARD_ANARCHY_10_DESCRIPTION',
        effects = [{
          currency = 50000
        }]
      }, {
        title = 'LABEL_CARD_ANARCHY_11_TITLE',
        description = 'LABEL_CARD_ANARCHY_11_DESCRIPTION',
        effects = [{
          free_wonder = 1
        }]
      }],

      random = [{
        title = 'LABEL_CARD_RANDOM_0_TITLE',
        description = 'LABEL_CARD_RANDOM_0_DESCRIPTION',
        effects = [{
          currency = 20000
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_1_TITLE',
        description = 'LABEL_CARD_RANDOM_1_DESCRIPTION',
        effects = [{
          case_index = 35
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_2_TITLE',
        description = 'LABEL_CARD_RANDOM_2_DESCRIPTION',
        effects = [{
          move_player = -3
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_3_TITLE',
        description = 'LABEL_CARD_RANDOM_3_DESCRIPTION',
        effects = [{
          jail = true
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_4_TITLE',
        description = 'LABEL_CARD_RANDOM_4_DESCRIPTION',
        effects = [{
          rent_cost_ratio = 2.0
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_5_TITLE',
        description = 'LABEL_CARD_RANDOM_5_DESCRIPTION',
        effects = [{
          protect_case = 1
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_6_TITLE',
        description = 'LABEL_CARD_RANDOM_6_DESCRIPTION',
        effects = [{
          currency_loss_ratio = 0.5
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_7_TITLE',
        description = 'LABEL_CARD_RANDOM_7_DESCRIPTION',
        effects = [{
          taxes_mode = 0
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_8_TITLE',
        description = 'LABEL_CARD_RANDOM_8_DESCRIPTION',
        effects = [{
          taxes_mode = 1
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_9_TITLE',
        description = 'LABEL_CARD_RANDOM_9_DESCRIPTION',
        effects = [{
          turn_with_no_rent_on_case = 2
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_10_TITLE',
        description = 'LABEL_CARD_RANDOM_10_DESCRIPTION',
        effects = [{
          free_house = 1
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_11_TITLE',
        description = 'LABEL_CARD_RANDOM_11_DESCRIPTION',
        effects = [{
          turn_with_pandemie = 2
        }]
      }, {
        title = 'LABEL_CARD_RANDOM_12_TITLE',
        description = 'LABEL_CARD_RANDOM_12_DESCRIPTION',
        effects = [{
          next_rent_canceled = 1
        }]
      }]
    },

    wheel = [{
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.RANDOM
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.ANARCHY
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.RANDOM
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.ANARCHY
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.RANDOM
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.PRISON
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.ANARCHY
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.RANDOM
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.ANARCHY
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.RANDOM
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.ANARCHY
    }, {
      icon = 'res://....png',
      type = constant_utils.CARD_TYPE.AIRPORT
    }],

    wonders = [{
      name = 'LABEL_WONDER_EIFFEL_TOWER',
      case_id = '0e0d0f69-8b9e-43d8-9848-d1e932e1cadc',
      side = 3
    }, {
      name = 'LABEL_WONDER_PYRAMIDS',
      case_id = '6b94a216-2984-4447-b36a-e117d0b75129',
      side = 0
    }, {
      name = 'LABEL_WONDER_OLYMPIC_STADIUM',
      case_id = '83a15b78-867b-4e40-ac11-e77f9f5728fd',
      side = 2
    }, {
      name = 'LABEL_WONDER_EMPIRE_STATE_BUILDING',
      case_id = 'c3c3ef8e-691f-4727-a0cc-5d93325ccdfa',
      side = 2
    }, {
      name = 'LABEL_WONDER_HOLLYWOOD',
      case_id = '1b9ea974-75d4-4126-b2fc-0307d0b64339',
      side = 2
    }, {
      name = 'LABEL_WONDER_ZOCALO',
      case_id = 'd3dc2f8e-283b-4405-b0f0-d8bec701f359',
      side = 2
    }, {
      name = 'LABEL_WONDER_AVENIDA_PAULISTA',
      case_id = '63e8c09e-bc44-4e3a-b535-e1dcd5727a9e',
      side = 2
    }, {
      name = 'LABEL_WONDER_LA_CASA_ROSADA',
      case_id = 'a7a971d5-fcc4-41c0-afc5-d5f0d3e35d2e',
      side = 2
    }, {
      name = 'LABEL_WONDER_PLAZA_MAYOR',
      case_id = 'bedbbc33-b49c-44c0-9799-38016a9a45e7',
      side = 3
    }, {
      name = 'LABEL_WONDER_COLISEE',
      case_id = '716dc1c7-1865-49cf-9ba5-dd2bf82dd5c8',
      side = 3
    }, {
      name = 'LABEL_WONDER_BRANDEBOURG_GATE',
      case_id = '791d0ffd-11a0-4ca2-90f2-51f819e47e4f',
      side = 3
    }, {
      name = 'LABEL_WONDER_BIG_BEN',
      case_id = 'b9d17998-f4c4-40f7-b19f-f855bc4fb0e7',
      side = 3
    }, {
      name = 'LABEL_WONDER_RUELLES_DE_LA_CASBAH',
      case_id = '63009a68-a037-4b7d-924a-26603e6aa9c1',
      side = 0
    }, {
      name = 'LABEL_WONDER_MOSQUÉE_HASSAN',
      case_id = 'b1460a6f-4710-4572-a042-313fced73021',
      side = 0
    }, {
      name = 'LABEL_WONDER_BACARY_TRAORÉ',
      case_id = 'eecc8c85-4972-4aeb-8479-2a71e5da69fc',
      side = 0
    }, {
      name = 'LABEL_WONDER_NYIRAGONGO',
      case_id = '5eb90691-a2a8-4bc7-9a48-5d1f58954779',
      side = 0
    }, {
      name = 'LABEL_WONDER_LES_JARDINS_SECRETS',
      case_id = 'a4d21bdd-089a-4642-94b8-5b7d4a5b505d',
      side = 1
    }, {
      name = 'LABEL_WONDER_LA_CITÉ_INTERDITE',
      case_id = 'f7c78b83-130d-4050-8fc8-e6d28d0a85f6',
      side = 1
    }, {
      name = 'LABEL_WONDER_LE_FORT_DE_TUNG_CHUNG',
      case_id = 'eb23cec9-2e84-4677-9e39-b9eed7c8efd0',
      side = 1
    }, {
      name = 'LABEL_WONDER_MONUMENT_NASIONAL',
      case_id = '5dbea5e8-e175-468e-8e86-81cfa7b7a749',
      side = 1
    }, {
      name = 'LABEL_WONDER_SHIBUYA',
      case_id = '488f77cb-0df4-47f9-abef-5bfa651250fb',
      side = 1
    }],

    cases = [{
      id = '8b38a330-e172-48eb-afa5-1c0678d55ac7',
      color = {
        shadow = common_colors_util.DARK_YELLOW_COLOR
      },
      name = 'LABEL_CASE_BEGIN',
      type = constant_utils.CASE_TYPE.BEGIN,
    }, {
      id = '63009a68-a037-4b7d-924a-26603e6aa9c1',
      color = {
        shadow = common_colors_util.DARK_CYAN_COLOR
      },
      name = 'LABEL_CASE_ALGER',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 0,
      costs = {
        house = 5000,
        property = 6000,
        mortgage = 3000
      },
      rent = [200, 1000, 3000, 6000, 12000, 24000]
    }, {
      id = '50a74b84-5ca8-49f5-a9ba-69bfd756e74d',
      color = {
        shadow = common_colors_util.BLACK_COLOR
      },
      name = 'LABEL_CASE_TAXES',
      type = constant_utils.CASE_TYPE.TAXES
    }, {
      id = 'b1460a6f-4710-4572-a042-313fced73021',
      color = {
        shadow = common_colors_util.DARK_CYAN_COLOR
      },
      name = 'LABEL_CASE_CASABLANCA',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 0,
      costs = {
        house = 5000,
        property = 4500,
        mortgage = 1500
      },
      rent = [300, 1500, 4500, 9000, 18000, 36000]
    }, {
      id = 'b35f93b0-f811-4b8f-ace3-bba61a726e5f',
      color = {
        shadow = common_colors_util.BLACK_COLOR
      },
      name = 'LABEL_CASE_WONDER',
      type = constant_utils.CASE_TYPE.WONDER,
      costs = {
        property = 20000
      },
      rent = [5000, 10000, 20000, 40000]
    }, {
      id = 'eecc8c85-4972-4aeb-8479-2a71e5da69fc',
      color = {
        shadow = common_colors_util.DARK_CYAN_COLOR
      },
      name = 'LABEL_CASE_DAKAR',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 1,
      costs = {
        house = 5000,
        property = 6750,
        mortgage = 2250
      },
      rent = [450, 2250, 6750, 13500, 27000, 54000]
    }, {
      id = '672089a8-770e-4d2d-ae91-61dc86a755d7',
      color = {
        shadow = common_colors_util.DARK_GREEN_COLOR
      },
      name = 'LABEL_CASE_WHEEL',
      type = constant_utils.CASE_TYPE.WHEEL
    }, {
      id = '5eb90691-a2a8-4bc7-9a48-5d1f58954779',
      color = {
        shadow = common_colors_util.DARK_CYAN_COLOR
      },
      name = 'LABEL_CASE_KINSHASA',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 1,
      costs = {
        house = 5000,
        property = 6750,
        mortgage = 2250
      },
      rent = [450, 2250, 6750, 13500, 27000, 54000]
    }, {
      id = '6b94a216-2984-4447-b36a-e117d0b75129',
      color = {
        shadow = common_colors_util.DARK_CYAN_COLOR
      },
      name = 'LABEL_CASE_LECAIRE',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 1,
      costs = {
        house = 5000,
        property = 7500,
        mortgage = 2500
      },
      rent = [500, 2500, 7500, 15000, 30000, 60000]
    }, {
      id = 'a04a535f-b697-4e35-93c6-27e212d7ff8c',
      color = {
        shadow = common_colors_util.DARK_YELLOW_COLOR
      },
      name = 'LABEL_CASE_PRISON',
      type = constant_utils.CASE_TYPE.PRISON
    }, {
      id = '334e6140-4d38-4e7b-8e65-54572c1e9775',
      color = {
        shadow = common_colors_util.DARK_BLUE_COLOR
      },
      name = 'LABEL_CASE_BOMBAY',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 2,
      costs = {
        house = 10000,
        property = 10000,
        mortgage = 5000
      },
      rent = [1000, 5000, 10000, 20000, 40000, 80000]
    }, {
      id = '1c1d2051-d3a1-4e48-9e45-9e7fe4ce22db',
      color = {
        shadow = common_colors_util.DARK_GREEN_COLOR
      },
      name = 'LABEL_CASE_WHEEL',
      type = constant_utils.CASE_TYPE.WHEEL
    }, {
      id = 'a4d21bdd-089a-4642-94b8-5b7d4a5b505d',
      color = {
        shadow = common_colors_util.DARK_BLUE_COLOR
      },
      name = 'LABEL_CASE_SEOUL',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 2,
      costs = {
        house = 10000,
        property = 10000,
        mortgage = 5000
      },
      rent = [1000, 5000, 10000, 20000, 40000, 80000]
    }, {
      id = 'f7c78b83-130d-4050-8fc8-e6d28d0a85f6',
      color = {
        shadow = common_colors_util.DARK_BLUE_COLOR
      },
      name = 'LABEL_CASE_PEKIN',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 2,
      costs = {
        house = 10000,
        property = 12000,
        mortgage = 6000
      },
      rent = [1200, 6000, 12000, 24000, 48000, 96000]
    }, {
      id = 'eb23cec9-2e84-4677-9e39-b9eed7c8efd0',
      color = {
        shadow = common_colors_util.BLUE_COLOR
      },
      name = 'LABEL_CASE_HONGKONG',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 3,
      costs = {
        house = 10000,
        property = 14000,
        mortgage = 7000
      },
      rent = [1400, 7000, 14000, 28000, 56000, 112000]
    }, {
      id = '41759517-1d9a-4001-be53-0fbd57d4eb4a',
      color = {
        shadow = common_colors_util.BLACK_COLOR
      },
      name = 'LABEL_CASE_WONDER',
      type = constant_utils.CASE_TYPE.WONDER,
      costs = {
        property = 20000
      },
      rent = [5000, 10000, 20000, 40000]
    }, {
      id = '5dbea5e8-e175-468e-8e86-81cfa7b7a749',
      color = {
        shadow = common_colors_util.BLUE_COLOR
      },
      name = 'LABEL_CASE_JAKARTA',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 3,
      costs = {
        house = 10000,
        property = 14000,
        mortgage = 7000
      },
      rent = [1400, 7000, 14000, 28000, 56000, 112000]
    }, {
      id = '488f77cb-0df4-47f9-abef-5bfa651250fb',
      color = {
        shadow = common_colors_util.BLUE_COLOR
      },
      name = 'LABEL_CASE_TOKYO',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 3,
      costs = {
        house = 10000,
        property = 16000,
        mortgage = 8000
      },
      rent = [1600, 8000, 16000, 32000, 64000, 128000]
    }, {
      id = '50d148c5-73cf-48d2-aba3-417805df28e3',
      color = {
        shadow = common_colors_util.DARK_YELLOW_COLOR
      },
      name = 'LABEL_CASE_AIRPORT',
      type = constant_utils.CASE_TYPE.AIRPORT,
      costs = {
        flight = 5000
      }
    }, {
      id = '63e8c09e-bc44-4e3a-b535-e1dcd5727a9e',
      color = {
        shadow = common_colors_util.DARK_ORANGE_COLOR
      },
      name = 'LABEL_CASE_SAOPOLO',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 4,
      costs = {
        house = 15000,
        property = 18000,
        mortgage = 9000
      },
      rent = [1800, 9000, 18000, 36000, 72000, 108000]
    }, {
      id = 'd3dc2f8e-283b-4405-b0f0-d8bec701f359',
      color = {
        shadow = common_colors_util.DARK_ORANGE_COLOR
      },
      name = 'LABEL_CASE_MEXICO',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 4,
      costs = {
        house = 15000,
        property = 18000,
        mortgage = 9000
      },
      rent = [1800, 9000, 18000, 36000, 72000, 108000]
    }, {
      id = '0a17fe6a-92b3-4c16-8c73-b98a0f514208',
      color = {
        shadow = common_colors_util.DARK_GREEN_COLOR
      },
      name = 'LABEL_CASE_WHEEL',
      type = constant_utils.CASE_TYPE.WHEEL
    }, {
      id = 'a7a971d5-fcc4-41c0-afc5-d5f0d3e35d2e',
      color = {
        shadow = common_colors_util.DARK_ORANGE_COLOR
      },
      name = 'LABEL_CASE_BUENOSAIRES',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 4,
      costs = {
        house = 15000,
        property = 20000,
        mortgage = 10000
      },
      rent = [2000, 10000, 20000, 40000, 80000, 120000]
    }, {
      id = '83a15b78-867b-4e40-ac11-e77f9f5728fd',
      color = {
        shadow = common_colors_util.DARK_ORANGE_COLOR
      },
      name = 'LABEL_CASE_MONTREAL',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 5,
      costs = {
        house = 15000,
        property = 22000,
        mortgage = 11000
      },
      rent = [2200, 11000, 22000, 44000, 88000, 132000]
    }, {
      id = '5824ebba-88af-4170-a073-4f3a6381dbd9',
      color = {
        shadow = common_colors_util.BLACK_COLOR
      },
      name = 'LABEL_CASE_WONDER',
      type = constant_utils.CASE_TYPE.WONDER,
      costs = {
        property = 20000
      },
      rent = [5000, 10000, 20000, 40000]
    }, {
      id = '1b9ea974-75d4-4126-b2fc-0307d0b64339',
      color = {
        shadow = common_colors_util.DARK_ORANGE_COLOR
      },
      name = 'LABEL_CASE_LOSANGELES',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 5,
      costs = {
        house = 15000,
        property = 22000,
        mortgage = 11000
      },
      rent = [2200, 11000, 22000, 44000, 88000, 132000]
    }, {
      id = 'c3c3ef8e-691f-4727-a0cc-5d93325ccdfa',
      color = {
        shadow = common_colors_util.DARK_ORANGE_COLOR
      },
      name = 'LABEL_CASE_NEWYORK',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 5,
      costs = {
        house = 15000,
        property = 24000,
        mortgage = 12000
      },
      rent = [2400, 12000, 24000, 48000, 96000, 144000]
    }, {
      id = 'e8bf84db-b35b-4abe-b07e-0ad2c8ee1ea6',
      color = {
        shadow = common_colors_util.DARK_YELLOW_COLOR
      },
      name = 'LABEL_CASE_OLYMPICS',
      type = constant_utils.CASE_TYPE.OLYMPICS,
      rent_ratio = 0.5
    }, {
      id = 'bedbbc33-b49c-44c0-9799-38016a9a45e7',
      color = {
        shadow = common_colors_util.DARK_RED_COLOR
      },
      name = 'LABEL_CASE_MADRID',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 6,
      costs = {
        house = 20000,
        property = 30000,
        mortgage = 15000
      },
      rent = [3000, 15000, 30000, 52500, 105000, 165000]
    }, {
      id = '716dc1c7-1865-49cf-9ba5-dd2bf82dd5c8',
      color = {
        shadow = common_colors_util.DARK_RED_COLOR
      },
      name = 'LABEL_CASE_ROME',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 6,
      costs = {
        house = 20000,
        property = 30000,
        mortgage = 15000
      },
      rent = [3000, 15000, 30000, 52500, 105000, 165000]
    }, {
      id = 'ea0ffc6f-34ad-4ef7-88be-f4ddf4b2b9f5',
      color = {
        shadow = common_colors_util.DARK_GREEN_COLOR
      },
      name = 'LABEL_CASE_WHEEL',
      type = constant_utils.CASE_TYPE.WHEEL
    }, {
      id = '791d0ffd-11a0-4ca2-90f2-51f819e47e4f',
      color = {
        shadow = common_colors_util.DARK_RED_COLOR
      },
      name = 'LABEL_CASE_BERLIN',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 6,
      costs = {
        house = 20000,
        property = 32000,
        mortgage = 16000
      },
      rent = [3200, 16000, 32000, 56000, 112000, 176000]
    }, {
      id = '407a6afa-9f2e-4c83-88e1-0c84ff09dd71',
      color = {
        shadow = common_colors_util.BLACK_COLOR
      },
      name = 'LABEL_CASE_WONDER',
      type = constant_utils.CASE_TYPE.WONDER,
      costs = {
        property = 20000
      },
      rent = [5000, 10000, 20000, 40000]
    }, {
      id = 'b9d17998-f4c4-40f7-b19f-f855bc4fb0e7',
      color = {
        shadow = common_colors_util.DARK_RED_COLOR
      },
      name = 'LABEL_CASE_LONDRES',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 7,
      costs = {
        house = 20000,
        property = 36000,
        mortgage = 18000
      },
      rent = [3600, 18000, 36000, 63000, 126000, 198000]
    }, {
      id = '0731f322-3182-4bf6-ad76-40c85712762e',
      color = {
        shadow = common_colors_util.BLACK_COLOR
      },
      name = 'LABEL_CASE_FESTIVAL',
      type = constant_utils.CASE_TYPE.FESTIVAL,
      rent_ratio = 0.25
    }, {
      id = '0e0d0f69-8b9e-43d8-9848-d1e932e1cadc',
      color = {
        shadow = common_colors_util.DARK_RED_COLOR
      },
      name = 'LABEL_CASE_PARIS',
      type = constant_utils.CASE_TYPE.PROPERTY,
      group = 7,
      costs = {
        house = 20000,
        property = 40000,
        mortgage = 20000
      },
      rent = [4000, 20000, 40000, 70000, 140000, 220000]
    }]
  }
