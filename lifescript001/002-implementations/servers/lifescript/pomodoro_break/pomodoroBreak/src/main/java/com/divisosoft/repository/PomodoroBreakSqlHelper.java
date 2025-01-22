package com.divisosoft.repository;

import java.util.ArrayList;
import java.util.List;
import org.springframework.data.relational.core.sql.Column;
import org.springframework.data.relational.core.sql.Expression;
import org.springframework.data.relational.core.sql.Table;

public class PomodoroBreakSqlHelper {

    public static List<Expression> getColumns(Table table, String columnPrefix) {
        List<Expression> columns = new ArrayList<>();
        columns.add(Column.aliased("id", table, columnPrefix + "_id"));
        columns.add(Column.aliased("user_name", table, columnPrefix + "_user_name"));
        columns.add(Column.aliased("total_working_hour", table, columnPrefix + "_total_working_hour"));
        columns.add(Column.aliased("daily_duration_of_work", table, columnPrefix + "_daily_duration_of_work"));
        columns.add(Column.aliased("split_break_duration", table, columnPrefix + "_split_break_duration"));
        columns.add(Column.aliased("break_duration", table, columnPrefix + "_break_duration"));
        columns.add(Column.aliased("completed_breaks", table, columnPrefix + "_completed_breaks"));
        columns.add(Column.aliased("date_of_pomodoro", table, columnPrefix + "_date_of_pomodoro"));
        columns.add(Column.aliased("time_of_pomodoro_creation", table, columnPrefix + "_time_of_pomodoro_creation"));
        columns.add(Column.aliased("notification_for_break", table, columnPrefix + "_notification_for_break"));
        columns.add(Column.aliased("final_message", table, columnPrefix + "_final_message"));

        return columns;
    }
}
