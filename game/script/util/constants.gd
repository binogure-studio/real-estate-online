extends Object
# To import this script
# const constant_utils = preload('res://script/util/constants.gd')

const BANK_ID = -1
const INVALID_CASE_ID = -1
const NO_FILTER = -1

enum PLAYER_CONNECT_TYPE {
  HUMAN_LOCAL,
  HUMAN_REMOTE,
  COMPUTER_LOCAL,
  COMPUTER_REMOTE
}

enum PLAYER_TAXE_MODE {
  PROPORTIONNAL,
  FORFAIT
}

enum CASE_TYPE {
  BEGIN = 1,
  PRISON = 2,
  AIRPORT = 4,
  OLYMPICS = 8,

  WONDER = 16,
  PROPERTY = 32,
  TAXES = 64,
  FESTIVAL = 128,
  WHEEL = 256
}

enum ACTION_TYPE {
  SELECT_CASE = 1,
  SELECT_PLAYER = 2,
  SELECT_SIDE = 4,
  SELECT_NOTHING = 8
}

enum CARD_TYPE {
  RANDOM,
  ANARCHY,
  PRISON,
  AIRPORT
}

enum PLAYER_TYPE {
  NO_OWNER = 1,
  OWNED_BY_PLAYER = 2,
  OWNED_BY_ANOTHER_PLAYER = 4
}

enum HOUSE_ACTION {
  NO_ACTION = 0,
  BUILD_HOUSE = 1,
  FREE_HOUSE = 2
}
