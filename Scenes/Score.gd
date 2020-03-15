extends RichTextLabel

var score = 0

func _ready():
	print(self.get_path())
	
func _process(delta):
	set_text("Score: " + str(score))
