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
            HttpServletRequest request) {

        String uploadedFileName = fileUploadService.uploadEventBanner(imageFile, request);

        if (uploadedFileName == null) {
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
}
