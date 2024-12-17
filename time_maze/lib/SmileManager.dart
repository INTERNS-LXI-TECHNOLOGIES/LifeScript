class SmileManager {
  String smileState = 'neutral'; // Default state
  String currentQuote = 'Start dragging to see progress!';

  final Map<String, String> smileEmojis = {
    'happy': '😊',
    'sad': '😔',
    'neutral': '🙂',
  };

  final Map<String, String> quadrantQuotes = {
    'Q1': 'You’re doing great! Keep it up! 🌟',
    'Q2': 'Stay focused and aim high! 🚀',
    'Q3': 'Don’t lose hope, you can bounce back! 💪',
    'Q4': 'Hard times don’t last, keep going! 🌈',
  };

  void updateSmileState(String quadrant) {
    if (quadrant == 'Q1' || quadrant == 'Q2') {
      smileState = 'happy';
    } else if (quadrant == 'Q3' || quadrant == 'Q4') {
      smileState = 'sad';
    }
    currentQuote = quadrantQuotes[quadrant] ?? 'Keep going! 🌟';
  }

  String getSmileEmoji() => smileEmojis[smileState] ?? '🙂';
  String getQuote() => currentQuote;
}
