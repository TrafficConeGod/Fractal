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

const int MaxIterations = 10000;

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

vec3 LerpVector(vec3 a, vec3 b, float t) {
	return a + (b - a) * t;
}

const vec3 Palette[16] = vec3[16](
	vec3(66*0.00392156862, 30*0.00392156862, 15*0.00392156862),
    vec3(25*0.00392156862, 7*0.00392156862, 26*0.00392156862),
    vec3(9*0.00392156862, 1*0.00392156862, 47*0.00392156862),
    vec3(4*0.00392156862, 4*0.00392156862, 73*0.00392156862),
    vec3(0*0.00392156862, 7*0.00392156862, 100*0.00392156862),
    vec3(12*0.00392156862, 44*0.00392156862, 138*0.00392156862),
    vec3(24*0.00392156862, 82*0.00392156862, 177*0.00392156862),
    vec3(57*0.00392156862, 125*0.00392156862, 209*0.00392156862),
    vec3(134*0.00392156862, 181*0.00392156862, 229*0.00392156862),
    vec3(211*0.00392156862, 236*0.00392156862, 248*0.00392156862),
    vec3(241*0.00392156862, 233*0.00392156862, 191*0.00392156862),
    vec3(248*0.00392156862, 201*0.00392156862, 95*0.00392156862),
    vec3(255*0.00392156862, 170*0.00392156862, 0*0.00392156862),
    vec3(204*0.00392156862, 128*0.00392156862, 0*0.00392156862),
    vec3(153*0.00392156862, 87*0.00392156862, 0*0.00392156862),
    vec3(106*0.00392156862, 52*0.00392156862, 3*0.00392156862)
);

void main() {
	vec2 c = vec2((uv.x * 1.77777777778) * 2, uv.y * 2);

	int iter = Fractal(c, c, 0);
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