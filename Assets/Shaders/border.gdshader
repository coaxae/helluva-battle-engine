shader_type canvas_item;

uniform int quality;
uniform float level;
uniform float dark;
uniform float scale;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

void fragment() {
    vec4 output = texture(SCREEN_TEXTURE,vec2(0.5,0.5) * abs(scale - 1.0) + SCREEN_UV * scale);
    for (int i=0;i < quality;i++) {
        vec4 output2 = texture(SCREEN_TEXTURE,vec2(sin(float(i) * float(360 / quality)) * (level / 100.0),cos(float(i) * float(360 / quality)) * (level / 100.0)) + vec2(0.5,0.5) * abs(scale - 1.0) + SCREEN_UV * scale);
        output += output2;
    }
    vec4 output1 = texture(TEXTURE,UV);
    if (quality != 0) {
        output.rgb /= float(quality);
    }
    COLOR = vec4(output1.r + (output.r * (dark)),output1.g + (output.g * dark),output1.b + (output.b * dark),output1.a);
}

//void light() {
    // Called for every pixel for every light affecting the CanvasItem.
    // Uncomment to replace the default light processing function with this one.
//}