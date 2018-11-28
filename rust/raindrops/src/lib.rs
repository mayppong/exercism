pub fn raindrops(n: u32) -> String {
    let mut drops: [&str; 3] = [""; 3];
    if n % 3 == 0 {
        drops[0] = "Pling"
    }
    if n % 5 == 0 {
        drops[1] = "Plang"
    }
    if n % 7 == 0 {
        drops[2] = "Plong"
    }
    if n % 3 != 0 && n % 5 != 0 && n % 7 != 0  {
        return n.to_string()
    }
    return drops.join("")
}
