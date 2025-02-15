package com.biblio.biblio.models;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class Books {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    public Integer getId() {
        return id;
    }

    private String title;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    private String author;

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    private String genre;

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    private Integer anneeDePublication;

    public Integer getAnneeDePublication() {
        return anneeDePublication;
    }

    public void setAnneeDePublication(Integer anneeDePublication) {
        this.anneeDePublication = anneeDePublication;
    }

    private Boolean disponibility;

    public Boolean getDisponibility() {
        return disponibility;
    }

    public void setDisponibility(Boolean disponibility) {
        this.disponibility = disponibility;
    }

    // relation avec la table Emprunts
    @OneToMany(mappedBy = "book")
    private List<Borrows> borrows;
}
