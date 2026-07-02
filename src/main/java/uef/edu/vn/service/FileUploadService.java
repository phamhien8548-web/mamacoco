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
            // Lấy đường dẫn thật của webapp/assets/uploads/events/
            String uploadDir = request.getServletContext()
                    .getRealPath("/assets/uploads/events/");

            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // Tạo tên file UUID để tránh trùng
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String newFilename = UUID.randomUUID().toString() + extension;

            Path path = Paths.get(uploadDir, newFilename);
            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

            return newFilename;

        } catch (Exception e) {
            System.err.println("Lỗi Upload File: " + e.getMessage());
            return null;
        }
    }
}

