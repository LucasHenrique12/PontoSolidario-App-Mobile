package com.example.login_auth_api.repositories;

import com.example.login_auth_api.domain.DonationPlaceDonationType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface DonationPlaceDonationTypeRepository extends JpaRepository<DonationPlaceDonationType,String> {
    List<DonationPlaceDonationType> findAllByDonationPlaceId(String donationPlaceId);
}

