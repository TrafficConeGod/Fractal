#version 330 core

in vec2 uv;
in vec2 mousePosition;

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

const int MaxIterations = 1000;

int Fractal(vec2 c, vec2 z, int iter) {
	while (iter < MaxIterations) {
		float radius = ComplexMagnitude(z);
		if (radius >= 2) {
			return iter;
		}
		z = ComplexAdd(ComplexMultiply(z, z), c);
		iter++;
	}
	return -1;
}

#define RgbFactor 0.00392156862

const vec3 Palette[16] = vec3[16](
	vec3(66*RgbFactor, 30*RgbFactor, 15*RgbFactor),
    vec3(25*RgbFactor, 7*RgbFactor, 26*RgbFactor),
    vec3(9*RgbFactor, 1*RgbFactor, 47*RgbFactor),
    vec3(4*RgbFactor, 4*RgbFactor, 73*RgbFactor),
    vec3(0*RgbFactor, 7*RgbFactor, 100*RgbFactor),
    vec3(12*RgbFactor, 44*RgbFactor, 138*RgbFactor),
    vec3(24*RgbFactor, 82*RgbFactor, 177*RgbFactor),
    vec3(57*RgbFactor, 125*RgbFactor, 209*RgbFactor),
    vec3(134*RgbFactor, 181*RgbFactor, 229*RgbFactor),
    vec3(211*RgbFactor, 236*RgbFactor, 248*RgbFactor),
    vec3(241*RgbFactor, 233*RgbFactor, 191*RgbFactor),
    vec3(248*RgbFactor, 201*RgbFactor, 95*RgbFactor),
    vec3(255*RgbFactor, 170*RgbFactor, 0*RgbFactor),
    vec3(204*RgbFactor, 128*RgbFactor, 0*RgbFactor),
    vec3(153*RgbFactor, 87*RgbFactor, 0*RgbFactor),
    vec3(106*RgbFactor, 52*RgbFactor, 3*RgbFactor)
);

void main() {
	vec2 c = vec2((uv.x * 1.77777777778) * 2, uv.y * 2);

	int iter = Fractal(mousePosition, c, 0);
	if (iter == -1) {
		color = vec3(0, 0, 0);
	} else {
		int index = iter;
		if (index >= 16) {
			index = 15;
		}
		color = Palette[index];
	}
}