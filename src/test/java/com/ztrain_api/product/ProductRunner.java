package com.ztrain_api.product;

import com.intuit.karate.junit5.Karate;

public class ProductRunner {

    @Karate.Test
    Karate testProduct() {
        return Karate.run().relativeTo(getClass());
    }
}
