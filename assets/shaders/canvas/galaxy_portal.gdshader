shader_type canvas_item;

render_mode blend_mix;

uniform float round_variant_1: hint_range(0.0, 1000.0, 0.5) = 13.0;
uniform float round_variant_2: hint_range(0.0, 1000.0, 0.5) = 14.5;

uniform float time_color_1: hint_range(0.0, 1000.0, 0.1) = 0.2;
uniform float time_color_2: hint_range(0.0, 1000.0, 0.1) = 0.3;

uniform float detail: hint_range(0.0, 1.5, 0.001) = 0.659;

uniform float g: hint_range(0.0, 1.5, 0.001) = 0.7;
uniform float b: hint_range(0.0, 1.5, 0.001) = 0.5;
uniform float r: hint_range(0.0, 1.5, 0.001) = 0.9;

uniform float center_size: hint_range(0.0, 10.0, 0.001) = 0.85;
uniform float spectrum_variant: hint_range(0.0, 8.0, 0.001) = 1.5;
uniform float from_middle_color_range: hint_range(0.0, 1.2, 0.001) = 0.2;
uniform float radius_color_range_ratio: hint_range(-0.5, 1.2, 0.001) = 0.0;

uniform float transparency: hint_range(0.0, 1.0, 0.01) = 0.08;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = (FRAGCOORD.xy / iResolution.xy) - .5;
	float t = TIME * 2.5 + ((.25 + .05 * sin(TIME * .1))/(length(uv.xy) + .07)) * 2.2;
	float si = sin(t);
	float co = cos(t);
	mat2 ma = mat2(vec2(co, si), vec2(-si, co));

	float v1, v2, v3;
	v1 = v2 = v3 = 0.0;
	
	float s = 0.0;
	for (int i = 0; i < 90; i++)
	{
		vec3 p = s * vec3(uv, 0.0);
		p.xy *= ma;
		p += vec3(.22, .3, s - 1.5 - sin(TIME * .13) * .1);
		for (int i = 0; i < 8; i++)	p = abs(p) / dot(p,p) - detail;
		v1 += dot(p,p) * .0015 * (1.8 + sin(length(uv.xy * round_variant_1) + .5  - TIME * time_color_1));
		v2 += dot(p,p) * .0013 * (1.5 + sin(length(uv.xy * round_variant_2) + 1.2 - TIME * time_color_2));
		v3 += length(p.xy * 10.0) * .0003;
		s  += .035;
	}
	
	float len = length(uv);
	v1 *= smoothstep(g, .0, len);
	v2 *= smoothstep(b, .0, len);
	v3 *= smoothstep(r, .0, len);
	
	vec3 col = vec3( v3 * (spectrum_variant + sin(TIME * .2) * .4),
					(v1 + v3) * from_middle_color_range,
					 v2) + smoothstep(0.2, radius_color_range_ratio, len) * center_size + smoothstep(.0, .6, v3) * .3;

	COLOR=vec4(min(pow(abs(col), vec3(1.2)), 1.0), transparency);
	
}