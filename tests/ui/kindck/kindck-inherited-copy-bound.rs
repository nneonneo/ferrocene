// Test that Copy bounds inherited by trait are checked.
//
//@ revisions: curr dyn_compatible_for_dispatch

#![cfg_attr(dyn_compatible_for_dispatch, feature(dyn_compatible_for_dispatch))]


use std::any::Any;

trait Foo : Copy {
    fn foo(&self) {}
}

impl<T:Copy> Foo for T {
}

fn take_param<T:Foo>(foo: &T) { }

fn a() {
    let x: Box<_> = Box::new(3);
    take_param(&x); //[curr]~ ERROR E0277
    //[dyn_compatible_for_dispatch]~^ ERROR E0277
}

fn b() {
    let x: Box<_> = Box::new(3);
    let y = &x;
    let z = &x as &dyn Foo;
    //[curr]~^ ERROR E0038
    //[curr]~| ERROR E0038
    //[dyn_compatible_for_dispatch]~^^^ ERROR E0038
}

fn main() { }

// ferrocene-annotations: fls_utuu8mdbuyxm
// Generic Arguments
//
// ferrocene-annotations: fls_i7g2n7hfg3ch
// Generic Conformance
//
// ferrocene-annotations: fls_vhpwge5123cm
// Generic Parameters
//
// ferrocene-annotations: fls_77scxuomlbgs
// Passing Conventions
//
// ferrocene-annotations: fls_jeoas4n6su4
// Trait and Lifetime Bounds
