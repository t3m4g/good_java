package com.biblio.biblio.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.biblio.biblio.models.Borrows;
import java.time.LocalDate;

import java.util.List;
import java.util.Optional;


public interface BorrowsRepository extends JpaRepository<Borrows, Integer> {

    /**
     * Récupère tous les emprunts triés par ID en ordre décroissant.
     */
    List<Borrows> findAllByOrderByIdDesc();

    /**
     * Recherche un emprunt par son ID.
     */
    Optional<Borrows> findById(Integer id);

    /**
     * Recherche des emprunts par l'ID de l'utilisateur.
     */
    List<Borrows> findByUserId(Integer userId);

    /**
     * Recherche des emprunts par l'ID du livre.
     */
    List<Borrows> findByBookId(Integer bookId);

    /**
     * Recherche des emprunts par statut (actif ou retourné).
     */
    List<Borrows> findByStatut(Boolean statut);

    /**
     * Recherche des emprunts par date d'emprunt.
     */
    List<Borrows> findByDateEmprunt(LocalDate dateEmprunt);

    /**
     * Recherche des emprunts par date de retour.
     */
    List<Borrows> findByDateRetour(LocalDate dateRetour);

    /**
     * Recherche des emprunts actifs (statut = true).
     */
    List<Borrows> findByStatutTrue();

    /**
     * Recherche des emprunts retournés (statut = false).
     */
    List<Borrows> findByStatutFalse();
}