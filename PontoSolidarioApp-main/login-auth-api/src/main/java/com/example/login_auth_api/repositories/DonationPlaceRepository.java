package com.example.login_auth_api.repositories;

import com.example.login_auth_api.domain.DonationPlace;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface DonationPlaceRepository  extends JpaRepository<DonationPlace,String> {
    boolean existsByNameAndLatitudeAndLongitude(String name, String latitude, String longitude);
}
