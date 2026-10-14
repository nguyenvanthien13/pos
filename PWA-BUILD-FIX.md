# Nàng Hoa POS PWA – Hướng dẫn build

## Cài đặt
Giải nén ZIP. Nội dung ZIP cần đặt tại gốc repository nanghoa (frontend/, backend/, .github/).
Mở PowerShell ở thư mục repository, KHÔNG phải C:\Windows\system32.

```powershell
cd frontend
npm install
npm run build
npm run preview
```

## GitHub Pages
Settings > Pages > Source = GitHub Actions.
`frontend/vite.config.ts` dùng `base: '/nanghoa/'`.
Workflow `.github/workflows/deploy-pages.yml` cài dependency và build từ `frontend`, upload `frontend/dist`.

## Sửa lỗi build
Đã thêm `@types/react`, `@types/react-dom`, `@types/node` và `src/vite-env.d.ts` nhằm xử lý TS7016/TS7026/TS2339 trong log. Các lỗi TS7006 có thể là lỗi dây chuyền do thiếu type React; nếu còn lỗi, lấy log mới để xử lý.

## Giới hạn
GitHub Pages chỉ chạy frontend. Email tự động cần backend/SMTP triển khai riêng. Dữ liệu localStorage không đồng bộ giữa thiết bị. Cài PWA cần trình duyệt hỗ trợ, HTTPS, manifest và service worker.
