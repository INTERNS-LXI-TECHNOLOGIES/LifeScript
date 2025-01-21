package com.divisosoft.domain;

import static com.divisosoft.domain.PomodoroBreakTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.divisosoft.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class PomodoroBreakTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(PomodoroBreak.class);
        PomodoroBreak pomodoroBreak1 = getPomodoroBreakSample1();
        PomodoroBreak pomodoroBreak2 = new PomodoroBreak();
        assertThat(pomodoroBreak1).isNotEqualTo(pomodoroBreak2);

        pomodoroBreak2.setId(pomodoroBreak1.getId());
        assertThat(pomodoroBreak1).isEqualTo(pomodoroBreak2);

        pomodoroBreak2 = getPomodoroBreakSample2();
        assertThat(pomodoroBreak1).isNotEqualTo(pomodoroBreak2);
    }
}
