shader_type canvas_item;


uniform float pixelFactor = 320; //: //hint_range(1.0, 1024, 1)
uniform float colorFactor : hint_range(1.0, 16.0) = 4.0;
uniform float brightNessFactor = 0.2;
uniform float ditherScale = 0.005;

void fragment()
{
	const mat4 ditherTable = mat4(
    	vec4(-4.0, 0.0, -3.0, 1.0),
    	vec4(2.0, -2.0, 3.0, -1.0),
	    vec4(-3.0, 1.0, -4.0, 0.0),
    	vec4(3.0, -1.0, 2.0, -2.0)
	);
	
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 size =  pixelFactor * iResolution.xy / iResolution.x;
	vec2 coor = floor(FRAGCOORD.xy / iResolution.xy * size);
	
	//
	vec3 color = texture(TEXTURE, UV).xyz;
	
	color += ditherTable[int(coor.x) % 4][int(coor.y) % 4] * ditherScale;
	
	color = 1.01f * brightNessFactor + floor(color * colorFactor) / colorFactor;
	
	COLOR = vec4(color.xyz,1.0);
}