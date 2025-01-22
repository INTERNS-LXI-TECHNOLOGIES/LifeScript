package com.divisosoft.repository.rowmapper;

import com.divisosoft.domain.PomodoroBreak;
import io.r2dbc.spi.Row;
import java.time.Instant;
import java.util.function.BiFunction;
import org.springframework.stereotype.Service;

/**
 * Converter between {@link Row} to {@link PomodoroBreak}, with proper type conversions.
 */
@Service
public class PomodoroBreakRowMapper implements BiFunction<Row, String, PomodoroBreak> {

    private final ColumnConverter converter;

    public PomodoroBreakRowMapper(ColumnConverter converter) {
        this.converter = converter;
    }

    /**
     * Take a {@link Row} and a column prefix, and extract all the fields.
     * @return the {@link PomodoroBreak} stored in the database.
     */
    @Override
    public PomodoroBreak apply(Row row, String prefix) {
        PomodoroBreak entity = new PomodoroBreak();
        entity.setId(converter.fromRow(row, prefix + "_id", Long.class));
        entity.setTotalWorkingHour(converter.fromRow(row, prefix + "_total_working_hour", Integer.class));
        entity.setDailyDurationOfWork(converter.fromRow(row, prefix + "_daily_duration_of_work", Integer.class));
        entity.setSplitBreakDuration(converter.fromRow(row, prefix + "_split_break_duration", Integer.class));
        entity.setBreakDuration(converter.fromRow(row, prefix + "_break_duration", Integer.class));
        entity.setCompletedBreaks(converter.fromRow(row, prefix + "_completed_breaks", Integer.class));
        entity.setDateOfPomodoro(converter.fromRow(row, prefix + "_date_of_pomodoro", Instant.class));
        entity.setTimeOfPomodoroCreation(converter.fromRow(row, prefix + "_time_of_pomodoro_creation", Instant.class));
        entity.setNotificationForBreak(converter.fromRow(row, prefix + "_notification_for_break", Boolean.class));
        entity.setFinalMessage(converter.fromRow(row, prefix + "_final_message", String.class));
        return entity;
    }
}
