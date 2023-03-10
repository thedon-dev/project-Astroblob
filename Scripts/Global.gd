extends Node

var openedLevels = 1 #initial number of levels opened

const filepath = "user://highscore.save" #file path for saving the number of levels opened

func _ready():
	load_data() #always load the data when loaded into the tree

func save_data():
	var file = File.new() #create a new file
	file.open(filepath, File.WRITE) #tell the file we want to write to it
	var data = {
		"openedLevels" : openedLevels #assigning the openedlevel variable to the dictionary for saving 
	}
	file.store_var(data) #storing the data to the file  after writting to it
	file.close() #closing the file

func load_data():
	var save_data = File.new()
	if save_data.file_exists(filepath): #check if a file already exits
		save_data.open(filepath, File.READ) #tell the file we want to read from it
		var data = save_data.get_var() #getting the data stored in the file
		openedLevels= data["openedLevels"] #assigning the old value with the new one 
		save_data.close() #close the file after reeading 
