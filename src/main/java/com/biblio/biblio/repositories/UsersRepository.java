package com.biblio.biblio.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.biblio.biblio.models.Users;

public interface UsersRepository extends JpaRepository<Users, Integer> {

    List<Users> findAllByOrderByIdDesc();

    Optional<Users> findByEmail(String email);

}
