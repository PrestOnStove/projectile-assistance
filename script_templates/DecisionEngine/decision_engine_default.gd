#class_name DecisionEngineName
extends DecisionEngine
# meta-name: DecisionEngine
# meta-description: Boilerplate decision engine script
# meta-default: true

# Included in DecisionEngine:
# var enemy : Enemy
# var current_state : EnemyState
# var blackboard : Blackboard


func _ready() -> void:
	await super() # Maintains important setup code & timing
	# Implement your own scripts here
	pass



# All the conditions for making decisions go in this function
func decide() -> EnemyState:
	# example decisions
	# if blackboard.damagesource:
		#if blackboard.health <= 0:
			#return es_death
		#else:
			#return es_stun
	#
	#if current_state is ESDeath or not blackboard.can_decide:
		#return null
	
	#if blacboard.target:
		#if blackboard.distance_to_target < 40:
			#return attack_state?
		#return chase_state?
	return null #default state
