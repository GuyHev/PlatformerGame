shader_type canvas_item;

uniform vec4 color = vec4(0.0, 0.4, 1.0, 0.5);
uniform float wave_speed = 2.0;
uniform float wave_height = 5.0;
uniform float wave_length = 20.0;

void fragment() {
    vec2 uv = UV;

    float texture_height = float(textureSize(TEXTURE, 0).y);
    float wave_zone = smoothstep(0.1, 0.0, uv.y);
    float wave = sin((uv.x * wave_length + TIME * wave_speed) * 6.28318) * wave_height / texture_height;
    float wave_mask = smoothstep(wave, 0.0, uv.y) * wave_zone;

    float alpha = color.a * max(wave_mask, 0.3);

    COLOR = vec4(color.rgb, alpha);
}
