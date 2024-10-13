package com.example.login_auth_api.service;

import com.example.login_auth_api.domain.DonationPlace;
import com.example.login_auth_api.domain.DonationPlaceDonationType;
import com.example.login_auth_api.domain.DonationType;
import com.example.login_auth_api.dto.DonationPlaceDTO;
import com.example.login_auth_api.repositories.DonationPlaceDonationTypeRepository;
import com.example.login_auth_api.repositories.DonationPlaceRepository;
import com.example.login_auth_api.repositories.DonationTypeRepository;
import lombok.RequiredArgsConstructor;
import org.apache.catalina.Store;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor

public class DonationPlaceService {
    @Autowired
    private DonationPlaceRepository donationPlaceRepository;
    @Autowired
    private DonationPlaceDonationTypeRepository  donationPlaceDonationTypeRepository;
    @Autowired
    private DonationTypeRepository donationTypeRepository;

    public List<DonationPlaceDTO> findAllDonationPlaces(){
        List<DonationPlace> donationPlaceList = donationPlaceRepository.findAll();
        List<DonationPlaceDTO> donationPlaceDTOArrayList = new ArrayList<>();

        for(DonationPlace donation : donationPlaceList){
            List<DonationPlaceDonationType> donationTypeLocationList = donationPlaceDonationTypeRepository.findAllByDonationPlaceId(donation.getId());
            List<DonationType> donationLocationType = new ArrayList<>();

            for (DonationPlaceDonationType donationTypePlace : donationTypeLocationList) {
                DonationType donationType = donationTypeRepository.findById(donationTypePlace.getDonationTypeId()).orElse(null);
                if (donationType != null) {
                    donationLocationType.add(donationType);
                }
            }
            donationPlaceDTOArrayList.add(new DonationPlaceDTO(donation.getName(), donation.getLatitude(), donation.getLongitude(), donation.getAddress(), donationLocationType));
        }
        return donationPlaceDTOArrayList;
    }


    public void donationPlaceRegister(DonationPlaceDTO body) {

        DonationPlace donationPlace = new DonationPlace();
        donationPlace.setName(body.name());
        donationPlace.setLatitude(body.latitude());
        donationPlace.setLongitude(body.longitude());
        donationPlace.setAddress(body.address());


        if (donationPlaceRepository.existsByNameAndLatitudeAndLongitude(
                donationPlace.getName(),
                donationPlace.getLatitude(),
                donationPlace.getLongitude())) {
            throw new RuntimeException("Donation Place already exists");
        } else {

            donationPlaceRepository.save(donationPlace);


            for (DonationType donationType : body.listTypes()) {

                DonationPlaceDonationType donationPlaceDonationType = new DonationPlaceDonationType();
                donationPlaceDonationType.setDonationPlaceId(donationPlace.getId());
                donationPlaceDonationType.setDonationTypeId(donationType.getId());


                donationPlaceDonationTypeRepository.save(donationPlaceDonationType);
            }
        }
    }

    public List<DonationPlaceDTO> findDonationPlacesByDonationType(String donationTypeId) {
        List<DonationPlace> donationPlaceList = donationPlaceRepository.findAll();
        List<DonationPlaceDTO> donationPlaceDTOArrayList = new ArrayList<>();

        for (DonationPlace donation : donationPlaceList) {
            List<DonationPlaceDonationType> donationTypeLocationList = donationPlaceDonationTypeRepository.findAllByDonationPlaceId(donation.getId());
            List<DonationType> donationLocationType = new ArrayList<>();

            for (DonationPlaceDonationType donationTypePlace : donationTypeLocationList) {
                DonationType donationType = donationTypeRepository.findById(donationTypePlace.getDonationTypeId()).orElse(null);
                if (donationType != null) {
                    donationLocationType.add(donationType);
                }
            }


            if (donationLocationType.stream().anyMatch(type -> type.getId().equals(donationTypeId))) {
                donationPlaceDTOArrayList.add(new DonationPlaceDTO(donation.getName(), donation.getLatitude(), donation.getLongitude(), donation.getAddress(), donationLocationType));
            }
        }
        return donationPlaceDTOArrayList;
    }

}




