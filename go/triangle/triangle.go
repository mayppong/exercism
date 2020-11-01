package triangle

type Kind string

const (
  NaT = "NotTriangle"
  Equ = "Equilateral"
  Iso = "Isosceles"
  Sca = "Scalene"
)

// KindFromSides should have a comment documenting it.
func KindFromSides(a, b, c float64) Kind {
    if !isTriangle(a, b, c) {
        return NaT
    }
    if isEquilateral(a, b, c) {
        return Equ
    }
    if isIsosceles(a, b, c) {
        return Iso
    }
    return Sca
}

func isTriangle(a, b, c float64) bool {
    zeroLengthSide := a <= 0 || b <= 0 || c <= 0
    return !zeroLengthSide
}

func isEquilateral(a, b, c float64) bool {
    return a == b && b == c
}

func isIsosceles(a, b, c float64) bool {
    return a == b || a == c || b == c
}

func isScalene(a, b, c float64) bool {
    return a != b && b != c && a != c
}
