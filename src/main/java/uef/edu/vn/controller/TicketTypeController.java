/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import java.math.BigDecimal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.model.TicketType;
import uef.edu.vn.service.EventService;
import uef.edu.vn.service.TicketTypeService;

@Controller
@RequestMapping("/admin/ticket-types")
public class TicketTypeController {

    @Autowired
    private TicketTypeService ticketTypeService;

    @Autowired
    private EventService eventService;

    private final String path = "/WEB-INF/views/admin/ticket-types/";

    @GetMapping
    public String list(Model model) {
        model.addAttribute("ticketTypes", ticketTypeService.getAllTicketTypes());
        model.addAttribute("body", path + "list.jsp");
        return "layout/main";
    }

    @GetMapping("/add")
    public String add(Model model) {
        TicketType ticketType = new TicketType();
        ticketType.setStatus("OPEN");
        ticketType.setSoldQuantity(0);
        ticketType.setPrice(BigDecimal.ZERO);

        model.addAttribute("ticketType", ticketType);
        model.addAttribute("events", eventService.getAllEvents());

        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") int id, Model model) {
        model.addAttribute("ticketType", ticketTypeService.getTicketTypeById(id));
        model.addAttribute("events", eventService.getAllEvents());

        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("ticketType") TicketType ticketType) {
        if (ticketType.getStatus() == null || ticketType.getStatus().trim().isEmpty()) {
            ticketType.setStatus("OPEN");
        }

        if (ticketType.getId() == 0) {
            ticketTypeService.saveTicketType(ticketType);
        } else {
            ticketTypeService.updateTicketType(ticketType);
        }

        return "redirect:/admin/ticket-types";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") int id) {
        ticketTypeService.deleteTicketType(id);
        return "redirect:/admin/ticket-types";
    }
}
