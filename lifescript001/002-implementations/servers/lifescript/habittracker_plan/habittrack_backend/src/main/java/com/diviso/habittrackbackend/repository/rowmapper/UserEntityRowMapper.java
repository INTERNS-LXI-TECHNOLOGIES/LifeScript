package com.diviso.habittrackbackend.repository.rowmapper;

import com.diviso.habittrackbackend.domain.UserEntity;
import io.r2dbc.spi.Row;
import java.util.function.BiFunction;
import org.springframework.stereotype.Service;

/**
 * Converter between {@link Row} to {@link UserEntity}, with proper type conversions.
 */
@Service
public class UserEntityRowMapper implements BiFunction<Row, String, UserEntity> {

    private final ColumnConverter converter;

    public UserEntityRowMapper(ColumnConverter converter) {
        this.converter = converter;
    }

    /**
     * Take a {@link Row} and a column prefix, and extract all the fields.
     * @return the {@link UserEntity} stored in the database.
     */
    @Override
    public UserEntity apply(Row row, String prefix) {
        UserEntity entity = new UserEntity();
        entity.setId(converter.fromRow(row, prefix + "_id", Long.class));
        entity.setUserId(converter.fromRow(row, prefix + "_user_id", Integer.class));
        entity.setUserName(converter.fromRow(row, prefix + "_user_name", String.class));
        return entity;
    }
}
