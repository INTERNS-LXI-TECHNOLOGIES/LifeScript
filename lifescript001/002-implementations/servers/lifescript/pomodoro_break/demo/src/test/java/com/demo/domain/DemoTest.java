package com.demo.domain;

import static com.demo.domain.DemoTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.demo.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class DemoTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Demo.class);
        Demo demo1 = getDemoSample1();
        Demo demo2 = new Demo();
        assertThat(demo1).isNotEqualTo(demo2);

        demo2.setId(demo1.getId());
        assertThat(demo1).isEqualTo(demo2);

        demo2 = getDemoSample2();
        assertThat(demo1).isNotEqualTo(demo2);
    }
}
