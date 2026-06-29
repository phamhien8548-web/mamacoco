package uef.edu.vn.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uef.edu.vn.model.Event;
import uef.edu.vn.repository.EventRepository;

@Service
public class EventService {

    @Autowired
    private EventRepository eventRepository;

    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    public Event getEventById(int id) {
        return eventRepository.findById(id);
    }

    public Event findById(int id) {
        return eventRepository.findById(id);
    }

    public List<Event> searchEvents(String keyword, Integer categoryId, String date) {
        return eventRepository.searchEvents(keyword, categoryId, date);
    }

    public void saveEvent(Event event) {
        eventRepository.save(event);
    }

    public void updateEvent(Event event) {
        eventRepository.update(event);
    }

    public void deleteEvent(int id) {
        eventRepository.delete(id);
    }
}
