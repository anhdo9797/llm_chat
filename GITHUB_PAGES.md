# Hướng dẫn Deploy Flutter Web App lên GitHub Pages

## 1. Chuẩn bị Repository

1. Push code lên GitHub repository của bạn:
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/username/repo-name.git
git push -u origin main
```

2. Vào repository settings:
- Truy cập Settings > Pages
- Source: Deploy from a branch 
- Branch: gh-pages (sẽ được tạo tự động)
- Folder: / (root)
- Save

## 2. Cấu hình GitHub Actions

1. Tạo thư mục .github/workflows trong repository:
```bash
mkdir -p .github/workflows
```

2. File deploy.yml đã được tạo với cấu hình:
- Trigger khi push vào branch main
- Setup Flutter environment
- Build web app
- Deploy lên gh-pages branch

3. Commit và push workflow file:
```bash
git add .github/workflows/deploy.yml
git commit -m "Add GitHub Pages deploy workflow"
git push origin main
```

## 3. Deploy

1. Khi bạn push code lên main branch, GitHub Actions sẽ tự động:
- Build Flutter web app
- Deploy lên gh-pages branch
- Publish trang web

2. Kiểm tra deployment:
- Vào repository > Actions tab để xem workflow status
- Đợi workflow hoàn thành (thường mất 2-3 phút)
- Truy cập https://username.github.io/repo-name

## 4. Cập nhật Application

1. Cập nhật API endpoint:
```dart
// lib/core/constants/app_constants.dart
class AppConstants {
  static const String baseUrl = 'https://api.example.com'; // Update API URL
}
```

2. Mỗi lần update code:
```bash
git add .
git commit -m "Update code"
git push origin main
```

GitHub Actions sẽ tự động build và deploy phiên bản mới.

## 5. Troubleshooting

1. Nếu build fail:
- Kiểm tra Actions tab để xem error logs
- Verify Flutter version trong deploy.yml
- Kiểm tra dependencies trong pubspec.yaml

2. Nếu deploy thành công nhưng trang trắng:
- Kiểm tra base href trong deploy.yml
- Verify file index.html trong build/web
- Check browser console errors

3. Nếu API calls fail:
- Verify CORS configuration trên API server
- Check API endpoint URL
- Kiểm tra network requests trong browser DevTools

## 6. Custom Domain (Optional)

1. Thêm CNAME file trong web/:
```
yourdomain.com
```

2. Update DNS của domain:
- Thêm CNAME record trỏ đến username.github.io
- Đợi DNS propagate (có thể mất đến 24 giờ)

3. Trong repository settings:
- Pages > Custom domain: nhập domain của bạn
- Chọn "Enforce HTTPS" nếu có SSL
