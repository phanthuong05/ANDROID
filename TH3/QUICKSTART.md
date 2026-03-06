# QUICK START - TH3 API APP

## 📱 Điều Cần Làm Ngay Bây Giờ

### 1. Chỉnh Sửa Tên Sinh Viên (5 giây)
**File:** `lib/main.dart` - Dòng 23-24
```dart
studentName: 'Tên Của Bạn',  // ← THAY ĐỔI
studentId: '20240001',       // ← THAY ĐỔI
```

### 2. Cài Đặt & Chạy (30 giây)
```bash
cd "d:\src\bai th3\th3"
flutter pub get
flutter run
```

### 3. Nhìn Thấy 3 Trạng Thái
| Trạng Thái | Cách Thấy | Chi Tiết |
|-----------|----------|---------|
| **LOADING** | Khi ứng dụng chạy, 1-2 giây đầu | Vòng xoay + text "Đang tải..." |
| **SUCCESS** | Sau loading, danh sách hiển thị | Thẻ sản phẩm, hình ảnh, giá |
| **ERROR** | Tắt WiFi hoặc sửa baseUrl sai | Error message + nút "Thử lại" |

---

## 🎬 Làm Demo Video (15 phút)

### Bước 1: Quay Phần 1 - Slide (5 phút)
- Trình bày slide tên, API, tính năng
- **Screenshot cả 3 state** có sẵn rồi

### Bước 2: Quay Phần 2 - Demo App (10 phút)
#### DEMO Loading (1 phút)
- Chạy app → show vòng xoay loading
- đợi chuyển sang Success

#### DEMO Success (3 phút)
- Kéo xuống Pull-to-Refresh
- Scroll list xem các sản phẩm
- Thấy card: hình ảnh, tiêu đề, danh mục, mô tả, giá

#### DEMO Error + Retry (3 phút)
- Tắt WiFi/Data
- Khởi động lại app
- Thấy error UI → click "Thử lại"
- Bật WiFi → Success

#### DEMO Code (2 phút - Optional)
- Mở `lib/services/api_service.dart`
- Trình bày try-catch logic
- Mở `lib/screens/home_screen.dart`
- Trình bày 3 state UI builders

### Bước 3: Xuất File (2 phút)
- **Format:** mp4
- **Dung lượng:** < 100MB
- **Title:** `TH3 API Integration Team 5` (không có dấu "_")

### Bước 4: Upload YouTube (2 phút)
- YouTube: New video upload
- Title: rõ ràng
- Description: tên thành viên + link GitHub
- Setting: Public hoặc Unlisted

---

## 📊 Nộp Trên Drive

### Cấu Trúc Thư Mục TH3:
```
TH3/
├── links.txt
│   └── GitHub links của các bạn
├── BAO_CAO.pptx
│   └── Slide + screenshots
├── video_presentation.mp4
│   └── Demo video (<100MB)
└── README.txt
    └── Hướng dẫn chạy
```

---

## ✅ Checklist Nộp

- [ ] Code chạy được (flutter run)
- [ ] Tên & Mã SV đúng
- [ ] 3 states visible (Loading, Success, Error)
- [ ] Error có "Thử lại" button
- [ ] Pull-to-Refresh hoạt động
- [ ] Code tách file tốt
- [ ] Drive folder có đầy đủ file
- [ ] Video ≤100MB, mp4, rõ ràng
- [ ] YouTube link đúng

---

## 🔥 Mẹo 10 Giây

**Tắt WiFi để test Error UI:**
```
Settings → WiFi → OFF
Chạy app → Thấy error
Click "Thử lại" (offline) → Still error
Bật WiFi → Click "Thử lại" → Success ✓
```

**Nhanh chóng demo Loading:**
- API response mặc định 1-2 giây
- Không cần tạo delay giả tạo

**Edit Code nhanh:**
- Hot reload: Save file → Tự update
- Không cần restart app

---

## 🎓 Điểm Cộng Extra (Optional)

- Thay data source: Firebase, NewsAPI, v.v...
- Thêm animation: fade, slide...
- Dark mode support
- Search/Filter functionality
- Pagination/Infinite scroll

---

**READ THIS 3 TIMES BEFORE SUBMITTING!**

1. ✅ Can I run `flutter run` successfully?
2. ✅ Do I see Loading → Success → Error states?
3. ✅ Does "Thử lại" button work?

If YES to all 3 → **YOU'RE GOOD TO GO! 🚀**

