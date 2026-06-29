/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author LENOVO
 */
package uef.edu.vn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.model.Event;
import uef.edu.vn.service.EventCategoryService;
import uef.edu.vn.service.EventService;

@Controller
@RequestMapping("/events")
public class CustomerEventController {

    @Autowired
    private EventService eventService;

    @Autowired
    private EventCategoryService eventCategoryService;
    
    private final String path = "/WEB-INF/views/customer/events/";

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

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") int id, Model model) {
        // 1. Kiểm tra lấy dữ liệu từ service
        Event event = eventService.getEventById(id);

        // 2. Nếu event null, chuyển hướng về danh sách thay vì để trống
        if (event == null) {
            return "redirect:/events";
        }

        // 3. Truyền đúng tên model để JSP sử dụng
        model.addAttribute("event", event);

        // 4. Trỏ đến đúng đường dẫn view chi tiết
        model.addAttribute("body", path + "detail.jsp");
        return "layout/main";
    }
}
