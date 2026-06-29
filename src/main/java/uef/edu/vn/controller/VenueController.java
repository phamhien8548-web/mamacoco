/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.model.Venue;
import uef.edu.vn.service.VenueService;

@Controller
@RequestMapping("/admin/venues")
public class VenueController {

    @Autowired
    private VenueService venueService;

    private final String path = "/WEB-INF/views/admin/venues/";

    @GetMapping
    public String list(Model model) {
        model.addAttribute("venues", venueService.getAllVenues());
        model.addAttribute("body", path + "list.jsp");
        return "layout/main";
    }

    @GetMapping("/add")
    public String add(Model model) {
        Venue venue = new Venue();
        venue.setStatus("ACTIVE");
        model.addAttribute("venue", venue);
        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") int id, Model model) {
        model.addAttribute("venue", venueService.getVenueById(id));
        model.addAttribute("body", path + "form.jsp");
        return "layout/main";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("venue") Venue venue) {
        if (venue.getId() == 0) {
            venueService.saveVenue(venue);
        } else {
            venueService.updateVenue(venue);
        }

        return "redirect:/admin/venues";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") int id) {
        venueService.deleteVenue(id);
        return "redirect:/admin/venues";
    }
}
