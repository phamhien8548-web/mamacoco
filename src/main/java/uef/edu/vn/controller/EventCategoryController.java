package uef.edu.vn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import uef.edu.vn.model.EventCategory;
import uef.edu.vn.service.EventCategoryService;

@Controller
@RequestMapping("/admin/categories")
public class EventCategoryController {

    @Autowired
    private EventCategoryService eventCategoryService;

    private final String path = "/WEB-INF/views/admin/categories/";

    @GetMapping
    public String list(Model model) {
        model.addAttribute("categories", eventCategoryService.getAllCategories());
        model.addAttribute("body", path + "list.jsp");
        return "layout/main";
    }

    @GetMapping("/add")
    public String add(Model model) {
        EventCategory category = new EventCategory();
        category.setStatus("ACTIVE");
        model.addAttribute("category", category);
        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") int id, Model model) {
        model.addAttribute("category", eventCategoryService.getCategoryById(id));
        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("category") EventCategory category) {
        if (category.getId() == 0) {
            eventCategoryService.saveCategory(category);
        } else {
            eventCategoryService.updateCategory(category);
        }

        return "redirect:/admin/categories";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") int id) {
        eventCategoryService.deleteCategory(id);
        return "redirect:/admin/categories";
    }
}
