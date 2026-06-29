package uef.edu.vn.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import uef.edu.vn.model.Event;
import uef.edu.vn.service.EventCategoryService;
import uef.edu.vn.service.EventService;
import uef.edu.vn.service.FileUploadService;
import uef.edu.vn.service.VenueService;

@Controller
@RequestMapping("/admin/events")
public class AdminEventController {

    private final String path = "/WEB-INF/views/admin/events/";

    @Autowired
    private EventService eventService;

    @Autowired
    private EventCategoryService eventCategoryService;

    @Autowired
    private VenueService venueService;

    @Autowired
    private FileUploadService fileUploadService;

    @GetMapping
    public String list(@RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "categoryId", required = false) Integer categoryId,
            @RequestParam(value = "date", required = false) String date,
            Model model) {

        model.addAttribute("events", eventService.searchEvents(keyword, categoryId, date));
        model.addAttribute("categories", eventCategoryService.getAllCategories());

        model.addAttribute("keyword", keyword);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("date", date);

        model.addAttribute("body", path + "list.jsp");
        return "layout/main";
    }

    @GetMapping("/add")
    public String add(Model model) {
        Event event = new Event();
        event.setStatus("DRAFT");

        model.addAttribute("event", event);
        model.addAttribute("categories", eventCategoryService.getAllCategories());
        model.addAttribute("venues", venueService.getAllVenues());

        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") int id, Model model) {
        model.addAttribute("event", eventService.getEventById(id));
        model.addAttribute("categories", eventCategoryService.getAllCategories());
        model.addAttribute("venues", venueService.getAllVenues());

        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") int id, Model model) {
        model.addAttribute("event", eventService.getEventById(id));

        model.addAttribute("body", path + "detail.jsp");
        return "layout/main";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("event") Event event,
            @RequestParam(value = "bannerFile", required = false) MultipartFile bannerFile,
            @RequestParam(value = "oldBannerImage", required = false) String oldBannerImage,
            HttpSession session, // MỚI THÊM: Tiêm Session để lấy ID Admin
            HttpServletRequest request) {

        // 1. Xử lý Upload file ảnh bìa
        String uploadedFileName = fileUploadService.uploadEventBanner(bannerFile, request);

        if (uploadedFileName != null) {
            event.setBannerImage(uploadedFileName);
        } else {
            event.setBannerImage(oldBannerImage);
        }

        // 2. Xử lý trạng thái mặc định
        if (event.getStatus() == null || event.getStatus().trim().isEmpty()) {
            event.setStatus("DRAFT");
        }

        // 3. ĐÃ VÁ LỖI 4: TRÍCH XUẤT ĐÍCH DANH ADMIN ĐANG THAO TÁC
        uef.edu.vn.model.User currentUser = (uef.edu.vn.model.User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            // Nếu mất Session (hết hạn đăng nhập), lập tức từ chối lưu và đẩy ra trang Login
            return "redirect:/login?error=unauthenticated";
        }
        
        // Gán ID của vị Admin này vào trường createdBy
        event.setCreatedBy(currentUser.getId());

        // 4. Lưu mới hoặc Cập nhật xuống Database
        if (event.getId() == 0) {
            eventService.saveEvent(event);
        } else {
            eventService.updateEvent(event);
        }

        return "redirect:/admin/events";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") int id) {
        eventService.deleteEvent(id);

        return "redirect:/admin/events";
    }
}
