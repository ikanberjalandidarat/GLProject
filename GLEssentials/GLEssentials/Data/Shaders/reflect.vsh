/*
     File: reflect.vsh
 Abstract: The vertex shader for reflection rendering.
  Version: 1.8
 
 */

#ifdef GL_ES
precision highp float;
#endif

uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

// Declare inputs and outputs
// inPosition : Position attribute from the VAO/VBOs
// inNormal : Normal attribute from the VAO/VBOs
// varNormal : Normalized normal value passed to the rasterizer and used
//             to compute the reflection texture coordinates the fragment shader
// verEyeDir : Direction of the eye is facing which we derive from the modelview
//              matrix.  This is passed to the rasterizer and used to compute
//              the reflection texture coordinate in the fragment shader
// gl_Position : Implicitly declared in all vertex shaders.  The clip space
//               position passed to rasterizer used to build the triangles

#if __VERSION__ >= 140
in vec3  inNormal;
in vec4  inPosition;
out vec3 varNormal;
out vec3 varEyeDir;
#else
attribute vec3 inNormal;
attribute vec4 inPosition;
varying vec3  varNormal;
varying vec3  varEyeDir;
#endif

void main (void)
{	
	gl_Position	= modelViewProjectionMatrix * inPosition;
	vec4 eyePos = modelViewMatrix * inPosition;
	
	varNormal = normalize(normalMatrix * inNormal);
	varEyeDir = eyePos.xyz;
}
