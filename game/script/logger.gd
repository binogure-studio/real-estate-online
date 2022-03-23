extends Node

const FLUSH_EVERY = 16
const LOGFILE_AMOUNT = 10
const LOGFILE_PATH = 'user://real-estate-online-%s.log'

const FORMAT = '%02d:%02d:%02d - %s - %s'
const DEBUG = 'debug'
const INFO = 'info'
const WARNING = 'warning'
const ERROR = 'error'

enum LOG_LEVEL {
  LEVEL_VERBOSE = 0,
  LEVEL_DEBUG = 1,
  LEVEL_INFO = 2,
  LEVEL_WARNING = 3,
  LEVEL_ERROR = 4
}

var current_filename
var logfile = File.new()
var message_amount = 0
var log_level = LOG_LEVEL.LEVEL_WARNING

func _init():
  current_filename = get_logfilename()
  logfile.open(current_filename, File.WRITE)

func _ready():
  if OS.is_debug_build() and OS.is_stdout_verbose():
    log_level = LOG_LEVEL.LEVEL_VERBOSE

  elif OS.is_debug_build():
    log_level = LOG_LEVEL.LEVEL_DEBUG

  elif OS.get_name() == 'OSX':
    log_level = LOG_LEVEL.LEVEL_WARNING

  else:
    log_level = LOG_LEVEL.LEVEL_INFO

func _exit_tree():
  # Flush the logfile if it is not
  # null yet.
  if logfile != null:
    logfile.close()

func get_logfilename():
  var logfilename = null
  var last_modified_time = 0
  var file = File.new()

  for index in range(0, LOGFILE_AMOUNT):
    var filename = LOGFILE_PATH % [index]

    if not file.file_exists(filename):
      logfilename = filename
      break

    var modified_time = file.get_modified_time(filename)

    if modified_time < last_modified_time or last_modified_time == 0:
      last_modified_time = modified_time
      logfilename = filename

  file.close()
  return logfilename

func verbose(template, parameters = []):
  if log_level <= LOG_LEVEL.LEVEL_VERBOSE:
    _log(DEBUG, template, parameters)

func debug(template, parameters = []):
  if log_level <= LOG_LEVEL.LEVEL_DEBUG:
    _log(DEBUG, template, parameters)

func info(template, parameters = []):
  if log_level <= LOG_LEVEL.LEVEL_INFO:
    _log(INFO, template, parameters)

func warning(template, parameters = []):
  if log_level <= LOG_LEVEL.LEVEL_WARNING:
    _log(WARNING, template, parameters, true)

func error(template, parameters = []):
  var message = template % parameters

  _log(ERROR, '%s (%s)', [message, get_stack()], true)

func _log(level, template, parameters, flush = false):
  var time = Time.get_time_dict_from_system()
  var log_message = FORMAT % [
    time.hour, time.minute, time.second,
    level,
    template % parameters
  ]

  # Initialize the logger if the file descriptor is dead
  # Happened to me for now reason, seems like `_init` is not always called?
  if logfile == null:
    return

  logfile.store_line(log_message)
  message_amount += 1

  if flush or message_amount > FLUSH_EVERY:
    _flush()

  # Output to stdout
  if OS.is_debug_build():
    print(log_message)

func _flush():
  message_amount = 0

  if logfile != null:
    logfile.close()

  logfile = File.new()
  logfile.open(current_filename, File.READ_WRITE)
  logfile.seek_end()

func dump():
  logfile.seek(0)
  var dump_value = logfile.get_buffer(logfile.get_len()).get_string_from_utf8() if logfile != null else ''
  logfile.seek_end(0)

  return dump_value
