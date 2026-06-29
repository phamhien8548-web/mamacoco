package uef.edu.vn.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uef.edu.vn.model.EventCategory;
import uef.edu.vn.repository.EventCategoryRepository;

@Service
public class EventCategoryService {

    @Autowired
    private EventCategoryRepository eventCategoryRepository;

    public List<EventCategory> getAllCategories() {
        return eventCategoryRepository.findAll();
    }

    public EventCategory getCategoryById(int id) {
        return eventCategoryRepository.findById(id);
    }

    public void saveCategory(EventCategory category) {
        eventCategoryRepository.save(category);
    }

    public void updateCategory(EventCategory category) {
        eventCategoryRepository.update(category);
    }

    public void deleteCategory(int id) {
        eventCategoryRepository.delete(id);
    }
}
