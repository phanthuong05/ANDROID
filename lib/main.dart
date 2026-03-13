import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TH3 - Quản Lý Phim',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // TODO: Thay đổi tên sinh viên và mã sinh viên ở đây
      home: const HomeScreen(
        studentName: 'Phan Thị Sông Thương', // Thay bằng tên của bạn
        studentId: '2351160557', // Thay bằng mã SV của bạn
      ),
    );
  }
}
