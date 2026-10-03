BÀI LÀM: TH1 - XÂY DỰNG ỨNG DỤNG QUẢN LÝ TÀI LIỆU HỌC TẬP THEO KIẾN TRÚC CASHEW
01. Phân tích yêu cầu chức năng và thiết kế sơ đồ luồng dữ liệu cho ứng dụng quản lý tài liệu
1. Phân tích yêu cầu chức năng
   Quản lý danh mục tài liệu: Phân loại tài liệu thành các nhóm chính như Bài giảng, Bài tập, Tài liệu tham khảo.
   Thêm tài liệu: Nhập tiêu đề, danh mục, liên kết/file và mô tả tài liệu mới.
   Cập nhật (Sửa) tài liệu: Chỉnh sửa thông tin chi tiết của tài liệu hiện có.
   Xóa tài liệu: Loại bỏ tài liệu không còn sử dụng.
   Tìm kiếm & Lọc: Tìm kiếm theo từ khóa (tiêu đề/mô tả) và lọc danh sách tài liệu theo từng danh mục cụ thể.
2. Thiết kế sơ đồ luồng dữ liệu
   [ Giao diện Người dùng (UI Layer) ]
            │                  ▲
   1. Nhập  │                  │ 4. Cập nhật
   dữ liệu  │                  │    trạng thái
            ▼                  │
   [ Bộ điều khiển Trạng thái (Controller / State Management Layer) ]
            │                  ▲
   2. Gọi   │                  │ 3. Trả về
   dịch vụ  │                  │    kết quả
            ▼                  │
   [ Lớp Xử lý Dữ liệu (Repository Layer) ] ──► [ Mô hình Dữ liệu (Document Model) ]
02. Thiết lập cấu trúc thư mục và phân lớp hệ thống theo đúng tiêu chuẩn của kiến trúc Cashew
    Ứng dụng được phân tách thành các lớp độc lập theo kiến trúc Cashew:
    lib/
    ├── data/
    │   ├── models/
    │   │   └── document_model.dart       # Lớp định nghĩa đối tượng tài liệu
    │   └── repositories/
    │       └── document_repository.dart  # Lớp quản lý và xử lý dữ liệu CRUD
    ├── logic/
    │   └── document_controller.dart     # Lớp quản lý trạng thái (State Management)
    └── ui/
    ├── screens/
    │   ├── document_list_screen.dart # Màn hình danh sách & tìm kiếm
    │   └── add_edit_document_screen.dart # Màn hình thêm/sửa tài liệu
    └── widgets/
    └── document_card.dart        # Component hiển thị thẻ tài liệu
03. Triển khai các chức năng cốt lõi: Thêm, sửa, xóa và tìm kiếm tài liệu học tập
    File 1: lib/data/models/document_model.dart
    File 2: lib/data/repositories/document_repository.dart
    File 3: lib/logic/document_controller.dart
    File 4: lib/ui/widgets/document_card.dart
    File 5: lib/ui/screens/add_edit_document_screen.dart
    File 6: lib/ui/screens/document_list_screen.dart 
    File 7: lib/main.dart
04. Kiểm thử tính đúng đắn của việc phân tách logic giữa các lớp trong kiến trúc
    Để đảm bảo nguyên tắc phân tách trách nhiệm (Separation of Concerns) và duy trì tính đúng đắn của kiến trúc Cashew trong dự án, các bài kiểm thử (Unit Tests / Integration Tests) được thực hiện theo các cấp độ sau:

#### 1. Kiểm thử Lớp Giao diện (UI / Presentation Layer)
- **Mục tiêu:** Kiểm tra giao diện phản ứng đúng với các trạng thái (State) từ controller/bloc cung cấp, không chứa bất kỳ logic xử lý dữ liệu hay tính toán kinh doanh nào.
- **Nội dung kiểm thử:**
    - [x] Hiển thị chính xác danh sách tài liệu khi trạng thái trả về dữ liệu thành công (`Success State`).
    - [x] Hiển thị thông báo/loading khi đang tải dữ liệu (`Loading State`).
    - [x] Gửi đúng sự kiện (Event) hoặc gọi đúng hàm của Controller khi người dùng tương tác (bấm nút Thêm, Sửa, Xóa).

#### 2. Kiểm thử Lớp Quản lý Trạng thái & Logic Nghiệp vụ (State Management / Controller / Logic Layer)
- **Mục tiêu:** Đảm bảo toàn bộ luồng xử lý dữ liệu nghiệp vụ hoạt động chính xác độc lập với giao diện người dùng.
- **Nội dung kiểm thử:**
    - [x] Xác minh logic validate dữ liệu tài liệu đầu vào (tiêu đề không được để trống, định dạng tệp tin hợp lệ).
    - [x] Kiểm tra việc chuyển đổi trạng thái (State Transitions) chuẩn xác sau khi nhận kết quả từ Repository.
    - [x] Sử dụng **Mock Repository** để cô lập bài test, đảm bảo controller không phụ thuộc trực tiếp vào cơ sở dữ liệu thật.

#### 3. Kiểm thử Lớp Dữ liệu (Data / Repository Layer)
- **Mục tiêu:** Kiểm thử tính chính xác của việc truy xuất, lưu trữ và biến đổi dữ liệu (Data Source/Local Storage/API).
- **Nội dung kiểm thử:**
    - [x] MAPPING chuẩn xác dữ liệu JSON/Database thành các đối tượng Model (Kèm kiểm tra ép kiểu và xử lý `null`).
    - [x] Đảm bảo các hàm CRUD (Create, Read, Update, Delete) tương tác đúng với nguồn dữ liệu local/remote.
    - [x] Xử lý ngoại lệ (Exception Handling) chính xác khi gặp lỗi kết nối hoặc dữ liệu không hợp lệ.

#### 4. Đánh giá Kết quả Kiểm thử Kiến trúc
- **Tính độc lập (Decoupling):** Thay đổi giao diện UI không làm ảnh hưởng đến logic nghiệp vụ và ngược lại.
- **Tính dễ kiểm thử (Testability):** Có thể viết Unit Test cho 100% logic nghiệp vụ mà không cần khởi chạy máy ảo Android hay dựng UI.      

05. Đóng gói mã nguồn và viết báo cáo giải trình về cách áp dụng kiến trúc Cashew vào dự án
    Mô hình kiến trúc: Áp dụng mô hình phân tách 3 lớp chuẩn từ dự án Cashew: Data Layer (Model & Repository), Logic Layer (Controller/State) và UI Layer (Screens & Widgets).
    Mô-đun hóa & Độc lập: Các thành phần xử lý dữ liệu hoàn toàn tách rời khỏi giao diện hiển thị, đảm bảo hệ thống có khả năng mở rộng dễ dàng (ví dụ: thay đổi lưu trữ từ bộ nhớ RAM sang cơ sở dữ liệu SQLite/Hive).
    Khả năng nâng cấp: Dễ dàng thêm các tính năng mới (ví dụ: xem trước file PDF, lưu tài liệu yêu thích) mà không cần viết lại mã nguồn hiện có.