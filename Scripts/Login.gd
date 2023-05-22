extends Control

#Variavel do banco de dados e seu caminho
var db
var dbPath = "res://Database/login"

func _ready():
	db = SQLite.new()
	db.path = dbPath
	pass

func userValidation():
	#Associando o BD e abrindo ele
	db.open_db()
	
	#Pegando o usuario e senha dos objetos da cena
	var password = str($lblSenha/txtSenha.text)
	var user = str($lblUsuario/txtUsuario.text)
	
	#Query
	var query = "SELECT * FROM UserData WHERE User = ? AND Password = ?"
	#Parametros para substituir os "?"
	var params: Array = [user, password]
	
	db.query_with_bindings(query, params)
	
	#Validando se há mesmo um usuário e senha iguais aos digitados
	if db.query_result.size() > 0:
		for i in range(0, db.query_result.size()):
			if db.query_result[i]["User"] == user and db.query_result[i]["Password"] == password:
				print("Query result, usuario: ", db.query_result[i]["User"],", senha: ", db.query_result[i]["Password"])
				get_tree().change_scene_to_file("res://Scenes/Mundo.tscn")
	else:
		print("Usuário ou senha incorretos")


func _on_button_pressed():
	userValidation()
