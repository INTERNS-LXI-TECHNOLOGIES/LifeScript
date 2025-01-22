package com.demo.repository.rowmapper;

import com.demo.domain.Demo;
import io.r2dbc.spi.Row;
import java.util.function.BiFunction;
import org.springframework.stereotype.Service;

/**
 * Converter between {@link Row} to {@link Demo}, with proper type conversions.
 */
@Service
public class DemoRowMapper implements BiFunction<Row, String, Demo> {

    private final ColumnConverter converter;

    public DemoRowMapper(ColumnConverter converter) {
        this.converter = converter;
    }

    /**
     * Take a {@link Row} and a column prefix, and extract all the fields.
     * @return the {@link Demo} stored in the database.
     */
    @Override
    public Demo apply(Row row, String prefix) {
        Demo entity = new Demo();
        entity.setId(converter.fromRow(row, prefix + "_id", Long.class));
        entity.setUsername(converter.fromRow(row, prefix + "_username", String.class));
        entity.setMobileNumber(converter.fromRow(row, prefix + "_mobile_number", Integer.class));
        return entity;
    }
}
