package com.ztrain_api.user;

import com.intuit.karate.junit5.Karate;

public class UserRunner {
    @Karate.Test
    Karate testUser() {
        return Karate.run().relativeTo(getClass());
    }
}
