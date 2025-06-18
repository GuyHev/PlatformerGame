shader_type canvas_item;

uniform float wave_amplitude = 4.0;  // Wave height in pixels
uniform float wave_frequency = 10.0; // Number of waves
uniform float wave_speed = 2.0;      // Animation speed
uniform vec4 rope_color : source_color = vec4(0.5, 0.3, 0.2, 1.0); // Brown rope color

void fragment() {
    // Calculate sine wave offset
    float offset = sin(UV.y * wave_frequency + TIME * wave_speed) * wave_amplitude;
    
    // Apply distortion to horizontal UV (X axis)
    vec2 wavy_uv = UV;
    wavy_uv.x += offset / SCREEN_PIXEL_SIZE.x;

    // Solid rope color (no texture)
    COLOR = rope_color;
}
