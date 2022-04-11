
// copy all struct variables and values to another
function struct_copy(src, dest) {
	if is_struct(src) {
		if !is_struct(dest) dest = {};
		var _names = variable_struct_get_names(src);
		var _size = array_length(_names);
			
		for (var i = 0; i < _size; ++i) {
			var _name = _names[i];
			variable_struct_set(dest, _name, variable_struct_get(src, _name));
		}
		return true;
	}
	return -1;
}

// clear the struct without deleting it
function struct_clear(struct) {
	if is_struct(struct) {
		var _names = variable_struct_get_names(struct);
		var _size = array_length(_names);
		
		for (var i = 0; i < _size; ++i) {
			var _name = _names[i];
			variable_struct_remove(struct, _name);
		}
	}
}

// clear all variables and replace with new struct data
function struct_replace(src, dest) {
	if is_struct(src) && is_struct(dest) {
		struct_clear(dest);
		struct_copy(src, dest);
		return true;
	}
	return -1;
}

// copy one struct to many others
function struct_multiply(src, dest_array) {
	if is_array(dest_array) {
		var _size = array_length(dest_array);
		
		for (var i = 0; i < _size; ++i) {
			var _dest = dest_array[i];
			struct_copy(src, _dest);
		}
		return true;
	}
	return -1;
}

// compare if a struct has variables equal to another
function struct_compare(struct1, struct2) {
	var _equal = false;
	if is_struct(struct1) && is_struct(struct1) {
		var _names1 = variable_struct_get_names(struct1);
		var _names2 = variable_struct_get_names(struct2);
		var _size1 = array_length(_names1);
		var _size2 = array_length(_names2);
		var _total = (_size1+_size2);
		var _n = 0;
		
		for (var i = 0; i < _size1; ++i) {
			var _name1 = _names1[i];
			for (var j = 0; j < _size2; ++j) {
				var _name2 = _names2[i];
				if (_name1 == _name2) {
					_n += 1;
				}
			}
		}
		if (_n >= _total) {
			_equal = true;
		}
	}
	return _equal;
}

// compare if a struct has variables and values equal to another
function struct_compare_vars(struct1, struct2) {
	var _s1 = json_stringify(struct1);
	var _s2 = json_stringify(struct2);
	var _equal = (_s1 == _s2) ? true : false;
	return _equal;
}

// add variable to struct
function struct_push(struct, name, value) {
	var _num = 0;
	if variable_struct_exists(struct, name) {
		while (variable_struct_exists(struct, name+string(_num))) {
			_num += 1;
		}
	} else {
		_num = "";
	}
	struct[$ name+string(_num)] = value;
}

// get and remove this variable from struct
function struct_pop(struct, name) {
	var _value = struct[$ name];
	variable_struct_remove(struct, name);
	return _value;
}

// get value from json without returning undefined
function struct_var_read(struct, name, default_var) {
	var _df = default_var;
	if variable_struct_exists(struct, name) {
		var _val = struct[$ name];
		if !is_undefined(_val) {
			return _val;
		}
	}
	return _df;
}

// check if struct child or variable exists
function struct_child_exists(struct, name) {
	return (variable_struct_exists(struct, name) ||
	is_struct(struct[$ name])) ? true : false;
}


/*-------------------------------------------------------
	Compatibility functions with ds_maps
	I don't recommend using ds_maps anymore, use structs!
-------------------------------------------------------*/

function ds_map_from_struct(struct) {
	var _ds_map = ds_map_create();
	var _keys = variable_struct_get_names(struct);
	for (var i = 0; i < array_length(_keys); i++) {
		var _key = _keys[i];
		var _value = variable_struct_get(struct, _key);
		ds_map_add(_ds_map, _key, _value);
	}
	return _ds_map;
}

function struct_from_map(ds_map) {
	var _struct = {};
	var _keys = ds_map_keys_to_array(ds_map);
	for (var i = 0; i < array_length(_keys); i++) {
		var _key = _keys[i];
		var _value = ds_map_find_value(ds_map, _key);
		variable_struct_set(_struct, _key, _value);
	}
	return _struct;
}

function struct_from_array(array) {
	var _struct = {};
	for (var i = 0; i < array_length(array); i++) {
		variable_struct_set(_struct, i, array[i]);
	}
	return _struct;
}

function struct_from_instancevars(instanceid) {
	var _struct = {};
	var _keys = variable_instance_get_names(instanceid);
	for (var i = 0; i < array_length(_keys); i++) {
		var _key = _keys[i];
		var _value = variable_instance_get(instanceid, _key);
		variable_struct_set(_struct, _key, _value);
	}
	return _struct;
}
