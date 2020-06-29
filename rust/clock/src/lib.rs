#[derive(Debug)]
pub struct Clock {
  hour: i32,
  minute: i32
}

impl ToString for Clock {
  fn to_string(&self) -> String {
    return format!("{:02}:{:02}", self.hour, self.minute);
  }
}

impl PartialEq for Clock {
  fn eq(&self, other: &Self) -> bool {
    return self.hour == other.hour && self.minute == other.minute
  }
}

impl Clock {
  pub fn new(hours: i32, minutes: i32) -> Self {
    let result_hour:i32 = hours % 24;
    let clock = Clock { hour: result_hour, minute: minutes };
    return clock.readjust();
  }

  pub fn add_minutes(&self, minutes: i32) -> Self {
    let minute = self.minute + minutes;
    return (Clock { hour: self.hour, minute: minute }).readjust();
  }

  fn readjust(&self) -> Self {
    let mut minute: i32 = self.minute % 60;
    let overflow_hour: i32 = self.minute / 60;

    let mut hour: i32 = (self.hour + overflow_hour) % 24;
    if minute < 0 {
      minute = 60 + minute;
      hour = hour - 1;
    }
    if hour < 0 {
      hour = 24 + hour;
    }
    
    return Clock { hour: hour, minute: minute };
  }
}
