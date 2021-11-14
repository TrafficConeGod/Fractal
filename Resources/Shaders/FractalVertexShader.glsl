#version 330 core

layout(location = 0) in vec2 vertexPosition;

uniform vec2 inMousePosition;

out vec2 uv;
out vec2 mousePosition;

void main() {
    gl_Position = vec4(vertexPosition, 0.0, 1.0);
    uv = vertexPosition;
    mousePosition = inMousePosition;
}