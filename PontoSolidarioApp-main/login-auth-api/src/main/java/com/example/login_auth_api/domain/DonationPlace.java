package com.example.login_auth_api.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name ="donationPlace")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DonationPlace {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    private String name;
    private String latitude;
    private String longitude;
    private String address;



}
