package com.diviso.habittrackbackend.repository.rowmapper;

import com.diviso.habittrackbackend.domain.HabitTracker;
import io.r2dbc.spi.Row;
import java.util.function.BiFunction;
import org.springframework.stereotype.Service;

/**
 * Converter between {@link Row} to {@link HabitTracker}, with proper type conversions.
 */
@Service
public class HabitTrackerRowMapper implements BiFunction<Row, String, HabitTracker> {

    private final ColumnConverter converter;

    public HabitTrackerRowMapper(ColumnConverter converter) {
        this.converter = converter;
    }

    /**
     * Take a {@link Row} and a column prefix, and extract all the fields.
     * @return the {@link HabitTracker} stored in the database.
     */
    @Override
    public HabitTracker apply(Row row, String prefix) {
        HabitTracker entity = new HabitTracker();
        entity.setId(converter.fromRow(row, prefix + "_id", Long.class));
        entity.setHabitId(converter.fromRow(row, prefix + "_habit_id", Integer.class));
        entity.setHabitName(converter.fromRow(row, prefix + "_habit_name", String.class));
        entity.setDescription(converter.fromRow(row, prefix + "_description", String.class));
        entity.setStartDate(converter.fromRow(row, prefix + "_start_date", Integer.class));
        entity.setEndDate(converter.fromRow(row, prefix + "_end_date", String.class));
        return entity;
    }
}
