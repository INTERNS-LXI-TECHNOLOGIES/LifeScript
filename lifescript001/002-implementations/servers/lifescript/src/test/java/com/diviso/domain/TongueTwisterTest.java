package com.diviso.domain;

import static com.diviso.domain.TongueTwisterTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.diviso.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class TongueTwisterTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TongueTwister.class);
        TongueTwister tongueTwister1 = getTongueTwisterSample1();
        TongueTwister tongueTwister2 = new TongueTwister();
        assertThat(tongueTwister1).isNotEqualTo(tongueTwister2);

        tongueTwister2.setId(tongueTwister1.getId());
        assertThat(tongueTwister1).isEqualTo(tongueTwister2);

        tongueTwister2 = getTongueTwisterSample2();
        assertThat(tongueTwister1).isNotEqualTo(tongueTwister2);
    }
}
