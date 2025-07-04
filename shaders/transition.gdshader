shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0);
uniform vec4 fill_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec2 resolution = vec2(64.0, 64.0); // Set to the size of the node in pixels

void fragment() {
    // Snap UV to nearest pixel center
    vec2 pixel_uv = floor(UV * resolution) / resolution;

    // Center UV to (-0.5, -0.5) to (0.5, 0.5)
    vec2 uv = pixel_uv - vec2(0.5);

    float angle = atan(uv.y, uv.x); // range: -PI to PI
    float norm_angle = (angle + 3.14159265) / (2.0 * 3.14159265); // normalize to 0..1

    if (progress == 0.0) {
        COLOR = vec4(0.0); // fully transparent
    } else if (progress >= 1.0 || norm_angle <= progress) {
        COLOR = fill_color;
    } else {
        COLOR = vec4(0.0);
    }
}
