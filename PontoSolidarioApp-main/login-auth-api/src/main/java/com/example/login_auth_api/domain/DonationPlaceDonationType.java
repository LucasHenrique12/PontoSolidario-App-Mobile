package com.example.login_auth_api.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name ="DonationPlaceDonationType")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DonationPlaceDonationType {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    private String donationPlaceId;
    private String donationTypeId;
}
