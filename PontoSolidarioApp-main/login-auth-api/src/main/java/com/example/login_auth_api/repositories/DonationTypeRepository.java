package com.example.login_auth_api.repositories;

import com.example.login_auth_api.domain.DonationType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DonationTypeRepository extends JpaRepository<DonationType,String> {
}
