/// @desc definitions

if (keyboard_check_pressed(vk_enter)) {
	var cds = codes[array_length(codes) - 2];
	var char = string_char_at(cds, array_length(codes) - 1);
	
	var defs = {
		test : ["test", string_pos("test", cds)],
		print : ["print ", string_pos("print", cds)],
	}
	
	#region print
	if (check_definition(defs.print)) {
		
		var pos_after = defs.print[1] + string_length(defs.print[0]);
		var after = string_copy(cds, pos_after, string_length(cds) - string_length(defs.print[0]));
		
		if (string_length(after) > 0 && string_inside_char("\"", after)) {
			var printed = string_copy(cds, pos_after + 1, string_length(cds) - string_length(defs.print[0]) - 2);
			
			codes[array_length(codes)-1] += "> " + printed;
			add_line();
		}
		
		// errors //
		// nothing after the print def
		if (string_length(after) == 0) {
			codes[array_length(codes)-1] = "Error: nothing to print | at line " + string(array_length(codes)-1);
			add_line();
		}
		// is not a string
		if (string_length(after) > 0 && !string_inside_char("\"", after)) {
			codes[array_length(codes)-1] = "Error: you need to make that a string | at line " + string(array_length(codes)-1);
			add_line();
		}
		
	}
	// dont have a space or have more than that
	if (string_ends_with(codes[array_length(codes) - 2], "print")) {
		codes[array_length(codes)-1] = "Error: ended with no arguments | at line " + string(array_length(codes)-1);
		add_line();
	}
	#endregion
	
	#region test
	if (check_definition(defs.test, true)) {
		
		codes[array_length(codes)-1] += "> i need this working \":)\"";
		add_line();
		
	}
	#endregion
	
	
}