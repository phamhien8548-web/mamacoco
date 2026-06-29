/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.model.EventSchedule;
import uef.edu.vn.service.EventScheduleService;
import uef.edu.vn.service.EventService;

@Controller
@RequestMapping("/admin/schedules")
public class EventScheduleController {

    @Autowired
    private EventScheduleService eventScheduleService;

    @Autowired
    private EventService eventService;

    private final String path = "/WEB-INF/views/admin/schedules/";

    @GetMapping
    public String list(Model model) {
        model.addAttribute("schedules", eventScheduleService.getAllSchedules());
        model.addAttribute("body", path + "list.jsp");
        return "layout/main";
    }

    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("schedule", new EventSchedule());
        model.addAttribute("events", eventService.getAllEvents());

        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") int id, Model model) {
        EventSchedule schedule = eventScheduleService.getScheduleById(id);

        schedule.setStartTime(toInputDateTime(schedule.getStartTime()));
        schedule.setEndTime(toInputDateTime(schedule.getEndTime()));

        model.addAttribute("schedule", schedule);
        model.addAttribute("events", eventService.getAllEvents());

        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("schedule") EventSchedule schedule) {
        if (schedule.getId() == 0) {
            eventScheduleService.saveSchedule(schedule);
        } else {
            eventScheduleService.updateSchedule(schedule);
        }

        return "redirect:/admin/schedules";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") int id) {
        eventScheduleService.deleteSchedule(id);
        return "redirect:/admin/schedules";
    }

    private String toInputDateTime(String value) {
        if (value == null || value.length() < 16) {
            return "";
        }

        return value.replace(" ", "T").substring(0, 16);
    }
}
