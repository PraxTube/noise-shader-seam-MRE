#import bevy_pbr::{mesh_view_bindings::globals, forward_io::VertexOutput}

fn rand(uv: vec2<f32>) -> f32 {
    return (fract(sin(dot(uv.xy, vec2(23.53, 44.0))) * 42350.45));
}

fn noise(uv: vec2<f32>) -> f32 {
    let i: vec2<f32> = floor(uv);
    let j: vec2<f32> = fract(uv);
    let blur: vec2<f32> = smoothstep(vec2<f32>(0.0, 0.0), vec2<f32>(1.0, 1.0), j);

    let a: f32 = rand(i);
    let b: f32 = rand(i + vec2<f32>(1.0, 0.0));

    return mix(a, b, blur.x);
}

fn srgb2lin(color: vec3<f32>) -> vec3<f32> {
    let in_c_lo: vec3<f32> = color / 12.92;
    let in_c_hi: vec3<f32> = pow((color + 0.055) / 1.055, vec3<f32>(2.4));
    let in_s: vec3<f32> = step(vec3<f32>(0.04045), color);
    
    return mix(in_c_lo, in_c_hi, in_s);
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
    let UV: vec2<f32> = in.uv * 10.0;
    return vec4<f32>(srgb2lin(vec3<f32>(1.0) * noise(UV)), 1.0);
}
