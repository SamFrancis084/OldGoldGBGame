shader_type canvas_item;

uniform bool active = false;
uniform vec4 tint : source_color = vec4(0.054, 0.026, 0.025, 1);

void fragment() {
	vec4 tint_copy = tint;
	vec4 previous_color = texture(TEXTURE, UV);
	
	if (active == true)
	{
		tint_copy.a = previous_color.a;
		COLOR = tint_copy;
	}
}