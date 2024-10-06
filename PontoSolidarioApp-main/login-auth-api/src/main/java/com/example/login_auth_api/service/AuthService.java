package com.example.login_auth_api.service;

import com.example.login_auth_api.domain.User;
import com.example.login_auth_api.dto.LoginRequestDTO;
import com.example.login_auth_api.dto.RegisterRequestDTO;
import com.example.login_auth_api.dto.ResponseDTO;
import com.example.login_auth_api.infra.security.TokenService;
import com.example.login_auth_api.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
@RequiredArgsConstructor
public class AuthService {
        @Autowired
        private final UserRepository repository;
        private final PasswordEncoder passwordEncoder;
        private final TokenService tokenService;

        public ResponseDTO login(LoginRequestDTO body) {
            User user = repository.findByEmail(body.email())
                    .orElseThrow(() -> new RuntimeException("User not found"));

            if (passwordEncoder.matches(body.password(), user.getPassword())) {
                String token = tokenService.generateToken(user);
                return new ResponseDTO(user.getName(), token);
            }

            throw new RuntimeException("Invalid credentials");
        }

        public ResponseDTO register(RegisterRequestDTO body) {
            Optional<User> existingUser = repository.findByEmail(body.email());

            if (existingUser.isEmpty()) {
                User newUser = new User();
                newUser.setPassword(passwordEncoder.encode(body.password()));
                newUser.setEmail(body.email());
                newUser.setName(body.name());
                newUser.setGen(body.gen());

                repository.save(newUser);

                String token = tokenService.generateToken(newUser);
                return new ResponseDTO(newUser.getName(), token);
            }

            throw new RuntimeException("User already exists");
        }

}
