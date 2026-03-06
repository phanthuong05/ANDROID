# TH3 - Gọi API App (Call API Application)

## 📋 Tổng Quan

Ứng dụng Flutter hoàn chỉnh lấy dữ liệu từ API công khai (Fake Store API) và xử lý toàn bộ luồng bất đồng bộ với UI cho ba trạng thái: Loading, Success, và Error.

## ✅ Yêu Cầu Đã Hoàn Thành

### 1. ✓ Định danh Sinh Viên
- AppBar hiển thị: **TH3 - [Tên Sinh Viên] - [Mã SV]**

### 2. ✓ Hiển Thị Dữ Liệu
- Sử dụng **ListView** kết hợp **Card** để hiển thị sản phẩm
- Dữ liệu được lấy từ Fake Store API
- Có hình ảnh, tiêu đề, danh mục, mô tả, và giá

### 3. ✓ Xử Lý Ba Trạng Thái

#### **Trạng Thái 1: LOADING (Đang Tải)**
- Hiển thị `CircularProgressIndicator` đẹp mắt
- Có text "Đang tải dữ liệu..."
- Không có màn hình trắng tinh

#### **Trạng Thái 2: SUCCESS (Thành Công)**
- Hiển thị danh sách sản phẩm trong ListView
- Mỗi item là một Card gọn gàng với:
  - Hình ảnh sản phẩm
  - Tiêu đề (cắt gọn nếu quá dài - 2 dòng)
  - Danh mục sản phẩm
  - Mô tả (cắt gọn - 2 dòng)
  - Giá tiền định dạng đẹp
- Hỗ trợ **Pull-to-Refresh** (kéo xuống để làm mới)

#### **Trạng Thái 3: ERROR (Lỗi) + RETRY**
- Hiển thị icon lỗi rõ ràng
- Hiển thị thông báo lỗi chi tiết
- Nút **"Thử lại"** (Retry) để gọi lại API
- Không có màn hình trắng tinh

### 4. ✓ Tổ Chức Code Tốt
- **Tách file rõ ràng:**
  - `lib/models/product_model.dart` - Model dữ liệu
  - `lib/services/api_service.dart` - Gọi API
  - `lib/screens/home_screen.dart` - Giao diện chính
  - `lib/main.dart` - Điểm vào ứng dụng
- **Try-catch để bắt lỗi:** API service có xử lý lỗi đầy đủ

## 📁 Cấu Trúc Thư Mục

```
lib/
├── main.dart                 # Điểm vào ứng dụng
├── models/
│   └── product_model.dart    # Model cho sản phẩm
├── services/
│   └── api_service.dart      # Service gọi API
└── screens/
    └── home_screen.dart      # Giao diện chính
```

## 🔧 Cách Sử Dụng

### 1. **Thay Đổi Tên Sinh Viên và Mã SV**

Mở file [lib/main.dart](lib/main.dart) và thay đổi:

```dart
home: const HomeScreen(
  studentName: 'Sinh Viên',  // ← Thay bằng tên của bạn
  studentId: '20240001',      // ← Thay bằng mã SV của bạn
),
```

### 2. **Thay Đổi API Source (Tùy Chọn)**

Nếu muốn dùng API khác, chỉnh sửa trong [lib/services/api_service.dart](lib/services/api_service.dart):

```dart
static const String baseUrl = 'https://fakestoreapi.com';
// Thay đổi endpoint tại đây
```

### 3. **Chạy Ứng Dụng**

```bash
flutter pub get
flutter run
```

## 🧪 Mô Phỏng Lỗi

Để kiểm tra giao diện lỗi, bạn có thể:

1. **Tắt kết nối internet** và chạy ứng dụng
2. **Chỉnh sửa** baseUrl thành một URL không hợp lệ để kiểm tra
3. **Thay đổi timeout** trong `api_service.dart` để kích hoạt timeout

## 📊 Chi Tiết API

**API Source:** Fake Store API (https://fakestoreapi.com)

**Endpoint:** `/products`

**Dữ liệu trả về:**
```json
[
  {
    "id": 1,
    "title": "Product Name",
    "price": 109.95,
    "description": "Product description",
    "category": "Category",
    "image": "https://..."
  },
  ...
]
```

## 🎨 Customization Tips

### Thay Đổi Màu Sắc
Trong `lib/main.dart`, chỉnh sửa theme:
```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,  // ← Thay đổi màu ở đây
  ),
),
```

### Thay Đổi Dữ Liệu
Để sử dụng JSON server hoặc API khác:
1. Sửa `baseUrl` và `productsEndpoint` trong `api_service.dart`
2. Cập nhật `Product.fromJson()` để match với cấu trúc JSON mới

### Thêm Chức Năng
- **Pull-to-Refresh:** Đã có trong `_buildSuccessState()`
- **Error Handling:** Đã xử lý timeout và lỗi mạng
- **Empty State:** Hiển thị khi không có dữ liệu

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0  # Dùng để gọi API HTTP
```

## 🐛 Xử Lý Lỗi

Code đã bao quát các tình huống:
- ✓ Timeout (quá lâu)
- ✓ Network error (mất kết nối)
- ✓ Invalid status code (API trả về lỗi)
- ✓ JSON parsing error (dữ liệu sai định dạng)

## 💡 Mẹo

1. **Kiểm tra console** để xem error message chi tiết
2. **Sử dụng Flutter DevTools** để debug
3. **Test trên device thật** nếu có vấn đề mạng

## ✨ Tính Năng Nổi Bật

- ✓ Xử lý 3 trạng thái đầy đủ
- ✓ Pull-to-Refresh để làm mới data
- ✓ UI thân thiện với người dùng
- ✓ Error messages chi tiết
- ✓ Responsive design
- ✓ Code tổ chức tốt, dễ maintain

---

**Tạo bởi:** TH3 - Flutter API Integration
**Phiên bản:** 1.0.0
