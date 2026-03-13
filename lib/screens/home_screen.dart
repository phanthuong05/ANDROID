import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

// Enum để quản lý trạng thái
enum LoadingState { loading, success, error }

class HomeScreen extends StatefulWidget {
  final String studentName;
  final String studentId;

  const HomeScreen({
    super.key,
    required this.studentName,
    required this.studentId,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  // Hàm tải dữ liệu phim
  void _loadMovies() {
    setState(() {
      _moviesFuture = ApiService.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar hiển thị theo yêu cầu: TH3 - [Tên] - [Mã SV]
      appBar: AppBar(
        title: Text('TH3 - ${widget.studentName} - ${widget.studentId}'),
        backgroundColor: Colors.blue.shade700,
        elevation: 4,
      ),
      body: FutureBuilder<List<Movie>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          // TRẠNG THÁI: ĐANG TẢI (Loading)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState();
          }

          // TRẠNG THÁI: LỖI (Error)
          if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          }

          // TRẠNG THÁI: THÀNH CÔNG (Success)
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildSuccessState(snapshot.data!);
          }

          // Nếu không có dữ liệu
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.movie, size: 80, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'Không có phim nào',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _loadMovies,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Thử lại'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget hiển thị trạng thái LOADING
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 6,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
          ),
          const SizedBox(height: 16),
          Text(
            'Đang tải phim...',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  // Widget hiển thị trạng thái SUCCESS
  Widget _buildSuccessState(List<Movie> movies) {
    print('🎬 Hiển thị ${movies.length} phim trong UI');
    return RefreshIndicator(
      onRefresh: () async {
        _loadMovies();
        await _moviesFuture;
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cột
          childAspectRatio: 0.65, // Tăng tỷ lệ chiều cao để tránh overflow
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          print('📽️ Render item ${index + 1}: ${movies[index].title}');
          final movie = movies[index];
          return _buildMovieCard(movie);
        },
      ),
    );
  }

  // Widget hiển thị mỗi item Movie dưới dạng Card
  Widget _buildMovieCard(Movie movie) {
    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster phim
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.poster,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.movie,
                          color: Colors.grey.shade600,
                          size: 30,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Nội dung phim
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề phim
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Đạo diễn
                    Text(
                      'Đạo diễn: ${movie.director}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Thể loại
                    Text(
                      'Thể loại: ${movie.genre}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Rating với sao
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber.shade600, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          '${movie.rating.toStringAsFixed(1)}/10',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.amber.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị trạng thái ERROR
  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text(
              'Có lỗi xảy ra',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Hiển thị chi tiết lỗi
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: Colors.red.shade700),
              ),
            ),
            const SizedBox(height: 24),
            // Nút Thử lại (Retry)
            ElevatedButton.icon(
              onPressed: _loadMovies,
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
