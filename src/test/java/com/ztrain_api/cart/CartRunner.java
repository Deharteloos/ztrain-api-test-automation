package com.ztrain_api.cart;

import com.intuit.karate.junit5.Karate;

public class CartRunner {

    @Karate.Test
    Karate testCart() {
        return Karate.run().relativeTo(getClass());
    }
}
