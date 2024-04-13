shader_type spatial;
// Uniforms
// Global Uniforms
global uniform sampler2D heightmap;
global uniform sampler2D normalmap;
global uniform float amplitude;
global uniform vec3 clipmap_position;
global uniform float clipmap_partition_length;
global uniform float lod_step;
// Adds Shader Parameters
uniform sampler2D grass_texture: source_color;
uniform sampler2D rock_texture: source_color;
uniform sampler2D sand_texture: source_color;
// Uniform Floats
uniform float min_rock_slope: hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float max_grass_slope: hint_range(0.0, 1.0, 0.01) = 0.9;
uniform float min_rockgrass_height: hint_range(2, 25, 0.1) = 3;
uniform float max_sand_height: hint_range(2, 25, 0.1) = 10;
// Varying Floats
varying float vertex_y;
varying vec2 normalmap_position;
varying vec3 vert_norms;

float true_round(float value){
	return floor(value + 0.5);
}

float get_height(vec3 world_vertex){
	vec2 heightmap_position = (world_vertex.xz + 0.5) / float(textureSize(heightmap, 0).x);
	return texture(heightmap, heightmap_position).r * amplitude;
}

vec3 get_normal(vec3 vertex, float adjacent_distance){
	vec3 west_vert = vertex + vec3(adjacent_distance, 0, 0);
	west_vert.y = get_height(west_vert);
	vec3 north_vert = vertex + vec3(0, 0, adjacent_distance);
	north_vert.y = get_height(north_vert);
	return normalize(
		cross(
			north_vert - vertex,
			west_vert - vertex
		)
	);
}

vec3 to_normalmap(vec3 n){
	n *= vec3(1.0, 1.0, -1.0);
	n = n / 2.0 + 0.5;
	n = vec3(n.x, n.z, n.y);
	return n;
}

void vertex() {
	// Called for every vertex the material is visible on.
	vec3 world_vertex = VERTEX + MODEL_MATRIX[3].xyz;
	normalmap_position = (world_vertex.xz + 0.5) / float(textureSize(heightmap, 0).x);
	VERTEX.y = get_height(world_vertex);
	
	vec3 clipmap_vertex = world_vertex - clipmap_position;
	float lod = true_round(max(abs(clipmap_vertex.x), abs(clipmap_vertex.z)) / clipmap_partition_length) * lod_step;
	
	float subdivision_length = min(pow(2, lod), clipmap_partition_length);
	
	vec3 fraction = fract((VERTEX + clipmap_partition_length / 2.0) / subdivision_length); 

	VERTEX.y = mix(
		mix(
			get_height(world_vertex - vec3(fraction.x * subdivision_length, 0, 0)),
			get_height(world_vertex + vec3((1.0 - fraction.x) * subdivision_length, 0, 0)),
			fraction.x
		),
		mix(
			get_height(world_vertex - vec3(0, 0, fraction.z * subdivision_length)),
			get_height(world_vertex + vec3(0, 0, (1.0 - fraction.z) * subdivision_length)),
			fraction.z
		),
		ceil(fraction.z)
	);
	
	vertex_y = VERTEX.y;
	vert_norms = world_vertex;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 interpolated_vert = vert_norms;
	interpolated_vert.y = get_height(vert_norms);
	vec3 normal = get_normal(interpolated_vert, 1.0);
	NORMAL_MAP = to_normalmap(normal);

	// Albedo Values
	vec3 grass_albedo = texture(grass_texture, UV * 4.0).xyz;
	vec3 rock_albedo = texture(rock_texture, UV * 4.0).xyz;
	vec3 sand_albedo = texture(sand_texture, UV * 4.0).xyz;
	// Weights
	float rock_grass_weight = normal.y;
	float sand_rockgrass_weight = vertex_y;
	// Calculating Rock/Grass Weight
	rock_grass_weight = max(min_rock_slope, rock_grass_weight);
	rock_grass_weight = min(max_grass_slope, rock_grass_weight);
	rock_grass_weight -= min_rock_slope;
	rock_grass_weight /= max_grass_slope - min_rock_slope;
	// Calculating Sand/Rock/Grass Weight
	sand_rockgrass_weight = max(min_rockgrass_height, sand_rockgrass_weight);
	sand_rockgrass_weight = min(max_sand_height, sand_rockgrass_weight);
	sand_rockgrass_weight -= min_rockgrass_height;
	sand_rockgrass_weight /= max_sand_height - min_rockgrass_height;
	// Mix Shades
	vec3 rockgrass_albedo = mix(rock_albedo, grass_albedo, rock_grass_weight);
	ALBEDO = mix(sand_albedo, rockgrass_albedo, sand_rockgrass_weight);
}