package hamming

import (
	"errors"
)

// Distance function calculates the Hamming Distance between two DNA
// strands.
// The function requires 2 strings input and returns a tuple of integer and
// an error message.
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return 0, errors.New("the two dna have a different length")
	}

	count := 0
	bRunes := []rune(b)
	for i, aRune := range a {
		if aRune != bRunes[i] {
			count++
		}
	}

	return count, nil
}
