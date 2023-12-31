#define PROCESSING_TEXLIGHT_SHADER

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform int lightCount;
uniform vec4 lightPosition[8];
uniform vec3 lightDiffuse[8];
uniform vec3 lightAmbient[8];
uniform vec3 lightSpecular[8];
uniform float shininess[8]; // Utilisez un tableau pour stocker la shininess pour chaque lumière
uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertEmissive;
varying float vertShininess;
varying vec3 ecNormal;
varying vec3 ecPosition;
varying vec2 uv;

float lambertFactor(vec3 lightDir, vec3 vecNormal) {
    return max(0.0, dot(lightDir, vecNormal));
}

float blinnPhongFactor(vec3 lightDir, vec3 vecNormal, float shininess) {
    vec3 halfVec = normalize(lightDir + normalize(ecPosition));
    return pow(max(0.0, dot(halfVec, vecNormal)), shininess);
}

void main() {
    vec3  dfColor  = vec3(0);
    vec3  amColor  = vec3(0);
    vec3  spColor  = vec3(0);
    vec3  normal   = normalize(ecNormal);
    vec4  texColor = texture2D(texture, uv.st);

    if(vertEmissive.x > 0 || vertEmissive.y > 0 || vertEmissive.z > 0) {
        gl_FragColor = vertEmissive;
    } else {
        for(int i=0; i<lightCount; i++) {
            vec3  lightDir  = normalize(lightPosition[i].xyz - ecPosition);
            float intensity = lambertFactor(lightDir, normal);
            float spec      = blinnPhongFactor(lightDir, normal, shininess[i]);
        
            dfColor += vertColor.rgb * texColor.rgb * lightDiffuse[i] * intensity;
            spColor += lightSpecular[i] * spec;
            amColor += lightAmbient[i];
        }

        gl_FragColor = vec4(dfColor + amColor + spColor, vertColor.a * texColor.a);
    }
}
