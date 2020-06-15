class Clock:
    hour = 0
    minute = 0

    def __init__(self, hour, minute):
        self.__add_hour(hour)
        self.__add_minute(minute)

    def __repr__(self):
        return self.__str__(self)
    
    def __str__(self):
        return "{hour:02d}:{minute:02d}".format(hour=self.hour, minute=self.minute)

    def __eq__(self, other):
        # don't attempt to compare against unrelated types
        if not isinstance(other, Clock):
            return NotImplemented

        return self.hour == other.hour and self.minute == other.minute

    def __add__(self, minutes):
        return self.__add_minute(minutes)

    def __sub__(self, minutes):
        return self.__sub_minute(minutes)

    def __add_hour(self, hour):
        total = self.hour + hour
        self.hour = int(abs(total) % 24)
        if total < 0:
            self.hour = 24 - self.hour

        if abs(self.hour) == 24:
            self.hour = 0
        return self

    def __add_minute(self, minutes):
        if minutes < 0:
            return self.__sub_minute(abs(minutes))

        total = self.minute + minutes
        self.minute = int(total % 60)
        overflow = total / 60
        if overflow != 0:
            self.__add_hour(overflow)

        if abs(self.minute) == 60:
            self.minute = 0
            self.__add_hour(1)
        return self

    def __sub_minute(self, minutes):
        total = self.minute - minutes
        if total < 0:
            total = abs(total)
            self.minute = 60 - int(total % 60)
            overflow = -1 * (int(total / 60) + 1)
            self.__add_hour(overflow)
        else:
            self.minute = total % 60

        if abs(self.minute) == 60:
            self.minute = 0
            self.__add_hour(1)
        return self
