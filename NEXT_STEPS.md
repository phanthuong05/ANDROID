# 🎯 NEXT STEPS - HÀNH ĐỘNG NGAY BÂY GIỜ

## ✅ ĐÓNG TICKMARK KHI HOÀN THÀNH

### NGAY SAU KHI NHẬN CODE (5 PHÚT)

- [ ] **Mở file:** `lib/main.dart`
- [ ] **Thay Tên:** Dòng 23 → Tên của bạn
- [ ] **Thay Mã SV:** Dòng 24 → Mã sinh viên của bạn
- [ ] **Save file:** Ctrl+S

### CHẠY & KIỂM TRA (5 PHÚT)

```bash
# Terminal / PowerShell
cd "d:\src\bai th3\th3"
flutter pub get
flutter run
```

- [ ] App chạy được
- [ ] Thấy vòng xoay loading (1-2 giây)
- [ ] Chuyển sang danh sách sản phẩm
- [ ] Kéo xuống → Pull-to-Refresh hoạt động

### KIỂM TRA 3 STATES (10 PHÚT)

#### State 1: LOADING ✓
```
Mong đợi 1-2 giây initial load
Thấy: Vòng xoay + "Đang tải dữ liệu..."
```

#### State 2: SUCCESS ✓
```
Danh sách hiển thị
Card có: Hình, Tiêu đề, Danh mục, Mô tả, Giá
➜ Kéo Pull-to-Refresh → danh sách làm mới
```

#### State 3: ERROR + RETRY ✓
```
Tắt WiFi/Data:
  Settings → WiFi → OFF
Chạy app:
  flutter run
Thấy:
  - Error UI (icon lỗi, thông báo)
  - Nút "Thử lại"
Click "Thử lại" (WiFi vẫn OFF):
  → Vẫn error (đúng)
Bật WiFi:
  Settings → WiFi → ON
Click "Thử lại":
  → Loading → Success ✓
```

---

## 🎬 QUAY VIDEO DEMO (30 PHÚT)

### Chuẩn Bị (5 phút)
- [ ] Chuẩn bị slide (PowerPoint hoặc Google Slides)
- [ ] Screenshot 3 states (có sẵn, chỉ việc thêm vào slide)
- [ ] Chuẩn bị device (phone/emulator) để demo

### Dàn Ý Video (chi tiết từng phút)

**[0:00-1:00] - Trang bìa & Gới thiệu Nhóm**
- Tên thành viên
- Tên chủ đề ứng dụng
- API source

**[1:00-2:00] - Giới Thiệu Chủ Đề**
- Ứng dụng gì?
- Dữ liệu lấy từ đâu?
- Tính năng chính?

**[2:00-3:00] - Tính Năng Đã Implement**
- ✓ ListView/GridView
- ✓ Loading state
- ✓ Success state
- ✓ Error + Retry
- ✓ Pull-to-Refresh
- ✓ Code tách file

**[3:00-4:00] - Hình Ảnh Demo**
- Screenshot loading
- Screenshot success
- Screenshot error

**[4:00-14:00] - DEMO THỰC SỐNG (10 phút)**

#### Sub 1: LOADING State (1 phút)
```
- Chạy app
- "Đây là trạng thái LOADING"
- "Hệ thống đang lấy dữ liệu từ API..."
- "Thấy vòng xoay, không có màn hình trắng"
- Chờ chuyển sang Success
```

#### Sub 2: SUCCESS State (3 phút)
```
- Thấy danh sách sản phẩm
- "Mỗi item là một Card"
- "Có hình ảnh, tiêu đề, danh mục, mô tả, giá"
- Scroll list: "Xem thêm sản phẩm khác..."
- Kéo xuống: "Đây là Pull-to-Refresh - kéo làm mới"
- Demo pull-to-refresh
```

#### Sub 3: ERROR State + RETRY (3 phút)
```
[CÁCH DEMO 1: Tắt WiFi trước khi quay]
- "Bây giờ tôi sẽ demo ERROR state"
- "Mất kết nối mạng → xem ứng dụng xử lý thế nào"
- Chạy app → "Thấy error UI"
- "Nút 'Thử lại' để gọi lại API"
- Click "Thử lại" → "Vẫn error vì WiFi OFF"
- Bật WiFi (ngoài app, hoặc in-app)
- Click "Thử lại" → Loading → Success

[HOẶC CÁCH DEMO 2: Sửa baseUrl sai]
- Cách này nhanh hơn, không cần tắt WiFi
```

#### Sub 4: CODE WALKTHROUGH (2 phút) - Optional
```
- Mở lib/services/api_service.dart
- "Try-catch xử lý error"
- Mở lib/screens/home_screen.dart
- "3 state builders: Loading, Success, Error"
```

**[14:00-15:00] - KẾT LUẬN**
- Tổng kết tính năng
- Cảm ơn xem
- Liệt kê tên thành viên lần nữa

### Quay Video (15 phút)
**Tools:** 
- OBS Studio (free)
- Windows Snipping Tool
- Camtasia
- ScreenFlow (Mac)

**Settings:**
- **Resolution:** 1080p (1920x1080)
- **FPS:** 30fps
- **Codec:** H.264
- **Bitrate:** 8-12 Mbps

### Xuất File (5 phút)
- [ ] **Format:** mp4 (⭐ QUAN TRỌNG)
- [ ] **Dung lượng:** < 100MB (kiểm tra!)
- [ ] **Name:** `TH3_API_Integration_Team_5.mp4`
  - ✅ Được: Cách từ bằng space
  - ❌ Sai: Nối từ bằng dấu "_"
- [ ] **Save location:** Desktop hoặc folder dễ tìm

**Kiểm tra dung lượng:**
```bash
# PowerShell
Get-Item "C:\Desktop\video.mp4" | Select-Object -ExpandProperty Length
# Chia cho 1MB = 1048576
```

---

## 📊 SLIDE BÁNG CÁO (PowerPoint/Slides)

### Slide 1: Trang Bìa
- Tiêu đề: TH3 - Gọi API App
- Nhóm: [Tên nhóm]
- Thành viên: Tên + Mã SV
- Ngày: 06/03/2026

### Slide 2: Giới Thiệu Chủ Đề
- Ứng dụng: [Mô tả chủ đề]
- API Source: Fake Store API
- Dữ liệu: Sản phẩm (title, price, image, ...)

### Slide 3: Tính Năng Chính
- ✓ Gọi API & lấy dữ liệu
- ✓ Xử lý 3 trạng thái (Loading, Success, Error)
- ✓ Retry button khi lỗi
- ✓ Pull-to-Refresh
- ✓ Responsive UI
- ✓ Code tách file

### Slide 4: Loading State
- **Screenshot** loading UI
- Vòng xoay + text "Đang tải..."

### Slide 5: Success State
- **Screenshot** danh sách sản phẩm
- Card layout: hình, tiêu đề, danh mục, mô tả, giá

### Slide 6: Error State
- **Screenshot** error UI
- Nút "Thử lại"

### Slide 7: Công nghệ & Công cụ
- Flutter
- Dart
- Http package
- Fake Store API
- VS Code

### Slide 8: Cảm ơn
- Cảm ơn thầy/cô
- Liệt kê tên thành viên

---

## 📁 CHUẨN BỊ DRIVE (Google Drive)

### Tạo Thư Mục
1. Google Drive → New → Folder
2. Đặt tên: **TH3**
3. Share với: Thầy/Cô

### Upload Files
```
TH3/
├── 📄 README.txt
│   └── Hướng dẫn chạy code
├── 📄 links.txt
│   └── GitHub links của từng thành viên
├── 📊 BAO_CAO.pptx
│   └── Slide + screenshots
├── 🎬 TH3_API_Integration_Team_5.mp4
│   └── Video demo (<100MB)
└── 📱 source_code/
    └── Hoặc link direct tới GitHub
```

### File links.txt Format:
```
THÀNH VIÊN:
Ngô Quang An: https://github.com/ngoaquanan/th3-flutter-api
Nguyễn Văn B: https://github.com/nguyenvanbh/th3-flutter-api
Trần Thị C: https://github.com/tranthich/th3-flutter-api

LINK CHÍNH (Clone & Run):
https://github.com/ngoaquanan/th3-flutter-api

HƯỚNG DẪN CHẠY:
1. Clone repo
2. cd th3
3. flutter pub get
4. flutter run
```

---

## 📺 YOUTUBE UPLOAD (5 PHÚT)

1. **Đăng nhập YouTube** (gmail.com)
2. **Nhấn:** CREATE → Upload Video
3. **Chọn file:** `TH3_API_Integration_Team_5.mp4`
4. **Nhập Title:** `TH3 API Integration Team 5`
5. **Nhập Description:**
   ```
   Bài Thực Hành 3: Gọi API & Xử Lý UI States
   
   Thành Viên:
   - Ngô Quang An (20240001)
   - Nguyễn Văn B (20240002)
   - Trần Thị C (20240003)
   
   GitHub:
   https://github.com/ngoaquanan/th3-flutter-api
   
   Tính Năng:
   ✓ Gọi API từ Fake Store API
   ✓ Xử lý Loading, Success, Error states
   ✓ Retry button
   ✓ Pull-to-Refresh
   
   Công Nghệ: Flutter, Dart, HTTP
   ```
6. **Privacy:** Chọn "Unlisted" hoặc "Public"
7. **Nhấn:** Next → Next → Publish

6. **Copy Link YouTube** & Gửi cho thầy/cô

---

## ✅ FINAL CHECKLIST TRƯỚC KHI NỘP

### Code Quality
- [ ] `flutter pub get` thành công
- [ ] `flutter run` không lỗi
- [ ] Không có red squiggly lines
- [ ] Tên SV đúng trong AppBar

### Functional Requirements
- [ ] LOADING state hiển thị đúng
- [ ] SUCCESS state: ListView + Cards
- [ ] ERROR state: error UI + Retry button
- [ ] Retry button: gọi lại API
- [ ] Pull-to-Refresh: hoạt động
- [ ] Timeout handling: có try-catch
- [ ] Network error handling: có try-catch

### Submission
- [ ] Drive folder "TH3" tạo được
- [ ] File links.txt có GitHub links
- [ ] BAO_CAO.pptx có 8 slides
- [ ] Video mp4: <100MB, HD quality
- [ ] YouTube link hoạt động
- [ ] Title không có dấu "_"

### Documentation
- [ ] HUONG_DAN.md
- [ ] QUICKSTART.md
- [ ] TONGHOP.md

---

## 🎉 HOÀN THÀNH!

Nếu hoàn thành hết các bước trên:
1. ✅ Code chạy được
2. ✅ 3 states demo đầy đủ
3. ✅ Video uploaded YouTube
4. ✅ Nộp trên Drive

**→ BẠN ĐÃ SẴN SÀNG NỘP BÀI! 🚀**

---

## 📞 TROUBLESHOOTING

| Vấn Đề | Giải Pháp |
|--------|----------|
| App crash | Chải cache: `flutter clean` + `flutter pub get` |
| Import error red | Ensure folder structure: lib/models/, lib/services/, lib/screens/ |
| API không response | Check internet, API có thể down |
| Video không upload | Check dung lượng < 100MB, format mp4 |
| YouTube bị xoá | Video quá dài hoặc có vấn đề bản quyền |

---

**NGÀY: 2026-03-06**
**READY: ✅**

