#include "GLUtils.h"
#include <iostream>
#include <vector>

std::vector<float> screenQuad = {
    //
    -1, -1,
    1, -1,
    -1, 1,
    //
    1, 1,
    1, -1,
    -1, 1,
    //
};

int main() {
    if (!glfwInit()) {
        throw std::runtime_error("Failed to initialize GLFW");
    }
    glfwWindowHint(GLFW_SAMPLES, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    GLFWwindow* win = glfwCreateWindow(1280, 720, "Test", NULL, NULL);
    if (win == NULL) {
        glfwTerminate();
        throw std::runtime_error("Failed to open GLFW window");
    }
    glfwMakeContextCurrent(win);
    glewExperimental = true;
    if (glewInit() != GLEW_OK) {
        throw std::runtime_error("Failed to initialize GLEW");
    }

    glfwSetInputMode(win, GLFW_STICKY_KEYS, GL_TRUE);

    glClearColor(44.f/256.f, 157.f/256.f, 222.f/256.f, 0.0f);

    GLuint vertexArrayId;
    glGenVertexArrays(1, &vertexArrayId);
    glBindVertexArray(vertexArrayId);


    GLuint programId = LoadShaders("Resources/Shaders/FractalVertexShader.glsl", "Resources/Shaders/FractalFragmentShader.glsl");

    GLuint mousePositionId = glGetUniformLocation(programId, "inMousePosition");

    GLuint vertexId;
    glGenBuffers(1, &vertexId);

    // render
    for (;;) {
        double mouseX;
        double mouseY;
        glfwGetCursorPos(win, &mouseX, &mouseY);

        mouseX /= 1280;
        mouseY /= 720;

        mouseX -= 0.5;
        mouseY -= 0.5;
        mouseX *= 2;
        mouseY *= 2;

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUseProgram(programId);

        glUniform2f(mousePositionId, mouseX, mouseY);

        glEnableVertexAttribArray(0);
        glBindBuffer(GL_ARRAY_BUFFER, vertexId);
        glBufferData(GL_ARRAY_BUFFER, screenQuad.size() * sizeof(float), screenQuad.data(), GL_STATIC_DRAW);
        glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, 0);
        
        glDrawArrays(GL_TRIANGLES, 0, screenQuad.size());

        glDisableVertexAttribArray(0);
    //

        glfwSwapBuffers(win);
	    glfwPollEvents();

        if (glfwWindowShouldClose(win)) {
            break;
        }
    }

    return 0;
}