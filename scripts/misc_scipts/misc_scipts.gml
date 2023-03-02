
/// @desc Totally deprecated for this project.
function draw_text_spaced(xx, yy, str, space, bold = false) {
	
	// original x pos
	var sox = xx;
	
	for (var i = 1; i <= string_length(str); i++) {
		// each letter 
		var ch = string_char_at(str, i);
		
		if (ch == "\n") {	// check if it has a line break
			yy += string_height("|");
			xx = sox;
		}else {
			// draw the text
			draw_text_transformed(xx-.5, yy-.5, ch, .5, .5, 0);
			if (bold) draw_text_transformed(xx+1-.5, yy-.5, ch, .5, .5, 0);
		
			// increase the x pos by the space and by each letter width
			xx += string_width(ch)/2-1;
			xx += space;
		}
	}
	
	
}