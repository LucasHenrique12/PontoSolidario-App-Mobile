package com.example.login_auth_api.repositories;

import com.example.login_auth_api.domain.Donation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DonationRepository extends JpaRepository <Donation,String> {

    List<Donation> findByUserId(String userId);
}
