/// @desc input

// delete/type characters
var keys = keyboard_string;

focusTextDelay ++;
if (focusTextDelay >= 15) {
	focusText = (focusText == "|") ? "" : "|";
	focusTextDelay = 0;
}

if (!keyboard_check(vk_control) && keyboard_check(vk_backspace)) {
	if (firstDeleteTimer == 0) {
		//if (caret_pos > 1)
			input = string_delete(input, string_length(input), 1);
			//caret_pos--;
			//if (caret_pos + 1 < array_length(chars_str(input)))
			//	caret_x -= chars_str(input)[caret_pos + 1];
	}
	firstDeleteTimer ++;
	if (firstDeleteTimer >= 18) {
		deleteTimer ++;
		if (deleteTimer >= 6) {
			input = string_delete(input, string_length(input), 1);
			deleteTimer = 0;
		}
	}
}else if (keyboard_check(vk_control) && keyboard_check_pressed(vk_backspace)) {
	input = "";
	
}else if (!keyboard_check(vk_backspace)) {
	firstDeleteTimer = 0;
	if (keyboard_check(vk_anykey) && !keyboard_check(vk_control)) {
		input = string_insert(keys, input, string_length(input)+1);
		keyboard_string = "";
	}
}

// send text
if (keyboard_check_pressed(vk_enter)) {
	input = string_trim_start(input);
	codes[current_line-1] = input;
	add_line();
}

// scroll the page
if (mouse_wheel_up()) {
	scroll_y -= 20;
}
if (mouse_wheel_down()) {
	scroll_y += 20;
}

if (keyboard_check_pressed(vk_pageup)) {
	scroll_y = 0;
}
if (keyboard_check_pressed(vk_pagedown)) {
	scroll_y = infinity;
}

scroll_y = clamp(scroll_y, 0, (lines > 35) ? (lines * string_height("|")) - 200 : 1);

// copy and paste
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C"))) {
	clipboard_set_text(string(input));
}

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V"))) {
	input += clipboard_get_text();
}

input = string_delete(input, string_pos(chr($007F), input), 1);