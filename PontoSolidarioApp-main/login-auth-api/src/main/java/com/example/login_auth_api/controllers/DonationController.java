package com.example.login_auth_api.controllers;


import com.example.login_auth_api.domain.Donation;
import com.example.login_auth_api.service.DonationService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value = "/donations")
@RequiredArgsConstructor

public class DonationController {
    @Autowired
    private DonationService donationService;

    // Endpoint para criar uma nova doação
    @PostMapping
    public ResponseEntity<Void> createDonation(@RequestBody Donation donation,
                               @AuthenticationPrincipal UserDetails userDetails) {
        // Chama o serviço para registrar a doação
        donationService.registerDonation(donation, userDetails);
        return ResponseEntity.ok().build();
    }

    // Endpoint para buscar todas as doações
    @GetMapping
    public ResponseEntity<List<Donation>> getAllDonations() {
        List<Donation> donations = donationService.findAllDonations();
        return ResponseEntity.ok(donations);
    }

    // Endpoint para buscar uma doação por ID
    @GetMapping("/{id}")
    public ResponseEntity<Donation> getDonationById(@PathVariable String id) {
        Optional<Donation> donation = donationService.findDonationById(id);
        return donation.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Endpoint para deletar uma doação por ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDonation(@PathVariable String id) {
        donationService.deleteDonationById(id);
        return ResponseEntity.noContent().build();
    }
}
