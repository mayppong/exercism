
def is_leap_year(year):
    is_leap = False

    if year % 4 == 0 and year % 100 != 0:
        is_leap = True
    elif year % 100 == 0 and year % 400 == 0:
        is_leap = True

    return is_leap
