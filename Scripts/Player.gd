extends CharacterBody2D

#@onready var sprite: Sprite2D = get_node("Texture")

var jumpCount: int = 0

#A variavél será editavel pela interface
@export var moveSpeed: float = 100.00
@export var jumpSpeed: float = -300.00
@export var gravitySpeed: float = 500.00

func _physics_process(delta):
	
	#Chamando a minha função de mover e uma do próprio Godot que passa isso para o Character
	move()
	velocity.y += delta * gravitySpeed
	move_and_slide()
	
	jump()
	
	
	#Vou passar a velocity para o script de animação, pois dá para saber qual animação executar
	#e que lado o personagem está andando
	#sprite.animate(velocity)


func move() -> void:
	var direction: float = get_direction()
	
	#Velocity é uma propriedade nativa do characterBody
	velocity.x = direction * moveSpeed

	
func get_direction() -> float:
	#Pegando a direção das teclas, é retornado um valor entre -1 e 1
	return (Input.get_axis("ui_left","ui_right"))

func jump() -> void:
	#Reseta os pulos quando toca no chão
	if is_on_floor():
		jumpCount = 0
	
	#Se espaço for pressionado ele pula
	if Input.is_action_just_pressed("ui_select") and jumpCount < 1:
		velocity.y = jumpSpeed
		jumpCount += 1
