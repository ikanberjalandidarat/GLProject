/*

 Abstract:
 Functions for loading source files for shaders.
 */


#ifndef __SOURCE_UTIL_H__
#define __SOURCE_UTIL_H__

#include "glUtil.h"

typedef struct demoSourceRec
{
	GLchar* string;
	
	GLsizei byteSize;
	
	GLenum shaderType; // Vertex or Fragment
	
} demoSource;

demoSource* srcLoadSource(const char* filepathname);

void srcDestroySource(demoSource* source);

#endif // __SOURCE_UTIL_H__
