#class_name ESName
extends EnemyState

# meta-name: EnemyState
# meta-description: Boilerplate template for enemy state script
# meta-default: true

# EnemyState class will inherit the following variables:
# @export var animation_name : Stringe = "Idle"
# var state_machine : EnemyStateMachine
# var enemy : Enemy
# var blackboard : Blackboard

func enter() -> void:
	# what happens when we enter this state?
	pass


func re_enter() -> void:
	# what happens if this state is called again?
	pass


func exit() -> void:
	# what do we need to influence while in this state?
	pass


func physics_update( _delta : float ) -> void:
	# what physics do we need to influnce while in this state?
	pass
