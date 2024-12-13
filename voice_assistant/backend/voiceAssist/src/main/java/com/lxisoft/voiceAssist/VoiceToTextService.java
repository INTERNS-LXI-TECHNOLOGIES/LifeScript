// VoiceToTextService.java
package com.lxisoft.voiceAssist;

import java.io.File;
import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class VoiceToTextService {

    @Value("${huggingface.api.key}")
    private String apiKey;

    private static final String API_URL = "https://api-inference.huggingface.co/models/NexaAIDev/Qwen2-Audio-7B-GGUF";

    public String convertVoiceToText(File audioFile) throws IOException {
        // Create HTTP client
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost(API_URL);

            // Set API key in header
            httpPost.setHeader("Authorization", "Bearer " + apiKey);

            // Build multipart request
            HttpEntity entity = MultipartEntityBuilder.create()
                    .addBinaryBody("file", audioFile, ContentType.APPLICATION_OCTET_STREAM, audioFile.getName())
                    .build();

            httpPost.setEntity(entity);

            // Execute the request
            try (CloseableHttpResponse response = httpClient.execute(httpPost)) {
                int statusCode = response.getStatusLine().getStatusCode();
                if (statusCode == 200) {
                    // Parse response
                    return EntityUtils.toString(response.getEntity());
                } else {
                    throw new IOException("Failed to process audio. HTTP Status: " + statusCode);
                }
            }
        }
    }
}