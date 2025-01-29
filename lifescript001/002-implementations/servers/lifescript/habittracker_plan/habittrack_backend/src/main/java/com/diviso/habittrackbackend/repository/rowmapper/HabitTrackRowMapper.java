package com.diviso.habittrackbackend.repository.rowmapper;

import com.diviso.habittrackbackend.domain.HabitTrack;
import io.r2dbc.spi.Row;
import java.util.function.BiFunction;
import org.springframework.stereotype.Service;

/**
 * Converter between {@link Row} to {@link HabitTrack}, with proper type conversions.
 */
@Service
public class HabitTrackRowMapper implements BiFunction<Row, String, HabitTrack> {

    private final ColumnConverter converter;

    public HabitTrackRowMapper(ColumnConverter converter) {
        this.converter = converter;
    }

    /**
     * Take a {@link Row} and a column prefix, and extract all the fields.
     * @return the {@link HabitTrack} stored in the database.
     */
    @Override
    public HabitTrack apply(Row row, String prefix) {
        HabitTrack entity = new HabitTrack();
        entity.setId(converter.fromRow(row, prefix + "_id", Long.class));
        entity.setHabitId(converter.fromRow(row, prefix + "_habit_id", Integer.class));
        entity.setHabitName(converter.fromRow(row, prefix + "_habit_name", String.class));
        entity.setDescription(converter.fromRow(row, prefix + "_description", String.class));
        entity.setCategory(converter.fromRow(row, prefix + "_category", String.class));
        entity.setStartDate(converter.fromRow(row, prefix + "_start_date", String.class));
        entity.setEndDate(converter.fromRow(row, prefix + "_end_date", String.class));
        return entity;
    }
}
