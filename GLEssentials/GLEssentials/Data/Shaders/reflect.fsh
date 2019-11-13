/*
     File: reflect.fsh
 Abstract: The fragment shader for reflection rendering.
  Version: 1.8
 */

#ifdef GL_ES
precision highp float;
#endif


const vec3 Xunitvec = vec3(1.0, 0.0, 0.0);
const vec3 Yunitvec = vec3(0.0, 1.0, 0.0);

// Color of tint to apply (blue)
const vec4 tintColor = vec4(0.0, 0.0, 1.0, 1.0);

// Amount of tint to apply
const float tintFactor = 0.2;

// Declare inputs and outputs
// varNormal : Normal for the fragment computed by the rasterizer based on the
//             varNormal value output in the vertex shader
// varEyeDir : EyeDir for the fragment computed by the rasterizer based on the
//             varEyeDir value output in the vertex shader
// gl_FragColor : Implicitly declare in fragments shaders less than 1.40.
//                The output color of our fragment.
// fragColor : Output color of our fragment.  Basically the same as gl_FragColor,
//             but we must explicitly declared this in shaders version 1.40 and
//             above.

#if __VERSION__ >= 140
in vec3       varNormal;
in vec3       varEyeDir;
out vec4      fragColor;
#else
varying vec3  varNormal;
varying vec3  varEyeDir;
#endif

uniform sampler2D diffuseTexture;

void main (void)
{
	// Compute reflection vector
    
    vec3 reflectDir = reflect(varEyeDir, varNormal);

    // Compute altitude and azimuth angles

    vec2 texcoord;

    texcoord.y = dot(normalize(reflectDir), Yunitvec);
    reflectDir.y = 0.0;
    texcoord.x = dot(normalize(reflectDir), Xunitvec) * 0.5;

    // Translate index values into proper range

    if (reflectDir.z >= 0.0)
        texcoord = (texcoord + 1.0) * 0.5;
    else
    {
        texcoord.t = (texcoord.t + 1.0) * 0.5;
        texcoord.s = (-texcoord.s) * 0.5 + 1.0;
    }
    
    // Do a lookup into the environment map.
  
	#if __VERSION__ >= 140
	vec4 texColor = texture(diffuseTexture, texcoord);
	#else
	vec4 texColor = texture2D(diffuseTexture, texcoord);
	#endif

    // Add some blue tint to the image so it looks more like a mirror or glass

	#if __VERSION__ >= 140
	fragColor    = mix(texColor, tintColor, tintFactor);
	#else
    gl_FragColor = mix(texColor, tintColor, tintFactor);
	#endif
}
