import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ApiService {
  // Hàm lấy danh sách phim từ Firestore và tự động đồng bộ
  static Future<List<Movie>> fetchMovies() async {
    try {
      // 1. Kết nối đến database tên là 'movies' theo hình ảnh của bạn
      final firestore = FirebaseFirestore.instanceFor(
        app: FirebaseFirestore.instance.app,
        databaseId: 'movies',
      );

      final movieCollection = firestore.collection('movies');

      // 2. Kiểm tra dữ liệu trên Firebase
      final snapshot = await movieCollection.get();

      // 3. Nếu Firebase CHƯA CÓ PHIM, tiến hành tự động đẩy dữ liệu mẫu lên
      if (snapshot.docs.isEmpty) {
        print('🚀 Firestore đang trống. Đang tự động đẩy dữ liệu mẫu lên...');

        for (var movieData in mockMovies) {
          // Xóa trường id trong mockData để Firestore tự tạo ID ngẫu nhiên hoặc dùng id có sẵn
          await movieCollection.add({
            'title': movieData['title'],
            'director': movieData['director'],
            'genre': movieData['genre'],
            'rating': movieData['rating'],
            'poster': movieData['poster'],
          });
        }

        print('✅ Đã đẩy 10 phim lên Firebase thành công!');

        // Lấy lại dữ liệu sau khi đã đẩy lên
        final newSnapshot = await movieCollection.get();
        return newSnapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return Movie.fromJson(data);
        }).toList();
      }

      // 4. Nếu đã có phim, trả về danh sách phim từ Firebase
      print('✅ Đã lấy được ${snapshot.docs.length} phim từ Firebase');
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Movie.fromJson(data);
      }).toList();

    } catch (e) {
      print('❌ Lỗi Firebase: $e');
      // Trả về mock data dự phòng nếu có lỗi kết nối
      return mockMovies.map((item) => Movie.fromJson(item)).toList();
    }
  }

  // Danh sách 10 phim mẫu để tự động đẩy lên Firebase
  static const List<Map<String, dynamic>> mockMovies = [
    {
      'title': 'The Shawshank Redemption',
      'director': 'Frank Darabont',
      'genre': 'Drama',
      'rating': 9.3,
      'poster': 'https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_SX300.jpg',
    },
    {
      'title': 'The Godfather',
      'director': 'Francis Ford Coppola',
      'genre': 'Crime, Drama',
      'rating': 9.2,
      'poster': 'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNC00MTMyLWFwMzAtOTVkZWFjODk2NmFkXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
    },
    {
      'title': 'The Dark Knight',
      'director': 'Christopher Nolan',
      'genre': 'Action, Crime',
      'rating': 9.0,
      'poster': 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODUxN15BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg',
    },
    {
      'title': 'Pulp Fiction',
      'director': 'Quentin Tarantino',
      'genre': 'Crime, Drama',
      'rating': 8.9,
      'poster': 'https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItMDJlM2FmMDZmN2EwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
    },
    {
      'title': 'Forrest Gump',
      'director': 'Robert Zemeckis',
      'genre': 'Drama, Romance',
      'rating': 8.8,
      'poster': 'https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmRlY2E4NDE4XkEyXkFqcGdeQXVyMTQwMTAwOTQ1._V1_SX300.jpg',
    },
    {
      'title': 'Inception',
      'director': 'Christopher Nolan',
      'genre': 'Action, Sci-Fi',
      'rating': 8.8,
      'poster': 'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg',
    },
    {
      'title': 'Fight Club',
      'director': 'David Fincher',
      'genre': 'Drama',
      'rating': 8.8,
      'poster': 'https://m.media-amazon.com/images/M/MV5BNDIzNDU0YzEtYzE5Ni00ZjlkLTk5ZjctZjBlODU0Yzk2OGQ3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
    },
    {
      'title': 'The Matrix',
      'director': 'The Wachowskis',
      'genre': 'Action, Sci-Fi',
      'rating': 8.7,
      'poster': 'https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDEwZjBkNDRjNmE3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
    },
    {
      'title': 'Goodfellas',
      'director': 'Martin Scorsese',
      'genre': 'Crime, Drama',
      'rating': 8.7,
      'poster': 'https://m.media-amazon.com/images/M/MV5BY2NkZjE1ZmYtZWFmYy00ODJlLWJmZjAtYTAyNmI2Y2M0NzdhXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
    },
    {
      'title': 'Interstellar',
      'director': 'Christopher Nolan',
      'genre': 'Adventure, Drama',
      'rating': 8.6,
      'poster': 'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDAtMmE0Yi00ZTA3LWFmZTAtZTAwOGEwNzg2OTg1XkEyXkFqcGdeQXVyMzQ0MjM5NjA@._V1_SX300.jpg',
    },
  ];
}