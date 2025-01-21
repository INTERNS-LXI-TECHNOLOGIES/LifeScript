package com.diviso.dailyjournal.repository.rowmapper;

import com.diviso.dailyjournal.domain.DailyJournal;
import io.r2dbc.spi.Row;
import java.time.LocalDate;
import java.util.function.BiFunction;
import org.springframework.stereotype.Service;

/**
 * Converter between {@link Row} to {@link DailyJournal}, with proper type conversions.
 */
@Service
public class DailyJournalRowMapper implements BiFunction<Row, String, DailyJournal> {

    private final ColumnConverter converter;

    public DailyJournalRowMapper(ColumnConverter converter) {
        this.converter = converter;
    }

    /**
     * Take a {@link Row} and a column prefix, and extract all the fields.
     * @return the {@link DailyJournal} stored in the database.
     */
    @Override
    public DailyJournal apply(Row row, String prefix) {
        DailyJournal entity = new DailyJournal();
        entity.setId(converter.fromRow(row, prefix + "_id", Long.class));
        entity.setTitle(converter.fromRow(row, prefix + "_title", String.class));
        entity.setContent(converter.fromRow(row, prefix + "_content", String.class));
        entity.setDate(converter.fromRow(row, prefix + "_date", LocalDate.class));
        return entity;
    }
}
