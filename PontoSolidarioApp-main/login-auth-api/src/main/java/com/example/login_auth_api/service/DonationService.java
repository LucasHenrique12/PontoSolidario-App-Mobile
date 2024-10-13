package com.example.login_auth_api.service;

import com.example.login_auth_api.domain.Donation;
import com.example.login_auth_api.domain.User;
import com.example.login_auth_api.repositories.DonationRepository;
import com.example.login_auth_api.repositories.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DonationService {

    @Autowired
    private DonationRepository donationRepository;

    @Autowired
    private UserRepository userRepository;


    @Transactional
    public void registerDonation(Donation donation, User currentUser) {
        if (currentUser == null) {
            throw new RuntimeException("Usuário não autenticado");
        }


        String email = currentUser.getEmail();

        donation.setUserId(currentUser.getId());
        donation.setDataHora(LocalDateTime.now());

        donationRepository.save(donation);
    }

    public List<Donation> findDonationsByUserId(String userId) {
        return donationRepository.findByUserId(userId);
    }


//
//    public Optional<Donation> findDonationById(String id) {
//        return donationRepository.findById(id);
//    }
//
//    public void deleteDonationById(String id) {
//        donationRepository.deleteById(id);
//    }
//}
    }
