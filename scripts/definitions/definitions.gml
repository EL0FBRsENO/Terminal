
/// @desc  Adds a new line to the Terminal and scroll everything
/// @param {Bool} scroll	If it needs to scroll(true) or not(false)
/// @param {Bool} erase		Erases the text input when adding the new line
function add_line(scroll = true, erase = true) {
	codes[current_line] = "";
	current_line ++;
	lines ++;
	if (scroll) scroll_y += string_height("|");
	if (erase) input = "";
}

/// @desc  Change the color of a word (just work on Draw events)
/// @param {String} word			The word(string) to search for
/// @param {Color}	color			The color of the word
/// @param {Real}	index			The index of the lines
/// @param {Real}	index2			The index of the characters of the lines
/// @param {Bool}	[check_end]		Check if the word dont has anything before it and anything after(check if the word has a space in after it)d
/// @param {Bool}	[check_start]	Check if the word dont has anything before it and anything after(check if the word has a space in after it)d
function word_color(word, color, index, index2, check_end = true, check_start = true) {
	
	var f = function(word, color, index, index2) {
		if (index2 > string_pos(word, codes[index])-1 && index2 < string_pos(word, codes[index]) + string_length(word)) {
			draw_set_color(color);
		}
	}
	
	var f2 = function(word, color, index, index2) {
		var char = string_char_at(codes[index], index2);
		
		if (char == word) {
			draw_set_color(color);
		}
	}
	
	if (string_length(word) > 1) {
		if (check_start) {
			if (string_pos(word, codes[index])-1 > -1) && ((string_copy(codes[index], 0, string_length(word)) == word) || (string_copy(codes[index], string_pos(word, codes[index]) - 1, 1) == " ") ) {
				if (check_end) {
					if (string_ends_with(codes[index], word) || (string_char_at(codes[index], string_pos(word, codes[index]) + string_length(word)) == " ")) {
						f(word, color, index, index2);
					}
				}else {
					f(word, color, index, index2);
				}
			}
		}else {
			if (string_pos(word, codes[index])-1 > -1) {
				f(word, color, index, index2);
			}
		}
	}else if (string_length(word) == 1) {
		if (check_start) {
			if (string_pos(word, codes[index])-1 > -1) && ((string_copy(codes[index], 0, string_length(word)) == word) || (string_copy(codes[index], string_pos(word, codes[index]) - 1, 1) == " ") ) {
				if (check_end) {
					if (string_ends_with(codes[index], word) || (string_char_at(codes[index], string_pos(word, codes[index]) + string_length(word)) == " ")) {
						f2(word, color, index, index2);
					}
				}else {
					f2(word, color, index, index2);
				}
			}
		}else {
			if (string_pos(word, codes[index])-1 > -1) {
				f2(word, color, index, index2);
			}
		}
	}
	
}

/// @desc	Check for a definition (on the last line)
/// @return {Bool}
/// @param	{Array}		definition	The name of the definition to check for
/// @param	{Bool}		check_end	If it needs to check the end of the word(true) or not(false)
function check_definition(definition, check_end = false) {
	var cds = codes[array_length(codes) - 2];
	
	var def = definition[0];
	var def2 = definition[1];
	
	// before word check
	if ((string_copy(cds, 0, string_length(def)) == def) || (string_copy(cds, def2 - 1, 1) == " ")) {
		// after word check
		if (check_end) {
			if (string_ends_with(cds, def) || (string_char_at(cds, def2 + string_length(def)) == " ")) {
				if (string_copy(cds, def2, string_length(def)) == def) {
					return true;
				}
			}
		}else {
			if (string_copy(cds, def2, string_length(def)) == def) {
				return true;
			}
		}
		
	}
	
	return false;
}

/// @desc Checks if a string is beetwen two of the same character
/// @return {Bool}
/// @param	{String}	char		The character to check the string beetwen it
/// @param	{String}	str			The string that is in beetwen the characters
function string_inside_char(char, str) {
	
	if (string_starts_with(str, char) && string_ends_with(str, char)) {
		return true;
	}
	
	return false;
	
}

/// @desc Checks if a string is beetwen of two characters
/// @return {Bool}
/// @param	{String}	char1		The first character to check the string beetwen it
/// @param	{String}	char2		The second character to check the string beetwen it
/// @param	{String}	str			The string that is in beetwen the characters
function string_inside_chars(char1, char2, str) {
	
	if (string_starts_with(str, char1) && string_ends_with(str, char2)) {
		return true;
	}
	
	return false;
	
}