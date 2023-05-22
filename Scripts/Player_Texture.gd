extends Sprite2D

@export var animation: AnimationPlayer = null

func animate(velocity: Vector2) -> void:
	change_direction(velocity.x)
	
	if velocity.y != 0:
		vertical_behavior(velocity.y)
		return
	horizontal_behavior(velocity.x)


func change_direction(direction: float) -> void:
	if direction > 0:
		flip_h = false
		
	if direction < 0:
		flip_h = true
		
func vertical_behavior(direction: float) -> void:
	if direction > 0:
		animation.play("Fall")
		
	if direction < 0:
		animation.play("Jump")
	
func horizontal_behavior(direction: float) -> void:
	
	#Se alguma tecla de andar estiver sendo pressionada executa a animação correr
	if direction != 0:
		animation.play("Run")
		return
	
	#Se nada acontecer executa a função idle
	animation.play("Idle")
