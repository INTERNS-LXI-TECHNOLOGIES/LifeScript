package com.diviso.dailyjournal.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.diviso.dailyjournal.entity.JournalEntry;
import com.diviso.dailyjournal.service.JournalEntryService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/journal")
public class JournalEntryController {

    @Autowired
    private JournalEntryService journalEntryService;

    // Create a new journal entry
    @PostMapping
    public ResponseEntity<JournalEntry> createJournalEntry(@RequestBody JournalEntry journalEntry) {
        JournalEntry savedEntry = journalEntryService.createJournalEntry(journalEntry);
        return ResponseEntity.status(201).body(savedEntry);
    }

    // Get all journal entries
    @GetMapping
    public List<JournalEntry> getAllJournalEntries() {
        return journalEntryService.getAllJournalEntries();
    }

    // Get a journal entry by ID
    @GetMapping("/{id}")
    public ResponseEntity<JournalEntry> getJournalEntryById(@PathVariable Long id) {
        Optional<JournalEntry> journalEntry = journalEntryService.getJournalEntryById(id);
        return journalEntry.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Update a journal entry by ID
    @PutMapping("/{id}")
    public ResponseEntity<JournalEntry> updateJournalEntry(@PathVariable Long id,
            @RequestBody JournalEntry journalEntryDetails) {
        JournalEntry updatedJournalEntry = journalEntryService.updateJournalEntry(id, journalEntryDetails);
        return updatedJournalEntry != null ? ResponseEntity.ok(updatedJournalEntry) : ResponseEntity.notFound().build();
    }

    // Delete a journal entry by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteJournalEntry(@PathVariable Long id) {
        journalEntryService.deleteJournalEntry(id);
        return ResponseEntity.noContent().build();
    }
}
