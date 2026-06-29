/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uef.edu.vn.model.EventImage;
import uef.edu.vn.repository.EventImageRepository;

@Service
public class EventImageService {

    @Autowired
    private EventImageRepository eventImageRepository;

    public List<EventImage> getAllImages() {
        return eventImageRepository.findAll();
    }

    public List<EventImage> getImagesByEventId(int eventId) {
        return eventImageRepository.findByEventId(eventId);
    }

    public EventImage getImageById(int id) {
        return eventImageRepository.findById(id);
    }

    public void saveImage(EventImage image) {
        eventImageRepository.save(image);
    }

    public void setAsBanner(int id) {
        eventImageRepository.setAsBanner(id);
    }

    public void deleteImage(int id) {
        eventImageRepository.delete(id);
    }
}
