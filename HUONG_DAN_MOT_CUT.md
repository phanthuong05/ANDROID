# HƯỚNG DẪN MỘT CUT

## 🚀 BẮT ĐẦU NHANH

### Bước 1: Cấu Hình Tên Sinh Viên
Mở `lib/main.dart` và thay đổi:
```dart
home: const HomeScreen(
  studentName: 'Ngô Quang An',  // ← Tên của bạn
  studentId: '20200025',         // ← Mã SV của bạn
),
```

### Bước 2: Chạy Ứng Dụng
```bash
cd "d:\src\bai th3\th3"
flutter pub get
flutter run
```

### Bước 3: Kiểm Tra Ba Trạng Thái

#### **LOADING** (Trạng thái đang tải)
- Vòng xoay loading hiển thị
- Chỉ kéo dài 1-2 giây rồi chuyển sang Success

#### **SUCCESS** (Trạng thái thành công)
- Danh sách sản phẩm hiển thị
- Mỗi card có: hình ảnh, tiêu đề, danh mục, mô tả, giá
- Kéo xuống để Pull-to-Refresh

#### **ERROR** (Trạng thái lỗi)
- Để test: Tắt WiFi/Data rồi chạy
- Hoặc sửa `baseUrl` thành URL sai để em sẽ thấy error UI
- Click "Thử lại" để gọi lại API

---

## 📋 YÊU CẦU NGHIỆM THU (Submission Requirements)

### 📁 Tạo Thư Mục "TH3" trên Google Drive

Cấu trúc như sau:
```
TH3/
├── 📄 links.txt              (Links GitHub của các thành viên)
├── 📊 BAO_CAO.pptx           (Slide báo cáo + screenshot)
├── 🎬 video_presentation.mp4 (Video demo - ≤100MB, mp4)
└── 📱 source_code/           (Hoặc đặt trong GitHub)
```

### 1️⃣ File **links.txt**
Ghi link GitHub của các thành viên nhóm:
```
Ngô Quang An: https://github.com/ngoaquanan/th3-api-app
Nguyễn Văn B: https://github.com/nguyenvanbh/th3-api-app
...
```

### 2️⃣ File **BAO_CAO.pptx** (Slide)
Slide báo cáo phải có:
- ✓ Tên nhóm, danh sách thành viên
- ✓ Chủ đề ứng dụng (ví dụ: Products, News, Users...)
- ✓ API source được sử dụng
- ✓ Các tính năng đã implement
- ✓ **Screenshot cả 3 trạng thái:**
  - Loading state
  - Success state (danh sách)
  - Error state + Retry button

### 3️⃣ Video Trình Bày (≤100MB, mp4)
Requirements:
- ✓ Presenter đọc slide theo trình tự
- ✓ Demo **cả 3 trạng thái** (Loading, Success, Error)
- ✓ Click Retry button và thấy API được gọi lại
- ✓ Kéo Pull-to-Refresh để làm mới data
- ✓ Dung lượng ≤ 100MB
- ✓ Format: **mp4**
- ✓ Title rõ ràng (ví dụ: `TH3_API_Integration_Nhom_5`)
  - ❌ Không được: `TH3_API_Integration_Nhom_5` (viết liền)
  - ✓ Được: `TH3 API Integration Team 5` (cách từ bằng space)

**Cách ghi âm nhanh:**
- Dùng OBS Studio (free)
- Hoặc: Windows + Shift + S (snip & sketch) → file → export
- Hoặc: Camtasia, ScreenFlow, v.v...

### 4️⃣ Video Upload YouTube
- Upload video lên YouTube
- Title: `TH3 API Integration Team 5` (rõ ràng, cách từ)
- Description: Liệt kê tên thành viên, link GitHub
- Setting: Unlisted hoặc Public
- Gửi link YouTube cho thầy/cô

---

## ✅ CHECKLIST TRƯỚC KHI NỘP

### Code Requirements
- [ ] `lib/main.dart` - Contains StudentName & StudentId
- [ ] `lib/models/product_model.dart` - Model class with fromJson()
- [ ] `lib/services/api_service.dart` - API call with try-catch
- [ ] `lib/screens/home_screen.dart` - UI with 3 states (Loading, Success, Error)
- [ ] `pubspec.yaml` - Has `http: ^1.1.0` dependency
- [ ] All files saved & `flutter pub get` completed

### Functional Requirements
- [ ] AppBar hiển thị: TH3 - [Tên] - [Mã SV]
- [ ] **LOADING State:** Có CircularProgressIndicator (không trắng)
- [ ] **SUCCESS State:** ListView dengan Card items
  - [ ] Hình ảnh sản phẩm
  - [ ] Tiêu đề (maxLines: 2, ellipsis)
  - [ ] Danh mục
  - [ ] Mô tả (maxLines: 2, ellipsis)
  - [ ] Giá tiền
- [ ] **ERROR State:** Hiển thị lỗi + **"Thử lại" button**
  - [ ] Click Retry → API được gọi lại
  - [ ] Error message hiển thị rõ ràng
- [ ] Pull-to-Refresh hoạt động
- [ ] Network error được xử lý (try-catch)

### Submission Requirements
- [ ] Tạo folder TH3 trên Drive
- [ ] File `links.txt` - GitHub links
- [ ] File `BAO_CAO.pptx` - Slide + screenshots
- [ ] File `video_presentation.mp4`
  - [ ] ≤ 100MB
  - [ ] Format: mp4
  - [ ] Đầy đủ demo 3 states
  - [ ] Title không dùng dấu "_"
- [ ] Upload lên YouTube
  - [ ] Link rõ ràng
  - [ ] Tiêu đề rõ

---

## 🎯 TIPS LÀM DEMO

### Để Demo Loading State
- API mất 1-2 giây thôi, sẽ tự chuyển sang Success
- Hoặc: Comment out endpoint, thay thành URL chậm

### Để Demo Error State
```dart
// Tạm thời sửa trong api_service.dart
static const String baseUrl = 'https://invalid-url-12345.com';
```
- Chạy lại → sẽ thấy error UI
- Khi quay video xong, sửa lại baseUrl đúng

### Để Demo Retry
- Từ error state → click "Thử lại"
- App sẽ gọi API lại
- Nếu kết nối tốt → chuyển sang Success

### Để Demo Pull-to-Refresh
- Kéo list từ trên xuống
- Vòng xoay refresh hiển thị
- Release → data làm mới

---

## 🔧 CUSTOMIZE THÊM (Optional)

### Thay API Source
```dart
// File: lib/services/api_service.dart
static const String baseUrl = 'https://your-api.com';
static const String productsEndpoint = '/products';
```

### Thay Model Data
```dart
// File: lib/models/product_model.dart
// Thêm fields mà API bạn trả về
// Sửa fromJson() để match JSON structure
```

### Thay Màu Sắc
```dart
// File: lib/main.dart
seedColor: Colors.purple,  // ← Đổi thành màu bạn thích
```

---

## 📞 CÓ VẤN ĐỀ?

### Lỗi: "No internet connection"
→ This is EXPECTED. Để test error UI, hãy kiểm tra nó.

### Lỗi: "package http not found"
→ Chạy: `flutter pub get`

### Lỗi: "import shows red"
→ Đảm bảo cấu trúc folder đúng:
```
lib/
├── main.dart
├── models/product_model.dart
├── services/api_service.dart
└── screens/home_screen.dart
```

### UI không responsive
→ Xem device size, test trên nhiều kích cỡ màn hình

---

## ✨ CHIẾN THUẬT ĐẠT ĐIỂM CAO

1. **Code sạch & có tổ chức** ✓ (Đã xong)
2. **Xử lý lỗi đầy đủ** ✓ (Đã có try-catch)
3. **UI đẹp & user-friendly** ✓ (Đã có Card, icons...)
4. **Demo đầy đủ 3 states** ← KHÓ nhất, nhưng QUAN TRỌNG
5. **Slide báo cáo chuyên nghiệp** (có screenshot)
6. **Video ổn định, âm thanh rõ**

---

**Happy Coding! 🚀**

Nếu có hỏi, hãy test lại code trước khi nộp.

