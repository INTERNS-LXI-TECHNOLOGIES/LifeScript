// VoiceToTextController.java
package com.lxisoft.voiceAssist;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/v1")
public class VoiceToTextController {

    @Autowired
    private VoiceToTextService service;


    @PostMapping("/voiceText")
    public ResponseEntity<?> convertVoiceToText(@RequestParam("file") MultipartFile file) {
        try {
            System.out.println("File name: " + file.getOriginalFilename());
            System.out.println("File size: " + file.getSize());
    
            File tempFile = File.createTempFile("upload-", file.getOriginalFilename());
            file.transferTo(tempFile);
    
            String result = service.convertVoiceToText(tempFile);
    
            tempFile.delete();
    
            return ResponseEntity.ok(result);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error processing the file: " + e.getMessage());
        }
    }
    
}
