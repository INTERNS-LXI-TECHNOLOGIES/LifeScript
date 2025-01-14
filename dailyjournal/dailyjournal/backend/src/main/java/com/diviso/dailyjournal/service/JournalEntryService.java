package com.diviso.dailyjournal.service;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.diviso.dailyjournal.entity.JournalEntry;
import com.diviso.dailyjournal.repo.JournalEntryRepository;

@Service
public class JournalEntryService {

    @Autowired
    private JournalEntryRepository journalEntryRepository;

    // Create a new journal entry
    public JournalEntry createJournalEntry(JournalEntry journalEntry) {
        return journalEntryRepository.save(journalEntry);
    }

    // Read all journal entries
    public List<JournalEntry> getAllJournalEntries() {
        return journalEntryRepository.findAll();
    }

    // Read a journal entry by ID
    public Optional<JournalEntry> getJournalEntryById(Long id) {
        return journalEntryRepository.findById(id);
    }

    // Update a journal entry
    public JournalEntry updateJournalEntry(Long id, JournalEntry journalEntryDetails) {
        Optional<JournalEntry> journalEntry = journalEntryRepository.findById(id);

        if (journalEntry.isPresent()) {
            JournalEntry existingJournalEntry = journalEntry.get();
            existingJournalEntry.setTitle(journalEntryDetails.getTitle());
            existingJournalEntry.setContent(journalEntryDetails.getContent());
            existingJournalEntry.setDate(journalEntryDetails.getDate());
            return journalEntryRepository.save(existingJournalEntry);
        }
        return null; // You may throw a custom exception if entry not found
    }

    // Delete a journal entry
    public void deleteJournalEntry(Long id) {
        journalEntryRepository.deleteById(id);
    }
}
