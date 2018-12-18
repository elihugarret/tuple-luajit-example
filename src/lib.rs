// https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html
use std::os::raw::c_char;

#[no_mangle]
pub extern "C" fn return_tuple(s: *const c_char, x: u32, y: u32) -> (*const c_char, u32, u32) {
    (s, x + 1, y - 1)
}