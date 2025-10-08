package com.edernilson.awssm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueRequest;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueResponse;

@SpringBootApplication
public class AwsSMApplication {

	public static void main(String[] args) {
        SpringApplication.run(AwsSMApplication.class, args);
	}

}

@RestController
@RequestMapping("/secretmanager")
class SecretManagerService {

    @GetMapping("/{secretName}")
    public ResponseEntity<String> getSecretValue(@PathVariable String secretName) {
        // repost/test/secret
        String secretNameId = "repost/test/" + secretName;
        Region region = Region.of("us-east-1");

        GetSecretValueResponse getSecretValueResponse;
        try (SecretsManagerClient client = SecretsManagerClient.builder()
                .region(region)
                .build()) {

            GetSecretValueRequest getSecretValueRequest = GetSecretValueRequest.builder()
                    .secretId(secretNameId)
                    .build();

            getSecretValueResponse = client.getSecretValue(getSecretValueRequest);
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving secret: " + e.getMessage());
        }

        return ResponseEntity.ok(getSecretValueResponse.secretString());
    }
}