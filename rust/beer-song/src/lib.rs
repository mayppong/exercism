pub fn verse(n: u32) -> String {

    if n == 0 {
        return "\
            No more bottles of beer on the wall, no more bottles of beer.\n\
            Go to the store and buy some more, 99 bottles of beer on the wall.\n\
        ".to_string();
    }

    let one = "1 bottle of beer".to_string();
    let zero = "No more bottles of beer".to_string();

    let beer_count;
    let next_beer_count;
    let mut take_down = "Take one down".to_string();
    if n == 1 {
        beer_count = one;
        next_beer_count = zero.to_lowercase();
        take_down = "Take it down".to_string()
    }
    else if n == 2 {
        beer_count = format!("{i} bottles of beer", i = n);
        next_beer_count = one;
    }
    else {
        beer_count = format!("{i} bottles of beer", i = n);
        next_beer_count = format!("{i} bottles of beer", i = n-1);
    }

    return format!("\
        {beer_count} on the wall, {beer_count}.\n\
        {take_down} and pass it around, {next_beer_count} on the wall.\n\
    ", beer_count = beer_count, next_beer_count = next_beer_count, take_down = take_down)
    .to_string();
}

pub fn sing(start: u32, end: u32) -> String {
    let mut n = start;
    let mut song: Vec<String> = Vec::new();
    while n >= end {
        song.push(verse(n));
        if n > 0 {
            n = n - 1;
        }
        else {
            break;
        }
    }
    return song.join("\n");
}
