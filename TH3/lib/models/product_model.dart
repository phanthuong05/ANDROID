class Movie {
  final String id;
  final String title;
  final String director;
  final double rating;
  final String genre;
  final String poster;

  Movie({
    required this.id,
    required this.title,
    required this.director,
    required this.rating,
    required this.genre,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // Hàm helper để ép kiểu String an toàn
    String safeString(dynamic value, String defaultValue) {
      if (value == null) return defaultValue;
      return value.toString();
    }

    // Hàm helper để ép kiểu Double an toàn (chấp nhận cả String số và Number)
    double safeDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return Movie(
      id: safeString(json['id'] ?? json['imdbID'], ''),
      title: safeString(json['title'] ?? json['Title'], 'Không có tiêu đề'),
      director: safeString(json['director'] ?? json['Director'], 'Không xác định'),
      rating: safeDouble(json['rating'] ?? json['imdbRating']),
      genre: safeString(json['genre'] ?? json['Genre'], 'Khác'),
      poster: safeString(json['poster'] ?? json['Poster'], 'https://via.placeholder.com/200?text=No+Poster'),
    );
  }
}
