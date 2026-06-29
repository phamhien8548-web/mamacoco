/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uef.edu.vn.model.TicketType;
import uef.edu.vn.repository.TicketTypeRepository;

@Service
public class TicketTypeService {

    @Autowired
    private TicketTypeRepository ticketTypeRepository;

    public List<TicketType> getAllTicketTypes() {
        return ticketTypeRepository.findAll();
    }

    public TicketType getTicketTypeById(int id) {
        return ticketTypeRepository.findById(id);
    }

    public void saveTicketType(TicketType ticketType) {
        ticketTypeRepository.save(ticketType);
    }

    public void updateTicketType(TicketType ticketType) {
        ticketTypeRepository.update(ticketType);
    }

    public void deleteTicketType(int id) {
        ticketTypeRepository.delete(id);
    }
}
