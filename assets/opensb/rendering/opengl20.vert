#version 110

uniform vec2 textureSize0;
uniform vec2 textureSize1;
uniform vec2 textureSize2;
uniform vec2 textureSize3;
uniform vec2 screenSize;
uniform mat3 vertexTransform;
uniform vec2 lightMapSize;
uniform vec2 lightMapScale;
uniform vec2 lightMapOffset;

attribute vec2 vertexPosition;
attribute vec2 vertexTextureCoordinate;
attribute float vertexTextureIndex;
attribute vec4 vertexColor;
attribute float vertexParam1;

varying vec2 fragmentTextureCoordinate;
varying float fragmentTextureIndex;
varying vec4 fragmentColor;
varying float fragmentLightMapMultiplier;
varying vec2 fragmentLightMapCoordinate;

void main() {
  vec2 screenPosition = (vertexTransform * vec3(vertexPosition, 1.0)).xy;
  fragmentLightMapMultiplier = vertexParam1;
  fragmentLightMapCoordinate = (screenPosition / lightMapScale) - lightMapOffset * lightMapSize / screenSize;
  if (vertexTextureIndex > 2.9) {
    fragmentTextureCoordinate = vertexTextureCoordinate / textureSize3;
  } else if (vertexTextureIndex > 1.9) {
    fragmentTextureCoordinate = vertexTextureCoordinate / textureSize2;
  } else if (vertexTextureIndex > 0.9) {
    fragmentTextureCoordinate = vertexTextureCoordinate / textureSize1;
  } else {
    fragmentTextureCoordinate = vertexTextureCoordinate / textureSize0;
  }
  fragmentTextureIndex = vertexTextureIndex;
  fragmentColor = vertexColor;
  gl_Position = vec4(screenPosition / screenSize * 2.0 - 1.0, 0.0, 1.0);
}