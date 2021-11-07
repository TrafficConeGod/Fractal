#version 330 core

in vec2 uv;

out vec3 color;

vec2 ComplexAdd(vec2 c1, vec2 c2) {
	return vec2(c1.x + c2.x, c1.y + c2.y);
}

vec2 ComplexMultiply(vec2 c1, vec2 c2) {
	float r0 = c1.x * c2.x;
    float i0 = c1.x * c2.y;
    float i1 = c1.y * c2.x;
    float r1 = -(c1.y * c2.y);
    return vec2(r0 + r1, i0 + i1);
}

float ComplexMagnitude(vec2 c) {
	return sqrt((c.x * c.x) + (c.y * c.y));
}

const int MaxIterations = 100;

bool Fractal(vec2 c, vec2 z, int iter) {
	while (iter < MaxIterations) {
		float radius = ComplexMagnitude(z);
		if (radius >= 2) {
			return false;
		}
		z = ComplexAdd(ComplexMultiply(z, z), c);
		iter++;
	}
	return true;
}

void main() {
	if (Fractal(uv, uv, 0)) {
		color = vec3(0, 0, 0);
	} else {
		color = vec3(1, 1, 1);
	}

	// color = vec3(uv.x, uv.y, 0.0);
}