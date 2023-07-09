package com.eranm;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/api")
@Produces(MediaType.TEXT_PLAIN)
public class Api {
    @GET
    @Path("something")
    public String something() {
        return "The endpoint returns something";

    }

    @GET
    @Path("anything")
    public String anything() {
        return "The endpoint returns anything";

    }
}
