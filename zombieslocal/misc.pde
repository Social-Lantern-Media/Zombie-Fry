// Timer class; currently used for hit flashing.
class Timer {
  int timeStarted;
  int timeLength;
  
  Timer(int tempTimeLength) {
    timeLength = tempTimeLength;
  }
  
  void start() {
    timeStarted = millis();
  }
  
  boolean isFinished() {
    int timePassed = millis() - timeStarted;
    
    if (timePassed >= timeLength) {
      return true;
    } else {
      return false;
    }
    
  }
}
