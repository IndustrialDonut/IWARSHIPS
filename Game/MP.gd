extends Node2D

const SERVER_PORT = 4399
const MAX_PLAYERS = 100
const SERVER_IP = "24.6.196.226"
# need to use local IP for testing instances of game on same PC.

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	#get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	#get_tree().connect("connection_failed", self, "_connected_fail")
	#get_tree().connect("server_disconnected", self, "_server_disconnected")


func _on_host_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	
	get_parent().team = 0
	
	self.hide()


func _on_join_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().network_peer = peer
	
	get_parent().team = 1


func _player_connected(id):
	print(id, " connected!")
	
	get_parent().initialize_teams()


func _connected_ok():
	self.hide()
	print("connected to server")
