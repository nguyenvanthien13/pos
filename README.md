
# Florist POS — hệ thống POS và quản lý tiệm hoa

Bản MVP chạy được để thử nghiệm nghiệp vụ. Frontend dùng React + TypeScript + Vite; dữ liệu demo được lưu trong `localStorage`. Có scaffold backend NestJS + Prisma + PostgreSQL để tiếp tục đưa sang môi trường nhiều người dùng.

## Chức năng frontend hiện có
- Dashboard doanh thu, đơn hàng, cảnh báo tồn kho.
- POS: tìm sản phẩm, thêm/bớt số lượng, giảm giá, phí giao hàng, chọn khách, tạo đơn.
- Thanh toán tiền mặt hoặc QR chuyển khoản; QR được tạo theo thông tin tài khoản do chủ tiệm cấu hình.
- Quản lý sản phẩm, danh mục, tồn kho, khách hàng, đơn hàng, giao hàng, báo cáo và cài đặt.
- Dữ liệu demo được khởi tạo tự động lần đầu và lưu trên trình duyệt.

## Chạy frontend
```bash
cd frontend
npm install
npm run dev
```
Mở URL Vite hiển thị trong terminal.

## Chạy backend scaffold (cần Node.js, Docker)
```bash
docker compose up -d db
cd backend
cp .env.example .env
npm install
npx prisma generate
npx prisma migrate dev --name init
npm run start:dev
```
Backend scaffold cung cấp Prisma schema và health endpoint; chưa phải toàn bộ API nghiệp vụ. Frontend hiện chưa kết nối backend.

## Lưu ý bắt buộc trước khi vận hành thật
- `localStorage` chỉ phù hợp demo/một trình duyệt; dữ liệu không tự đồng bộ giữa thiết bị và không thay thế cơ sở dữ liệu server.
- QR là QR chuyển khoản theo cấu hình, không chứng minh tiền đã vào tài khoản. Thu ngân phải xác nhận trên kênh ngân hàng hợp lệ. Tự động đối soát cần API/webhook chính thức của ngân hàng/nhà cung cấp thanh toán.
- Giá vốn/lợi nhuận chỉ là ước tính theo dữ liệu nhập vào, không phải báo cáo kế toán chuẩn.
- Cần bổ sung xác thực, phân quyền backend, kiểm thử, audit log, sao lưu/khôi phục, bảo vệ dữ liệu cá nhân và kiểm thử bảo mật trước khi triển khai thật.


## Chạy nhanh trên Windows
1. Cài Node.js bản LTS từ https://nodejs.org/ (nếu máy chưa có).
2. Giải nén toàn bộ ZIP.
3. Mở thư mục `florist-pos` và nhấp đúp `run-pos.bat`.
4. Lần đầu chạy cần Internet để tải thư viện npm. Khi terminal hiện URL Vite, mở URL đó trên trình duyệt (thường là `http://localhost:5173`).
5. Giữ cửa sổ terminal mở trong lúc sử dụng; nhấn `Ctrl+C` để dừng.

`run-pos.bat` chỉ cài thư viện và chạy frontend demo. Backend PostgreSQL là phần riêng, cần Docker và các bước ở mục “Chạy backend scaffold”.


## Cập nhật chức năng quản lý

- **Bán hàng POS:** nhập email khách, ghi chú theo đơn; tạo đơn và xem chi tiết; có thể hủy đơn hoặc xóa đơn.
- **Sản phẩm:** thêm sản phẩm, sửa giá và xóa sản phẩm.
- **Kho & nguyên liệu:** đánh dấu còn hàng/hết hàng, điều chỉnh số lượng và xóa mặt hàng.
- **Đơn đặt hoa:** lọc đơn theo tháng bằng bộ chọn lịch, tìm kiếm ghi chú/email, xem và sửa ghi chú, mở ứng dụng email qua liên kết `mailto:`, hủy hoặc xóa đơn.
- **Giao hàng và khách hàng:** bổ sung thao tác xóa bản ghi tương ứng.

**Lưu ý email:** nút Gmail mở ứng dụng email mặc định hoặc trang web đã được trình duyệt liên kết với `mailto:`; đây chưa phải tích hợp Gmail API và không tự gửi email.

## Cập nhật nghiệp vụ POS (13/10/2026)
- POS hỗ trợ chọn hình thức mua tại cửa hàng hoặc online; đơn online yêu cầu địa chỉ và có ngày giao dự kiến.
- Phương thức đặt cọc ghi nhận 50% tổng tiền. Trạng thái thanh toán gồm Đã thanh toán, Chưa thanh toán, Đã cọc, Đã hủy; trạng thái giao hàng quản lý riêng gồm Chưa giao/Đã giao.
- Sản phẩm được lưu vào localStorage của trình duyệt sau khi thêm.
- Kho có trạng thái Còn hàng (xanh) / Hết hàng (đỏ), nhật ký nhập/xuất theo ngày, bộ lọc ngày và xóa dòng nhật ký.
- Đơn đặt hoa có bộ lọc tháng, tìm kiếm, xem/sửa ghi chú, xem địa chỉ/ngày giao và xóa đơn.
- Giao hàng có trường chọn hãng (GHN, GHTK, Viettel Post, J&T, Ahamove) và mã vận đơn.

### Giới hạn tích hợp vận chuyển
Chưa có API vận chuyển thực tế được gọi. Để tạo vận đơn tự động, tính phí giao và đồng bộ tracking cần chọn hãng vận chuyển, có tài khoản doanh nghiệp/API key, rồi triển khai endpoint bảo mật ở backend. Không đặt API key trong frontend. Dữ liệu hiện tại vẫn được lưu trong localStorage trên từng trình duyệt, chưa đồng bộ nhiều máy.


## Bản Nàng Hoa
- POS: nút Đơn hàng mới đặt lại giỏ và biểu mẫu, có xác nhận khi giỏ chưa thanh toán.
- Sao lưu Excel: mục Sao lưu Excel xuất toàn bộ đơn hàng dạng .xlsx.
- Thương hiệu Nàng Hoa; địa chỉ 941 Phan Văn Trị, Hạnh Thông, Gò Vấp.
- Cài đặt `npm install` trong frontend để tải thêm thư viện xlsx.
- Dữ liệu chỉ nằm trên localStorage của trình duyệt, cần xuất file thường xuyên.


## Ảnh sản phẩm, tạo nhanh và email tự động
- Tại **Sản phẩm**, chọn **Thêm sản phẩm** rồi tải JPG/PNG/WebP (tối đa 5MB); ảnh được nén khi lưu trong trình duyệt. Trong **Bán hàng POS**, nút **Tạo sản phẩm nhanh** lưu sản phẩm và thêm vào giỏ.
- Email tự động yêu cầu **backend chạy thực sự** và cấu hình SMTP. Sao chép `backend/.env.example` thành `backend/.env`, thay các giá trị SMTP thật (Gmail dùng mật khẩu ứng dụng). Chạy `cd backend && npm install && npm run start:dev`. Frontend mặc định gọi `http://localhost:3001/api/order-email`; nếu backend chạy cổng khác, đặt `VITE_API_URL` trong `frontend/.env`.
- Đơn hàng được lưu ngay cả khi gửi email thất bại; trạng thái email hiển thị trong chi tiết đơn. Không để mật khẩu SMTP trong frontend hoặc đưa file `.env` lên kho công khai.
- **Lưu ý:** bản demo vẫn lưu đơn hàng và ảnh vào localStorage của trình duyệt; có giới hạn dung lượng, chưa có xác thực nhân viên, backend chưa có cơ sở dữ liệu đơn hàng. Trước khi vận hành thật cần lưu đơn/ảnh vào backend và gửi email theo đơn hàng đã xác thực ở máy chủ để tránh lạm dụng API.


# run code bằng power shell 
Bước 1: Chuyển đến thư mục dự án
Sao chép lệnh sau:
cd "D:\nanghoa\florist-pos-mvp\florist-pos"


Bước 2: Kiểm tra file chạy và cấu hình
Chạy lần lượt:
Test-Path ".\run-pos.bat"
Test-Path ".\frontend\package.json"
Test-Path ".\backend\package.json"


Kết quả mong đợi là True cho cả ba dòng.
Sau đó kiểm tra nội dung script:
Get-Content ".\run-pos.bat"


Bước 3: Cài thư viện cho giao diện POS
Nếu frontend\package.json tồn tại, chạy:
cd ".\frontend"
npm install


Lệnh này có thể mất vài phút và cần Internet. Chưa cần chạy backend hoặc PostgreSQL ở bước này.
Nếu cài thành công, khởi động giao diện:
npm run dev


Mở địa chỉ Vite hiển thị trong PowerShell, thường là http://localhost:5173.


## V4 demo role access (GitHub Pages)

- Demo administrator: `admin` / `Admin@123`
- Demo employee: `user` / `User@123`
- Employee cannot access the delete-invoice buttons in the orders and delivery views, or the reset-demo-data button. Admin can delete invoices.
- **Security warning:** These are publicly visible demo credentials. Authorization is only enforced in the browser. Data is still in `localStorage`, and browser tools can bypass restrictions. **Do not use this as real access control or with real customer/payment data.** Production requires server-side authentication, password hashing, session management and role authorization for DELETE endpoints.
- GitHub Pages Vite base path is `/nang-hoa-pos-v4/`.
