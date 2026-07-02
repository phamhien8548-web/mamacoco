/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import uef.edu.vn.model.EventImage;
import uef.edu.vn.service.EventImageService;
import uef.edu.vn.service.EventService;
import uef.edu.vn.service.FileUploadService;

@Controller
@RequestMapping("/admin/event-images")
public class EventImageController {

    @Autowired
    private EventImageService eventImageService;

    @Autowired
    private EventService eventService;

    @Autowired
    private FileUploadService fileUploadService;

    private final String path = "/WEB-INF/views/admin/event-images/";

    @GetMapping
    public String list(Model model) {
        model.addAttribute("images", eventImageService.getAllImages());
        model.addAttribute("body", path + "list.jsp");
        return "layout/main";
    }

    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("image", new EventImage());
        model.addAttribute("events", eventService.getAllEvents());
        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @PostMapping("/save")
    public String save(@RequestParam("eventId") int eventId,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam(value = "banner", required = false) String banner,
            HttpServletRequest request,
            RedirectAttributes redirectAttrs) {

        String uploadedFileName = fileUploadService.uploadEventBanner(imageFile, request);

        if (uploadedFileName == null) {
            redirectAttrs.addFlashAttribute("errorMsg", "Upload ảnh thất bại! Vui lòng thử lại.");
            return "redirect:/admin/event-images/add";
        }

        EventImage image = new EventImage();
        image.setEventId(eventId);
        image.setImageUrl(uploadedFileName);
        image.setBanner(banner != null);

        eventImageService.saveImage(image);
        return "redirect:/admin/event-images";
    }

    @GetMapping("/set-banner/{id}")
    public String setBanner(@PathVariable("id") int id) {
        eventImageService.setAsBanner(id);
        return "redirect:/admin/event-images";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") int id) {
        eventImageService.deleteImage(id);
        return "redirect:/admin/event-images";
    }

    // 1. Hàm GET: Khi bấm nút "Sửa", link sẽ có dạng /admin/event-images/edit/5
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable("id") int id, Model model) {
        // Lấy dữ liệu ảnh cũ từ DB ra
        EventImage image = eventImageService.getImageById(id);
        model.addAttribute("image", image);

        // ĐÃ SỬA: Đổi thành getAllEvents() cho đúng với EventService của bạn
        model.addAttribute("events", eventService.getAllEvents());

        // ĐÃ SỬA: Đưa về đúng cấu trúc layout/main của project
        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

// 2. Hàm POST: Khi bấm "Cập nhật" trên Form sửa
    @PostMapping("/update")
    public String update(@RequestParam("id") int id,
            @RequestParam("eventId") int eventId,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam(value = "banner", required = false) String banner,
            HttpServletRequest request,
            RedirectAttributes redirectAttrs) {
        try {
            // Lấy lại dữ liệu ảnh cũ từ database để biết tên file cũ là gì
            EventImage oldImage = eventImageService.getImageById(id);
            String finalFileName = oldImage.getImageUrl(); // Mặc định giữ lại tên file cũ

            // Kiểm tra xem người dùng có chọn file ảnh MỚI không
            if (imageFile != null && !imageFile.isEmpty()) {
                // Nếu có ảnh mới -> gọi service upload lên ổ C giống hàm add
                String uploadedFileName = fileUploadService.uploadEventBanner(imageFile, request);
                if (uploadedFileName != null) {
                    finalFileName = uploadedFileName; // Đổi sang tên file UUID mới
                }
            }

            // Gán dữ liệu mới vào đối tượng để chuẩn bị update
            EventImage image = new EventImage();
            image.setId(id);
            image.setEventId(eventId);
            image.setImageUrl(finalFileName);
            image.setBanner(banner != null);

            // Gọi service để chạy lệnh UPDATE SQL
            eventImageService.updateImage(image);

            redirectAttrs.addFlashAttribute("successMsg", "Cập nhật ảnh thành công!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMsg", "Lỗi cập nhật: " + e.getMessage());
        }
        return "redirect:/admin/event-images";
    }
}
