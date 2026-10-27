class_name PlayerStateGroundSlam extends PlayerState

const DASH_AUDIO = preload("uid://c755jb5273sbc")
const BOOM_AUDIO = preload("uid://rs45ww5k5rpi")
const BREAK_WOOD_AUDIO = preload("uid://cgdt3c6l4p3do")


const HIT_WOOD_LARGE = preload("uid://cbu73hwtaix3r")
const HIT_WOOD_MEDIUM = preload("uid://dlom01ewmjej5")
const HIT_WOOD_SMALL = preload("uid://c5cvv64hqow0v")


@export var velocity : float = 400
@export var effect_delay : float = 0.075
var effect_timer : float = 0.0

@onready var damage_area: DamageArea = %DamageArea
@onready var ground_slam_shapecast: ShapeCast2D = $"../../GroundSlamShapecast"
@onready var ground_slam_attack_area: AttackArea = %GroundSlamAttackArea




# what happens when the state is initialized?
func init() -> void:
	pass


# what happens when we enter this state?
func enter() -> void:
	player.animation_player.play( "ground_slam" )
	player.sprite.tween_color()
	Audio.play_spatial_sound( DASH_AUDIO, player.global_position, false, true, 0.75 )
	damage_area.start_invulnerable()
	ground_slam_attack_area.set_active( true )
	pass


# what happens when we exit this state?
func exit() -> void:
	VisualEffects.camera_shake( 10.0 )
	VisualEffects.land_dust( player.global_position )
	VisualEffects.hit_dust( player.global_position )
	Audio.play_spatial_sound( BOOM_AUDIO, player.global_position, false, true, 1.0 )
	damage_area.end_invulnerable()
	ground_slam_attack_area.set_active( false )
	pass


# what happens when an input is pressed?
func handle_input( _event : InputEvent ) -> PlayerState:
	return null


# what happens each process tick in this state?
func process( _delta: float ) -> PlayerState:
	check_collisions( _delta )
	effect_timer -= _delta
	if effect_timer < 0:
		effect_timer = effect_delay
		player.sprite.ghost()
	return null


# what happens each physics_process tick in this state?
func physics_process( _delta: float) -> PlayerState:
	player.velocity = Vector2 ( 0, velocity )
	if player.is_on_floor():
		if not check_collisions( _delta ):
			return idle
	return next_state


func check_collisions( _delta : float ) -> bool:
	ground_slam_shapecast.target_position.y = velocity * _delta 
	ground_slam_shapecast.force_shapecast_update()
	if ground_slam_shapecast.is_colliding():
		for i in ground_slam_shapecast.get_collision_count():
			var c = ground_slam_shapecast.get_collider( i )
			var pos : Vector2 = ground_slam_shapecast.get_collision_point( i )
			if c.get_parent() is Breakable:
				var b : Breakable = c.get_parent()
				b.queue_free()
				Audio.play_spatial_sound( b.destroy_audio, pos, false, true, 0.75 )
				for p in b.destroy_particles:
					VisualEffects.hit_particles( pos, Vector2.DOWN, p )
			else:
				c.queue_free()
				VisualEffects.hit_particles( pos, Vector2.DOWN, HIT_WOOD_LARGE )
				VisualEffects.hit_particles( pos, Vector2.DOWN, HIT_WOOD_MEDIUM )
				VisualEffects.hit_particles( pos, Vector2.UP, HIT_WOOD_SMALL )
				Audio.play_spatial_sound( BREAK_WOOD_AUDIO, pos, false, true, 0.75 )
			
			VisualEffects.hit_dust( pos )
			VisualEffects.camera_shake( 10.0 )
		return true
	return false
