# Sự Kiện Tốt (Good Event App)

Ứng dụng di động dành cho hệ sinh thái tổ chức sự kiện, kết nối khách hàng có nhu cầu với các đối tác cung cấp dịch vụ, vật tư và thiết kế chuyên nghiệp.

## Giới thiệu

Dự án **Sự Kiện Tốt** (sukientotapp) được xây dựng nhằm tạo ra một platform thuận tiện cho hai nhóm đối tượng chính: Khách hàng (Client) và Đối tác (Partner).

## Tính năng chính

### Cho Khách hàng (Client)

- **Tìm kiếm đối tác:** Đặt đơn tìm kiếm các đơn vị tổ chức sự kiện, MC, âm thanh, ánh sáng,... (Matchmaking).
- **Mua file thiết kế:** Truy cập kho tài nguyên thiết kế sự kiện phong phú.
- **Đặt vật tư sự kiện:** Mua sắm hoặc thuê các trang thiết bị, vật dụng cần thiết cho sự kiện.

### Cho Đối tác (Partner)

- **Nhận đơn hàng:** Tiếp nhận các yêu cầu phù hợp từ khách hàng.
- **Quản lý đơn hàng:** Theo dõi tiến độ và trạng thái các đơn hàng đã nhận.
- **Quản lý dịch vụ:** Tự quản lý hồ sơ, danh sách dịch vụ và năng lực của bản thân trên hệ thống.

## 🛠 Công nghệ & Kỹ thuật

Dự án được xây dựng bằng **Flutter**, sử dụng các thư viện và kiến trúc hiện đại để đảm bảo hiệu năng và trải nghiệm người dùng tối ưu.

### Kiến trúc & Quản lý trạng thái

- **GetX:** Quản lý trạng thái (State Management), Định tuyến (Route Management) và Dependency Injection.
- **Cấu trúc thư mục:** Phân chia rõ ràng theo modules (`features/client`, `features/partner`) và core (`core/`).

### Giao diện (UI/UX)

- **Font:** Sử dụng font chữ **Lexend** hiện đại.
- **Thư viện UI:**
  - `forui`: Bộ UI kit cơ bản.
  - `flutter_rating_bar`: Tính năng đánh giá/xếp hạng.
  - `carousel_slider`: Slider hình ảnh banners.
  - `flutter_swipe_button`: Nút bấm dạng vuốt.
  - `animations`: Các hiệu ứng chuyển động mượt mà.

### Kết nối & Dữ liệu

- **Networking:** `dio` & `pretty_dio_logger` để xử lý HTTP requests.
- **Local Storage:** `get_storage` (lưu trữ key-value nhẹ) và `sqflite` (cơ sở dữ liệu cục bộ).
- **Môi trường:** `flutter_dotenv` để quản lý biến môi trường.

### Tiện ích khác

- **Đăng nhập:** `google_sign_in`.
- **Media:** `camera`, `image_picker` (chụp ảnh/chọn ảnh), `cached_network_image` (cache ảnh).
- **Webview:** `webview_flutter`.
- **Tiện ích:** `permission_handler` (xử lý quyền), `path_provider` (đường dẫn file), `url_launcher` (mở liên kết).

## 📂 Cấu trúc dự án

```
lib/
├── core/                           # Các thành phần cốt lõi (routes, services, utils,...)
│   ├── binding/                # Binding file của Get Router
│   ├── router/                   # Router của ứng dụng
│   ├── service/                 # Các dịch vụ như API, Local storage,...
│   ├── utils/                      # Các tiện ích dành cho việc phát triển
├── features/                    # Các tính năng chính
│   ├── client/                    # Modules dành cho khách hàng
│   ├── partner/                # Modules dành cho đối tác
│   ├── common/              # Các tính năng chung (Auth, Splash,...)
│   └── components/       # Các Widget dùng chung
└── main.dart                   # Điểm khởi chạy ứng dụng
```

## Docs

1. [Router](/lib/core/routes/How_To_Use_Route.md)
2. [Service](/lib/core/services/How_To_Use_Some_Services.md)
3. [Utils](/lib/core/utils/How_And_What.md)
3. [Data](/lib/data/How.md) (Gonna update in future)


## Bắt đầu

1. **Cài đặt dependencies:**

   ```bash
   flutter pub get
   ```

2. **Cấu hình môi trường:**
   Tạo file `.env` từ file mẫu (nếu có) và điền các thông tin key cần thiết.

3. **Chạy ứng dụng:**
   ```bash
   flutter run
   ```

## 📝 Thông tin thêm

- **SDK Version:** Flutter SDK (>=3.10.7)
