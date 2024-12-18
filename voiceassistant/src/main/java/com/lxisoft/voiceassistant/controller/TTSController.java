package com.lxisoft.voiceassistant.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/tts")
public class TTSController {

    private static final String AUDIO_FILE_PATH = "E:\\LXI\\flutter_projects\\voice_assistant\\voice\\output.mp3";

    @PostMapping("/synthesize")
    public ResponseEntity<byte[]> synthesizeText(@RequestParam String text) {
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_TYPE, "audio/mpeg");
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"output.mp3\"");

        try {
            // Load the audio file from the local path
            File audioFile = new File(AUDIO_FILE_PATH);
            if (!audioFile.exists()) {
                return new ResponseEntity<>(null, headers, HttpStatus.NOT_FOUND);
            }

            byte[] audioBytes = Files.readAllBytes(audioFile.toPath());

            // Return the audio as a response
            return new ResponseEntity<>(audioBytes, headers, HttpStatus.OK);

        } catch (IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
