package uef.edu.vn.service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadService {

    // CHỈ ĐỊNH ĐƯỜNG DẪN LƯU ẢNH CỐ ĐỊNH TRÊN Ổ CỨNG MÁY TÍNH
    // (Bên ngoài thư mục dự án nên không bao giờ bị Clean & Build xóa mất)
    private final String UPLOAD_DIR = "C:/event_images/";

    public String uploadEventBanner(MultipartFile file, HttpServletRequest request) {
        if (file == null || file.isEmpty()) {
            return null;
        }

        try {
            // 1. Kiểm tra và tự động tạo thư mục C:/event_images/ nếu nó chưa tồn tại trên máy
            File dir = new File(UPLOAD_DIR);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 2. Tạo tên file mới (Mã hóa UUID) để tránh việc up 2 ảnh trùng tên bị ghi đè
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String newFilename = UUID.randomUUID().toString() + extension;

            // 3. Tiến hành copy file từ Form người dùng dán thẳng vào ổ đĩa C
            Path path = Paths.get(UPLOAD_DIR + newFilename);
            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

            // Trả về tên file để lưu vào Database (ví dụ: a1b2c3d4.jpg)
            return newFilename;

        } catch (Exception e) {
            System.err.println("Lỗi Upload File vào ổ C: " + e.getMessage());
            return null;
        }
    }
}