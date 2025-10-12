package com.edernilson.aws;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

/**
 * @author : eder.nilson
 * @since : 12/10/2025, domingo
 */
public class HelloWorldRequestHandler implements RequestHandler<String,String> {

    @Override
    public String handleRequest(String s, Context context) {
        return "Meu primeiro request handler: " + s;
    }
}