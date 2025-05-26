shader_type canvas_item;

uniform float time_speed = 1.0;
uniform float wave_strength = 1.0;
uniform float wave_frequency = 20.0;
uniform float opacity : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    // Slight horizontal UV shift for wave motion
    vec2 uv = UV;
    uv.y += sin(uv.x * wave_frequency + TIME * time_speed) * (wave_strength / 100.0);
    COLOR = texture(TEXTURE, uv);
    COLOR.a *= opacity;
}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//