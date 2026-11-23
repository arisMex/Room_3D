// Éclairage par pixel (Blinn-Phong) avec textures — fragments.
// Lumières ponctuelles atténuées, directionnelles et ambiantes de Processing,
// émission (écrans, plafonniers, extérieur) et compression douce des hautes lumières.
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define MAX_LIGHTS 8

uniform sampler2D texture;
uniform vec2 resolution;
uniform float exposition;

uniform int lightCount;
uniform vec4 lightPosition[MAX_LIGHTS];
uniform vec3 lightNormal[MAX_LIGHTS];
uniform vec3 lightAmbient[MAX_LIGHTS];
uniform vec3 lightDiffuse[MAX_LIGHTS];
uniform vec3 lightSpecular[MAX_LIGHTS];
uniform vec3 lightFalloff[MAX_LIGHTS];

varying vec4 vertColor;
varying vec4 vertSpecular;
varying vec4 vertEmissive;
varying float vertShininess;
varying vec3 ecNormal;
varying vec3 ecPosition;
varying vec4 vertTexCoord;

vec3 compresser(vec3 c) {
  // linéaire jusqu'à 0.8 puis rapprochement progressif de 1.0
  vec3 haut = 0.8 + 0.2 * (1.0 - exp(-(c - 0.8) * 5.0));
  return mix(c, haut, step(0.8, c));
}

void main() {
  vec4 tex = texture2D(texture, vertTexCoord.st);
  vec4 base = tex * vertColor;
  float alpha = tex.a * vertColor.a;
  if (alpha < 0.02) discard;

  vec3 N = normalize(ecNormal);
  vec3 V = normalize(-ecPosition);
  if (dot(N, V) < 0.0) N = -N;  // faces vues de dos (plans fins)

  vec3 amb = vec3(0.0), dif = vec3(0.0), spe = vec3(0.0);
  for (int i = 0; i < MAX_LIGHTS; i++) {
    if (i >= lightCount) break;
    vec3 L;
    float att = 1.0;
    if (lightPosition[i].w == 0.0) {
      L = -normalize(lightNormal[i]);
    } else {
      vec3 d = lightPosition[i].xyz - ecPosition;
      float dist = length(d);
      L = d / dist;
      att = 1.0 / dot(lightFalloff[i], vec3(1.0, dist, dist * dist));
    }
    amb += lightAmbient[i] * att;
    float nl = max(dot(N, L), 0.0);
    dif += lightDiffuse[i] * nl * att;
    if (nl > 0.0) {
      vec3 H = normalize(L + V);
      spe += lightSpecular[i] * pow(max(dot(N, H), 0.0), max(vertShininess, 1.0)) * att;
    }
  }

  vec3 c = base.rgb * (amb + dif) + spe * vertSpecular.rgb + tex.rgb * vertEmissive.rgb;
  c = compresser(c * exposition);

  // léger vignettage
  vec2 p = gl_FragCoord.xy / resolution - 0.5;
  c *= 1.0 - 0.35 * dot(p, p);

  gl_FragColor = vec4(c, alpha);
}
