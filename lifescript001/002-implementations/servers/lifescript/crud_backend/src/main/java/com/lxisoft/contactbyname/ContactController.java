package com.lxisoft.contactbyname;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/contacts")
public class ContactController {
    @Autowired
    private ContactService contactService;

    @PostMapping
    public ResponseEntity<Contact> createContact(@RequestBody Contact contact) {
        Contact savedContact = contactService.saveContact(contact);
        return new ResponseEntity<>(savedContact, HttpStatus.CREATED);
    }

    @GetMapping("/{name}")
    public ResponseEntity<Contact> getContactByName(@PathVariable String name) {
        Optional<Contact> contact = contactService.getContactByName(name);
        return contact.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping
    public List<Contact> getAllContacts() {
        return contactService.getAllContacts();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteContact(@PathVariable Long id) {
        contactService.deleteContact(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Contact> updateContact(@PathVariable Long id, @RequestBody Contact contactDetails) {
        Optional<Contact> contactOptional = contactService.getContactByName(contactDetails.getName());
        if (contactOptional.isPresent()) {
            Contact contactToUpdate = contactOptional.get();
            contactToUpdate.setEmail(contactDetails.getEmail());
            contactToUpdate.setPhone(contactDetails.getPhone());
            Contact updatedContact = contactService.updateContact(contactToUpdate);
            return new ResponseEntity<>(updatedContact, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

