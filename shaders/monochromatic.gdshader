shader_type canvas_item;

uniform float opacity = 1.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);

    // Convert RGB to luminance
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    COLOR = vec4(vec3(gray), color.a * opacity);
}