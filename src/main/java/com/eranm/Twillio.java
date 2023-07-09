package com.eranm;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/twillio")
@Produces(MediaType.TEXT_PLAIN)
public class Twillio {
    @GET
    @Path("/")
    public String index() {
        return "In production, you'll be able to see this only vis port 9090";
    }
}
