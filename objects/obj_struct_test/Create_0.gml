
// ### Struct Operations ###
print("-------------------------------------------------");
global.main_struct = {
	highscores : [
		{name : "George", points : 100},
		{name : "Jack", points : 200},
		{name : "Foxy", points : 335},
	],
	funct : function() {
		var test = true;
	},
	data : {
		icon : "gamemaker",
		url : "https://website.com",
	},
	value : 150,
}

struct_test = {
	EXISTING_VAR : 99999,
}
print("Original Struct 1: ", global.main_struct);
print("Original Struct 2: ", struct_test);


// copy
struct_copy(global.main_struct, struct_test);
print("Copied struct: ", struct_test);

// compare
var test = struct_compare(global.main_struct, struct_test);
print("Equal? ", test);

// struct clear
struct_clear(struct_test);
print("Struct cleared: ", struct_test);

// struct push
var _test_name = "enemies";
var _test_vars = ["robot", "village", "wolf"];
struct_push(struct_test, _test_name, _test_vars);
print("Struct push: ", struct_test);

// struct push the same value
var _struct = {
	aa : 10,
	bb : 20,
	cc : 30,
}
struct_push(_struct, "score", 99);
struct_push(_struct, "score", 99);
struct_push(_struct, "score", 99);
print("Struct push, same value", _struct);

// compare vars
var test = struct_compare_vars(global.main_struct, struct_test);
print("Struct and variables equal? ", test);

// struct replace
struct_replace(global.main_struct, struct_test);
print("Struct Replace: ", struct_test);

// struct multiply
var _original = {
	aa : 10,
}
var s1 = {};
var s2 = {};
var s3 = {};
struct_multiply(_original, [s1, s2, s3]);
print("Struct Multiply: ", s1, s2, s3);

// struct pop
var _struct = {
	number1 : 100,
	str1 : "test",
	arrayy : [50, 350, 88],
	letters : {
		aa : 5,
		bb : 6,
		cc : 7,
	}
}

print("Struct Pop, before: ", _struct);
var test = struct_pop(_struct, "arrayy");

print("Struct Pop, variable: ", test);
print("Struct Pop, after: ", _struct);

var test = struct_pop(_struct.letters, "bb");
print("Popped child variable: ", test);

print("Struct Pop, after all: ", _struct);


// for loading game data
my_apples = 0;
my_oranges = 0;
my_potatoes = 0;
my_array = [];

var _json = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000 }, \"myArray\":[0, 1, 2]}";
var _data = json_parse(string(_json));

if struct_child_exists(_data, "myObj") {
	var _struct = _data.myObj;
	my_apples = struct_var_read(_struct, "apples", my_apples);
	my_oranges = struct_var_read(_struct, "oranges", my_oranges);
	my_potatoes = struct_var_read(_struct, "potatoes", my_potatoes);
}
		
if struct_child_exists(_data, "myArray") {
	var _struct = _data.myArray;
	my_array = _struct;
}

print("Vars: ", my_apples, my_oranges, my_potatoes, "-", "Array: ", my_array);
