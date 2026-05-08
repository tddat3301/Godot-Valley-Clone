shader_type canvas_item;
uniform float progress: hint_range(0.0, 1.0);
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float ratio = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
	vec2 adjusted_uv = vec2(mix(0.5, UV.x, ratio),UV.y);
	float circle = distance(vec2(0.5), adjusted_uv);
	COLOR.a = step(1.5 - progress*1.5, circle);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
