extends Control

var is_visible = false
var mpos = Vector2()
var start_selection_pos = Vector2()
var box_color = Color(0, 1, 0)
var box_line_width = 3


func _draw():
	if is_visible and start_selection_pos != mpos:
		draw_line(start_selection_pos, Vector2(mpos.x, start_selection_pos.y), box_color, box_line_width)
		draw_line(start_selection_pos, Vector2(start_selection_pos.x, mpos.y), box_color, box_line_width)
		draw_line(Vector2(start_selection_pos.x, mpos.y), Vector2(mpos.x, mpos.y), box_color, box_line_width)
		draw_line(Vector2(mpos.x, mpos.y), Vector2(mpos.x, start_selection_pos.y), box_color, box_line_width)


func _process(delta):
	update()
