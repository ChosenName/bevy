#import bevy_pbr::{mesh_functions::get_world_from_local, view_transformations::position_world_to_clip}

struct Vertex {
    @location(0) position: vec3<f32>,
    @location(1) normal: vec3<f32>,
    @location(2) uv: vec2<f32>,

    @location(3) i_pos_scale: vec4<f32>,
    @location(4) i_color: vec4<f32>,
};

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) color: vec4<f32>,
};

@vertex
fn vertex(vertex: Vertex) -> VertexOutput {
    // scale mesh
    var position = vertex.position * vertex.i_pos_scale.w;
    
    // Convert point to world space
    position += vertex.i_pos_scale.xyz;

    // Convert point to clip space
    var out: VertexOutput;
    out.clip_position = position_world_to_clip(position);

    out.color = vertex.i_color;
    return out;
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
    return in.color;
}
