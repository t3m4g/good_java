package com.biblio.biblio.repositories;

import java.util.List;
// import java.util.Optional;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.biblio.biblio.models.Books;


public interface BooksRepository extends JpaRepository<Books, Integer> {

    List<Books> findAllByOrderByIdDesc();

    Optional<Books> findByTitle(String title);
}
