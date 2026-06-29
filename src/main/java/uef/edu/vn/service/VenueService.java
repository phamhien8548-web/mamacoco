/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uef.edu.vn.model.Venue;
import uef.edu.vn.repository.VenueRepository;

@Service
public class VenueService {

    @Autowired
    private VenueRepository venueRepository;

    public List<Venue> getAllVenues() {
        return venueRepository.findAll();
    }

    public Venue getVenueById(int id) {
        return venueRepository.findById(id);
    }

    public void saveVenue(Venue venue) {
        venueRepository.save(venue);
    }

    public void updateVenue(Venue venue) {
        venueRepository.update(venue);
    }

    public void deleteVenue(int id) {
        venueRepository.delete(id);
    }
}
