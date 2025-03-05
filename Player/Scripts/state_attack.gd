class_name State_Attack extends State

var attacking : bool = false

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"

## What happens when the player enters this state?
func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_anim.play( "attack_" + player.AnimDirection() )
	animation_player.animation_finished.connect( EndAttack )
	attacking = true
	pass


## what happens when the player exits this state?
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	pass


## what happens during the _process update in this state?
func Process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

## what happens during the _physics_process update in this state?
func Physics( _delta : float ) -> State:
	return null

## what happens with input events in this state?
func HandleInput( _event: InputEvent ) -> State:
	return null
	
func EndAttack( _newAnimName : String ) -> void:
	attacking = false
