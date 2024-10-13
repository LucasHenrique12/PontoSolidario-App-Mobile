package com.example.login_auth_api.controllers;


import com.example.login_auth_api.domain.DonationPlace;
import com.example.login_auth_api.domain.DonationPlaceDonationType;
import com.example.login_auth_api.domain.DonationType;
import com.example.login_auth_api.dto.DonationPlaceDTO;
import com.example.login_auth_api.repositories.DonationPlaceDonationTypeRepository;
import com.example.login_auth_api.repositories.DonationPlaceRepository;
import com.example.login_auth_api.repositories.DonationTypeRepository;
import com.example.login_auth_api.service.DonationPlaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping(value = "/DonationPlace")
@RequiredArgsConstructor
public class DonationPlaceController {

@Autowired
private DonationPlaceRepository donationPlacerepository;
@Autowired
private DonationPlaceService donationPlaceService;
    @Autowired
    private DonationPlaceDonationTypeRepository donationPlaceDonationTypeRepository;
    @Autowired
    private DonationTypeRepository donationTypeRepository;

    @GetMapping
    public List<DonationPlaceDTO> findAll() {
        return donationPlaceService.findAllDonationPlaces();
    }



    @PostMapping("/registerDonationPlace")
    public ResponseEntity<?> registerDonationPlace(@RequestBody DonationPlaceDTO body){
            try {
                donationPlaceService.donationPlaceRegister(body);
                return (ResponseEntity<?>) ResponseEntity.ok("Sucesso");
            } catch (RuntimeException e) {
                System.out.println("Error");
                e.printStackTrace();
                return (ResponseEntity<DonationPlaceDTO>) ResponseEntity.badRequest();
            }
    }

    @GetMapping("/{id}")
    public ResponseEntity<DonationPlace> findById(@PathVariable String id) {
        return donationPlacerepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDonationPlace(@PathVariable String id) {
        if (donationPlacerepository.existsById(id)) {
            donationPlacerepository.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/filterType/{donationTypeId}")
    public List<DonationPlaceDTO> getDonationPlacesByType(@PathVariable String donationTypeId) {
        return donationPlaceService.findDonationPlacesByDonationType(donationTypeId);
    }

}
