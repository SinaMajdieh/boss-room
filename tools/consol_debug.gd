extends Resource
class_name ConsolDebug

@export var enabled: bool = false
@export var color: String = "default"

func log_message(message: String) -> void:
    if not enabled:
        return
    print_rich("[color=%s]%s" % [color, message])


func log_warning(message: String, bypass_enabled: bool = true) -> void:
    if bypass_enabled or enabled:
        print_rich("[color=red]%s" % message)


func log_error(message: String, bypass_enabled: bool = true) -> void:
    if bypass_enabled or enabled:
        print_rich("[color=yellow]%s" % message)