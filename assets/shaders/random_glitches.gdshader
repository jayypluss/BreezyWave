/*
	ゆらゆらシェーダー by あるる（きのもと 結衣）
	Yurayura Shader by Yui Kinomoto @arlez80

	MIT License
*/
shader_type spatial;
// render_mode;

uniform float speed = 0.6;
uniform float ring_scale = 2.0;
uniform float wave_scale = 1.65;
uniform float random_scale = 6.9;
uniform float noise_scale = 0.0;


vec3 hsv2rgb( float h, float s, float v )
{
	return (
		(clamp(abs(fract(h + vec3( 0.0, 2.0, 1.0 ) / 3.0 ) * 6.0 - 3.0 ) - 1.0,	0.0, 1.6) - 1.0) * s + 1.0) * s;
}

vec2 random( vec2 pos )
{
	return fract(
		sin(
			vec2(
				dot(pos, vec2(12.9898,78.233))
			,	dot(pos, vec2(-148.998,-65.233))
			)
		) * 43758.5453
	);
}

float value_noise( vec2 pos )
{
	vec2 p = floor( pos );
	vec2 f = fract( pos );

	float v00 = random( p + vec2( 0.0, 0.0 ) ).x;
	float v10 = random( p + vec2( 1.0, 0.0 ) ).x;
	float v01 = random( p + vec2( 0.0, 1.0 ) ).x;
	float v11 = random( p + vec2( 1.0, 1.0 ) ).x;

	vec2 u = f * f * ( 3.0 - 2.0 * f );

	return mix( mix( v00, v10, u.x ), mix( v01, v11, u.x ), u.y );
}

void fragment( )
{
	vec2 shift_uv = UV;
	shift_uv.x += value_noise( UV * random_scale + sin( TIME * speed ) );
	shift_uv.y += sin( cos( TIME ) * speed );
	float x = shift_uv.x + sin( shift_uv.y * wave_scale );
	float f = mod( x * ring_scale + random( UV ).x * noise_scale, 1.0 );

	ALBEDO = hsv2rgb( f, 1.0, 1.0 );
	EMISSION = vec3(0.0, 0.0, 0.0);
}

void light() {
    DIFFUSE_LIGHT = vec3(0.25, 0.25, 0.25);
	// Remove specular light for rainbow RGB
    SPECULAR_LIGHT = vec3(0.1, 0.1, 1.0);
//    SPECULAR_LIGHT = vec3(0.0, 0.0, 0.0);
}