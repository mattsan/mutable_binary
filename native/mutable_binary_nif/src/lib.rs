use rustler::types::Encoder;
use rustler::OwnedBinary;
use rustler::{Env, ResourceArc, Term};
use std::sync::Mutex;

mod atoms {
    rustler::atoms! {
        ok,
        error,
        out_of_range,
    }
}

struct MutableBinaryResource {
    pub stream: Mutex<Vec<u8>>,
}

fn load(env: Env, _: Term) -> bool {
    rustler::resource!(MutableBinaryResource, env);
    true
}

#[rustler::nif]
fn new(env: Env, size: usize) -> Term {
    if size > 0 {
        let resource = ResourceArc::new(MutableBinaryResource {
            stream: Mutex::new(vec![0; size]),
        });

        (atoms::ok(), resource).encode(env)
    } else {
        (atoms::error(), atoms::out_of_range()).encode(env)
    }
}

#[rustler::nif]
fn length(resource: ResourceArc<MutableBinaryResource>) -> usize {
    let resource_struct = resource.stream.try_lock().unwrap();

    resource_struct.len()
}

#[rustler::nif]
fn get(env: Env, resource: ResourceArc<MutableBinaryResource>, index: usize) -> Term {
    let resource_struct = resource.stream.try_lock().unwrap();

    if index < resource_struct.len() {
        (atoms::ok(), resource_struct[index]).encode(env)
    } else {
        (atoms::error(), atoms::out_of_range()).encode(env)
    }
}

#[rustler::nif]
fn set(env: Env, resource: ResourceArc<MutableBinaryResource>, index: usize, value: u8) -> Term {
    let mut resource_struct = resource.stream.try_lock().unwrap();

    if index < resource_struct.len() {
        resource_struct[index] = value;
        atoms::ok().encode(env)
    } else {
        (atoms::error(), atoms::out_of_range()).encode(env)
    }
}

#[rustler::nif]
fn to_string(resource: ResourceArc<MutableBinaryResource>) -> OwnedBinary {
    let resource_struct = resource.stream.try_lock().unwrap();
    let mut result = OwnedBinary::new(resource_struct.len()).unwrap();
    result.copy_from_slice(&resource_struct);

    result
}

rustler::init!(
    "Elixir.MutableBinary.NIF",
    [new, length, set, get, to_string],
    load = load
);
