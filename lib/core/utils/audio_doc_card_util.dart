class AudioDocCardUtil {
  static String durationToString(Duration duration) {
    if ((duration.inSeconds / 60.0) < 1) 
      return '${duration.inSeconds} secs';

    else if ((duration.inMinutes / 60.0) < 1)
      return '${duration.inMinutes} mins';

    final double minsInHours = duration.inMinutes / 60.0;
    if (minsInHours % 1 == 0) {
      if (minsInHours.toInt() == 1 || minsInHours.toInt() == 0)
        return '${minsInHours.toInt()} hour';
      return '${minsInHours.toInt()} hours';
    }
    return '${minsInHours.toStringAsFixed(1)} hours';
  }
}