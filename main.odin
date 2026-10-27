package struct_reflection

import "core:fmt"
import "core:reflect"

Foo :: struct {
	a: u32,
	b: f64,
	c: f32,
}

main :: proc() {
	foo := Foo {
		a = 42,
		b = 3.1415,
		c = 6.7,
	}
	foo_ptr := uintptr(&foo)

	foo_info := reflect.type_info_base(type_info_of(Foo)).variant.(reflect.Type_Info_Struct)
	for i in 0 ..< foo_info.field_count {
		field_offset := foo_info.offsets[i]
		field_type := foo_info.types[i]

		field_ptr := foo_ptr + field_offset

		switch field_type.id {
		case u32:
			field_ptr := cast(^u32)field_ptr
			fmt.println(field_ptr^)
		case f32:
			field_ptr := cast(^f32)field_ptr
			fmt.println(field_ptr^)
		case f64:
			field_ptr := cast(^f64)field_ptr
			fmt.println(field_ptr^)
		}
	}
}
