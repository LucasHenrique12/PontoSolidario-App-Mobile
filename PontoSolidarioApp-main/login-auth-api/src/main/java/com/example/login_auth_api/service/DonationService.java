package com.example.login_auth_api.service;

import com.example.login_auth_api.domain.Donation;
import com.example.login_auth_api.domain.User;
import com.example.login_auth_api.repositories.DonationRepository;
import com.example.login_auth_api.repositories.UserRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
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

    public void registerDonation(Donation donation, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            throw new RuntimeException("Usuário não autenticado"); // Lança uma exceção se o usuário não estiver autenticado
        }

        String email = userDetails.getUsername(); // Obter o email do usuário
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        donation.setUserId(user.getId()); // Define o ID do usuário na doação
        donation.setDataHora(LocalDateTime.now()); // Define a data e hora da doação
        donation.setDonationPlaceId(donation.getDonationPlaceId()); // Define o ID do local de doação

        donationRepository.save(donation); // Salva a doação
    }

    public List<Donation> findAllDonations() {
        return donationRepository.findAll();
    }

    public Optional<Donation> findDonationById(String id) {
        return donationRepository.findById(id);
    }

    public void deleteDonationById(String id) {
        donationRepository.deleteById(id);
    }
}
