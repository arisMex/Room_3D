// Éclairage par pixel (Blinn-Phong) avec textures — sommets.
uniform mat4 modelviewMatrix;
uniform mat4 transformMatrix;
uniform mat3 normalMatrix;
uniform mat4 texMatrix;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;
attribute vec4 specular;
attribute vec4 emissive;
attribute float shininess;

varying vec4 vertColor;
varying vec4 vertSpecular;
varying vec4 vertEmissive;
varying float vertShininess;
varying vec3 ecNormal;
varying vec3 ecPosition;
varying vec4 vertTexCoord;

void main() {
  gl_Position   = transformMatrix * position;
  ecPosition    = vec3(modelviewMatrix * position);
  ecNormal      = normalize(normalMatrix * normal);
  vertColor     = color;
  vertSpecular  = specular;
  vertEmissive  = emissive;
  vertShininess = shininess;
  vertTexCoord  = texMatrix * vec4(texCoord, 1.0, 1.0);
}
