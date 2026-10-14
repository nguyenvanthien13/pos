# Nàng Hoa POS — PWA

## Chạy thử trên máy

```bash
cd frontend
npm install
npm run dev
```

Vite chạy localhost. Để kiểm tra PWA/service worker thực tế:

```bash
npm run build
npm run preview
```

Mở URL preview Vite có tiền tố `/nanghoa/` (thường là `http://localhost:4173/nanghoa/`). Trong Chrome DevTools > Application kiểm tra Manifest, Service Workers, Cache Storage. Mở trang một lần khi có mạng, bật Offline trong DevTools và tải lại để kiểm tra cache. Lần đầu phải online để tải ứng dụng.

## Deploy GitHub Pages

1. Tại repository `nguyenvanthien13/nanghoa`, đặt nội dung **bên trong thư mục `florist-pos`** vào gốc repository: `frontend/`, `backend/`, `.github/`, ...
2. GitHub > Settings > Pages > Build and deployment > Source: GitHub Actions.
3. Commit và push lên nhánh `main`; Actions > `Deploy Nang Hoa PWA`.
4. Mở https://nguyenvanthien13.github.io/nanghoa/; kiểm tra `manifest.webmanifest`, `sw.js`, file JS/CSS trong Network không 404.

**Nếu giữ nguyên cấu trúc lồng thư mục** (`florist-pos-mvp/florist-pos/`), phải sửa `working-directory` và `path` trong workflow cho đúng. Workflow cung cấp ở đây giả định đã đưa `frontend` vào gốc repository.

## Cài đặt

- Android/Chrome: mở trang HTTPS > menu ⋮ > Install app / Thêm vào màn hình chính. Có thể xuất hiện banner Cài ứng dụng.
- Windows/Chrome hoặc Edge: biểu tượng cài ứng dụng trên thanh địa chỉ hoặc menu > Apps > Install this site as an app.
- iPhone/Safari: Chia sẻ > Thêm vào Màn hình chính (Add to Home Screen). iOS thường không phát sự kiện `beforeinstallprompt`, nên dùng menu Safari.

## Lưu ý quan trọng

- Service worker cache các file frontend để mở lại offline sau lần tải thành công. **Không đảm bảo mọi thao tác nghiệp vụ hoạt động offline** (gửi email, ảnh QR ngân hàng, các API ngoài vẫn cần mạng).
- Đơn hàng, sản phẩm, ảnh upload đang lưu ở `localStorage`: chỉ có trên cùng trình duyệt, cùng thiết bị. Xóa dữ liệu trang có thể mất đơn; cần sao lưu Excel/JSON định kỳ. Ảnh lớn có thể làm đầy hạn mức localStorage.
- GitHub Pages chỉ lưu trang tĩnh, **không chạy backend NestJS**. Gửi Gmail tự động cần triển khai backend riêng, cấu hình SMTP và biến `VITE_API_URL` trỏ đến HTTPS backend; phải cấu hình CORS, bảo mật API và không đặt mật khẩu Gmail trong frontend.
- `vite.config.ts` đã đặt `base: '/nanghoa/'` để sửa lỗi 404 JS/CSS khi deploy dưới repository này.
- Nếu ứng dụng có bản mới mà không cập nhật ngay, đóng và mở lại hoặc tải lại trang khi có mạng. Không chỉnh sửa file `dist/sw.js` thủ công vì file được tạo tự động sau mỗi build.
