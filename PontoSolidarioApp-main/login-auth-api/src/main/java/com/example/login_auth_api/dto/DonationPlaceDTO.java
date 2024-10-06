package com.example.login_auth_api.dto;

import com.example.login_auth_api.domain.DonationType;

import java.util.List;

public record DonationPlaceDTO (String name, String latitude, String longitude, String address, List<DonationType> listTypes){
}
