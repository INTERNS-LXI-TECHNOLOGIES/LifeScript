package com.diviso.dailyjournal.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.diviso.dailyjournal.entity.JournalEntry;

public interface JournalEntryRepository extends JpaRepository<JournalEntry, Long> {
}
