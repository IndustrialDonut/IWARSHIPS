shader_type spatial;

uniform sampler2D noise;

render_mode blend_mix;

float height(float x, float z, float time){
	// I take it the texture just wraps around when the sample points goes out of bounds
	float wind = 0.1f * texture(noise, vec2(x,z) + time/80f).x;
	
	float main_waves = 0.5f * sin(x / 20f + time/3f) * cos(z / 25f + time/4f);
	
	return main_waves + wind;
}

void vertex() {
	
	float h = height(VERTEX.x, VERTEX.z, TIME);
	
	VERTEX.y += h;
	
	// Somehow all of this is just simplified by the one-liner below, not sure if that's an approximation
	// or how it works but it gives the same visual result.
	//vec3 dx = vec3(VERTEX.x + 0.5f, height(VERTEX.x + 0.5f, VERTEX.z, TIME), VERTEX.z) - VERTEX;
	//vec3 dz = vec3(VERTEX.x, height(VERTEX.x, VERTEX.z + 0.5f, TIME), VERTEX.z + 0.5f) - VERTEX;
	
	//vec3 normal = normalize(cross(dz, dx));
	
	//NORMAL = normal; 
	
	vec3 normal = normalize(vec3(h - height(VERTEX.x + 0.2, VERTEX.z, TIME), 0.2, h - height(VERTEX.x, VERTEX.z + 0.2, TIME)));
	NORMAL = normal;
}

void fragment() {
	float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));
	RIM = 0.3;
	METALLIC = 0.0;
	ROUGHNESS = 0.01 * (1.0 - fresnel);
	//ALBEDO = vec3(0.005, 0.007, 0.04) + (0.1 * fresnel);
	ALBEDO = vec3(0, 0, 0.001);// + (0.1 * fresnel);
	ALPHA = 0.95;
	
}