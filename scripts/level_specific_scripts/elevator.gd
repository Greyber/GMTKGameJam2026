extends MovablePlatform

@export var current_base_position : int = 592
@export var end_position : int = 816
var moving = false

func _ready() -> void:
	super()
	set_process(false)
	$InteractuableArea._on_interact.connect(interact)
	speed = Vector2.ZERO

func _process(delta: float) -> void:
	super(delta)
	if position.y > end_position:
		position.y = end_position
		speed = Vector2.ZERO
		EventBus.ON_START_NEXT_LEVEL.emit()
		set_process(false)
		
func reset() -> void:
	position.y = current_base_position
	speed = Vector2.ZERO

func interact(_by_whom) -> void:
	set_process(true)
	speed = Vector2(0, 50)
	EventBus.ON_LOAD_NEXT_LEVEL.emit()
	
func toggle(_is_on : bool) -> void:
	$left/CollisionShape2D.set_deferred("disabled", _is_on)
	$left.visible = not _is_on
