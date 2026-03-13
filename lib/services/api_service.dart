import '../models/product_model.dart';

class ApiService {
  static Future<List<Movie>> fetchMovies() async {
    // Return mock movies for demo
    return mockMovies.map((movie) => Movie.fromJson(movie)).toList();
  }

  static const List<Map<String, dynamic>> mockMovies = [
    {
      'title': 'The Shawshank Redemption',
      'director': 'Frank Darabont',
      'genre': 'Drama',
      'rating': 9.3,
      'poster': 'https://picsum.photos/seed/s1/300/450',
    },
    {
      'title': 'The Godfather',
      'director': 'Francis Ford Coppola',
      'genre': 'Crime',
      'rating': 9.2,
      'poster': 'https://picsum.photos/seed/s2/300/450',
    },
    {
      'title': 'The Dark Knight',
      'director': 'Christopher Nolan',
      'genre': 'Action',
      'rating': 9.0,
      'poster': 'https://picsum.photos/seed/s3/300/450',
    },
    {
      'title': 'Pulp Fiction',
      'director': 'Quentin Tarantino',
      'genre': 'Crime',
      'rating': 8.9,
      'poster': 'https://picsum.photos/seed/s4/300/450',
    },
    {
      'title': 'Forrest Gump',
      'director': 'Robert Zemeckis',
      'genre': 'Drama',
      'rating': 8.8,
      'poster': 'https://picsum.photos/seed/s5/300/450',
    },
    {
      'title': 'Inception',
      'director': 'Christopher Nolan',
      'genre': 'Action',
      'rating': 8.8,
      'poster': 'https://picsum.photos/seed/s6/300/450',
    },
    {
      'title': 'Fight Club',
      'director': 'David Fincher',
      'genre': 'Drama',
      'rating': 8.8,
      'poster': 'https://picsum.photos/seed/s7/300/450',
    },
    {
      'title': 'The Matrix',
      'director': 'The Wachowskis',
      'genre': 'Sci-Fi',
      'rating': 8.7,
      'poster': 'https://picsum.photos/seed/s8/300/450',
    },
    {
      'title': 'Goodfellas',
      'director': 'Martin Scorsese',
      'genre': 'Crime',
      'rating': 8.7,
      'poster': 'https://picsum.photos/seed/s9/300/450',
    },
    {
      'title': 'Interstellar',
      'director': 'Christopher Nolan',
      'genre': 'Adventure',
      'rating': 8.6,
      'poster': 'https://picsum.photos/seed/s10/300/450',
    },
  ];
}
