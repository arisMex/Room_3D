#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform int lightCount;
uniform vec4 lightPosition[8];
uniform vec3 lightDiffuse[8];

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;

float lambertFactor(vec3 lightDir, vec3 vecNormal) {
    return max(0.0, dot(lightDir, vecNormal));
}

void main() {
  gl_Position = transform * position;
  
  vec3  ecPosition = vec3(modelview * position);
  vec3  ecNormal   = normalize(normalMatrix * normal);
  vec3  dfColor    = vec3(0);

  for(int i=0; i<lightCount; i++) {
    vec3  direction = normalize(lightPosition[i].xyz - ecPosition);
    float intensity = lambertFactor(direction, ecNormal);
    
    dfColor += color.rgb * lightDiffuse[i] * intensity;
  }
  
  vertColor = vec4(dfColor, color.a);
}
