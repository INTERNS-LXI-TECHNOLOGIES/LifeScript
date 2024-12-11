package com.lxisoft.voiceAssist;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class VoiceToTextService {

    @Value("${huggingface.api.key}")
    private String apiKey;

    @Value("${huggingface.model.url}")
    private String modelUrl;

    public String processAudio(MultipartFile audioFile) throws IOException {
        CloseableHttpClient client = HttpClients.createDefault();

        HttpPost post = new HttpPost(modelUrl);
        post.setHeader("Authorization", "Bearer " + apiKey);

        // Build the multipart entity with the audio file
        HttpEntity entity = MultipartEntityBuilder.create()
                .addBinaryBody("file", audioFile.getInputStream(), org.apache.http.entity.ContentType.MULTIPART_FORM_DATA, audioFile.getOriginalFilename())
                .build();
        post.setEntity(entity);

        try (CloseableHttpResponse response = client.execute(post)) {
            int statusCode = response.getStatusLine().getStatusCode();
            if (statusCode != 200) {
                throw new RuntimeException("Failed to process audio: " + statusCode);
            }

            String responseBody = EntityUtils.toString(response.getEntity());
            return parseResponse(responseBody);
        }
    }

    private String parseResponse(String responseBody) {
        // Assuming HuggingFace API returns a JSON response with a 'text' field
        try {
            // Parse the JSON response and return the transcribed text
            org.json.JSONObject jsonResponse = new org.json.JSONObject(responseBody);
            return jsonResponse.getString("text");
        } catch (Exception e) {
            return "Error parsing response: " + e.getMessage();
        }
    }
}
