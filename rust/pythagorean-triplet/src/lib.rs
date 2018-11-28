use std::collections::HashSet;

// https://en.wikipedia.org/wiki/Pythagorean_triple#Proof_of_Euclid's_formula
pub fn find(sum: u32) -> HashSet<[u32; 3]> {
    let mut collection: HashSet<[u32; 3]> = HashSet::new();

    for m in 1..sum {
        if sum % m == 0 && sum/(2*m) > m {
            let n = (sum/(2*m)) - m;

            let m_sq = m.pow(2);
            let n_sq = n.pow(2);

            if m_sq > n_sq {
                let a = m_sq - n_sq;
                let b = 2 * m * n;
                let c = m_sq + n_sq;

                let mut array = [a, b, c];
                array.sort();
                collection.insert(array);
            }
        }
    }
    return collection;
}
