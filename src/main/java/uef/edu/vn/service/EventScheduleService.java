/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uef.edu.vn.model.EventSchedule;
import uef.edu.vn.repository.EventScheduleRepository;

@Service
public class EventScheduleService {

    @Autowired
    private EventScheduleRepository eventScheduleRepository;

    public List<EventSchedule> getAllSchedules() {
        return eventScheduleRepository.findAll();
    }

    public EventSchedule getScheduleById(int id) {
        return eventScheduleRepository.findById(id);
    }

    public void saveSchedule(EventSchedule schedule) {
        eventScheduleRepository.save(schedule);
    }

    public void updateSchedule(EventSchedule schedule) {
        eventScheduleRepository.update(schedule);
    }

    public void deleteSchedule(int id) {
        eventScheduleRepository.delete(id);
    }
}
