package com.ztrain_api;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ZTrainAPITest {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }

//    @Test
//    void testParallel() {
//        Results results = Runner.path("classpath:com/ztrain_api")
//                .outputCucumberJson(true)
//                .parallel(5);
//        assertEquals(0, results.getFailCount(), results.getErrorMessages());
//    }
}
