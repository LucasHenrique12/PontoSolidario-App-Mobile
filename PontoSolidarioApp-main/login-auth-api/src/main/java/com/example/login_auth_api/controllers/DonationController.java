package com.example.login_auth_api.controllers;


import com.example.login_auth_api.domain.Donation;
import com.example.login_auth_api.domain.User;
import com.example.login_auth_api.service.DonationService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
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



    @PostMapping("/createDonations")
    public ResponseEntity<?> createDonation(@RequestBody Donation donation) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();


        if (authentication != null && authentication.isAuthenticated() && !(authentication.getPrincipal() instanceof String)) {

            User currentUser = (User) authentication.getPrincipal();
            donationService.registerDonation(donation, currentUser);

            return ResponseEntity.status(HttpStatus.CREATED).body("Doação registrada com sucesso!");
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Usuário não autenticado");
    }


    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Donation>> getDonationsByUserId(@PathVariable String userId) {
        List<Donation> donations = donationService.findDonationsByUserId(userId);
        return ResponseEntity.ok(donations);
    }
}






