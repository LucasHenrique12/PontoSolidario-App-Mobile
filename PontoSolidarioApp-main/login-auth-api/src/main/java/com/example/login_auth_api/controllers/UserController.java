package com.example.login_auth_api.controllers;

import com.example.login_auth_api.domain.User;
import com.example.login_auth_api.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private  UserRepository userRepo;

    public ResponseEntity<String> getUser(){
        return ResponseEntity.ok("sucesso");
    }




    private User getCurrentUser() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();

        if (email != null && !email.equals("anonymousUser")) {
            Optional<User> optionalUsers = userRepo.findByEmail(email);
            return optionalUsers.orElse(null);
        }

        return null;
    }
}
