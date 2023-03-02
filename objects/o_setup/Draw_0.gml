/// @desc
draw_set_font(fn_consolas);

var rw = window_get_width();
var rh = window_get_height();

var str_height = string_height("|");
var bar_height = str_height + 5;

var _tx = 4;
var _ty = rh - bar_height + 3;


// lines bar
draw_set_color(#15151C);
draw_rectangle(0, 0, string_width(string(lines)) + 2, rh, false);

// current line
draw_set_color(#3A3A4C);
draw_set_alpha(.5);
draw_rectangle(0, ((current_line * string_height("|")) - string_height("|")) - scroll_y, rw, (current_line * string_height("|")) - scroll_y, false);

draw_set_alpha(1);
draw_set_valign(fa_middle);
var xx = 0;
var yy = 0;
for (var i = 0; i < array_length(codes); i++) {
	
	// lines numbers
	draw_set_color(#4c4c5c);
	draw_set_halign(fa_right);
	if (current_line == i+1) draw_set_color(#6c6c7c);
	draw_text(string_width(string(lines)) + 2, 5 + ((i) * string_height("|")) + 5 - scroll_y, string(i+1));
	
	// colored words
	var ch = 0;
	
	draw_set_color(#898999);
	draw_set_halign(fa_left);
	for (var n = 1; n <= string_length(codes[i]); n++) {
		
		draw_set_color((current_line == i+1) ? #9F9FB2 : #898999);
		
		var defs = {
			test : ["test", string_pos("test", codes[i])],
			debug : ["debug", string_pos("debug", codes[i])],
			print : ["print", string_pos("print", codes[i])],
		}
		
		word_color(defs.test[0],  #654ED8, i, n);		// test
		word_color(defs.debug[0], #EC59CD, i, n);		// debug {other keyword}
		word_color(defs.print[0], #1188ff, i, n);		// print "example"
		
		word_color("(", #E5CEE2, i, n, false, false);	// (
		word_color(")", #E5CEE2, i, n, false, false);	// )
		word_color("<", #B7AEA1, i, n, false, false);	// <
		word_color(">", #B7AEA1, i, n, false, false);	// >
		
		word_color("\"", #E5C24A, i, n, false, false);
		
		//if (n > string_pos("\"", codes[i]) && n < string_last_pos("\"", codes[i])) {
		//if (string_inside_char(ch, codes[i])) {
		//	draw_set_color(#E5C24A);
		//}
		
		if (string_starts_with(codes[i], "Error: ")) {
			draw_set_color(#FF0000);
		}
		
		var char = string_char_at(codes[i], n);
		
		if (char == "\n") {	
			// add a line break
			yy += string_height("|");
			
			xx = 0;
		}else {
			// draw the text
			draw_text(xx + string_width(string(lines)) + 5, yy + 5 + ((i) * string_height("|")) + 5 - scroll_y, char);
			
			xx += string_width(char);
		}
		
		ch = string_insert(char, ch, string_length(char));
	}
	
	xx = 0;
	yy = 0;
	
}


// text input bar
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(#3c3c4c);
draw_rectangle(0, rh - bar_height, rw, rh, false);

// text input
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(_tx, _ty, input);

// caret
var caret_x = string_width(input);

if (focusText == "|") draw_rectangle(_tx + caret_x, _ty - 1, _tx + caret_x, _ty + string_height("|"), false);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);