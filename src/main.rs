use bevy::{
    prelude::*,
    reflect::TypePath,
    render::render_resource::{AsBindGroup, ShaderRef},
};

fn main() {
    App::new()
        .add_plugins((DefaultPlugins, MaterialPlugin::<CustomMaterial>::default()))
        .add_systems(Startup, setup)
        .run();
}

fn setup(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<CustomMaterial>>,
) {
    commands.spawn(MaterialMeshBundle {
        mesh: meshes.add(Mesh::from(shape::Plane {
            size: 5.0,
            subdivisions: 0,
        })),
        material: materials.add(CustomMaterial {}),
        ..default()
    });

    let mut camera = Camera3dBundle::default();
    camera.transform.translation = Vec3::new(0.0, 10.0, 0.0);
    camera.transform.look_at(Vec3::ZERO, Vec3::Y);
    commands.spawn(camera);
}

#[derive(Asset, TypePath, AsBindGroup, Clone, Debug)]
pub struct CustomMaterial {}

impl Material for CustomMaterial {
    fn fragment_shader() -> ShaderRef {
        "noise_shader.wgsl".into()
    }
}
