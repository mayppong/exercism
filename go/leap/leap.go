package leap

// IsLeapYear validate whether the given year is a leap year.
func IsLeapYear(year int) bool {
    if year % 4 == 0 {
        if year % 100 != 0 {
            return true
        }
        if year % 400 == 0 {
            return true
        }
    }
    return false
}
