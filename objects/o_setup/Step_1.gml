/// @desc window resizer

if (window_has_focus()) {
	var win_w = window_get_width();
	var win_h = window_get_height();
	
	surface_resize(application_surface, win_w, win_h);
	camera_set_view_size(view_camera[0], win_w, win_h);
	display_set_gui_size(win_w, win_h);
	room_set_width(room, win_w);
	room_set_height(room, win_h);

	//show_debug_message(room_width, room_height);
}