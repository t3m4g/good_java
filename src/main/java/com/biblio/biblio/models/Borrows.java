package com.biblio.biblio.models;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Borrows {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    private LocalDate dateEmprunt;
    private LocalDate dateRetour;
    private Boolean statut;
    
    // Relation avec Users
    @ManyToOne
    @JoinColumn(name = "user_id")
    private Users user;
    
    // Relation avec Books
    @ManyToOne
    @JoinColumn(name = "book_id")
    private Books book;
    
    public Integer getId() {
        return id;
    }
    
    public LocalDate getDateEmprunt() {
        return dateEmprunt;
    }
    public void setDateEmprunt(LocalDate dateEmprunt) {
        this.dateEmprunt = dateEmprunt;
    }
    
    public LocalDate getDateRetour() {
        return dateRetour;
    }
    public void setDateRetour(LocalDate dateRetour) {
        this.dateRetour = dateRetour;
    }
    
    public Boolean getStatut() {
        return statut;
    }
    public void setStatut(Boolean statut) {
        this.statut = statut;
    }
    
    public Users getUser() {
        return user;
    }
    public void setUser(Users user) {
        this.user = user;
    }
    
    public Books getBook() {
        return book;
    }
    public void setBook(Books book) {
        this.book = book;
    }
    
}
