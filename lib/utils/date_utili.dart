class DateUtil{

  static DateTime? parseDateFromString(String raw) {
    try {
      // Remove brackets and whitespace, split by comma
      List<int> parts = raw
          .replaceAll(RegExp(r'[\[\]]'), '') // Remove [ and ]
          .split(',')
          .map((e) => int.parse(e.trim()))
          .toList();

      if (parts.length == 3) {
        return DateTime(parts[0], parts[1], parts[2]);
      }
    } catch (e) {
      print('Invalid date format: $e');
    }
    return null;
  }

  static String timeAgo(String date) {
    DateTime? dateTime = parseDateFromString(date);
    final now = DateTime.now();
    final difference = now.difference(dateTime!);

    if (difference.inDays == 0) {
      return "Aujourd'hui";
    } else if (difference.inDays == 1) {
      return "Hier";
    } else if (difference.inDays < 7) {
      return "Il y a ${difference.inDays} jours";
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return "Il y a $weeks ${weeks == 1 ? 'semaine' : 'semaines'}";
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return "Il y a $months ${months == 1 ? 'mois' : 'mois'}";
    } else {
      final years = (difference.inDays / 365).floor();
      return "Il y a $years ${years == 1 ? 'an' : 'ans'}";
    }
  }


}
