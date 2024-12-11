package com.example.stable_diffusion;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1")
public class StableDiffusionController {

    @Autowired
    private StableDiffusionService service;

    @PostMapping("/generate-image")
    public ResponseEntity<byte[]> generateImage(@RequestBody Map<String, String> request) {
        String prompt = request.get("prompt");
        byte[] image = service.generateImage(prompt);

        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_PNG)
                .body(image);
    }
}
