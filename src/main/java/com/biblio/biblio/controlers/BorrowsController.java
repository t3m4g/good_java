package com.biblio.biblio.controlers;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.Date;


import com.biblio.biblio.models.Books;
import com.biblio.biblio.models.Borrows;
import com.biblio.biblio.models.Users;
import com.biblio.biblio.repositories.BorrowsRepository;
import com.biblio.biblio.repositories.BooksRepository;
import com.biblio.biblio.repositories.UsersRepository;

@Controller
public class BorrowsController {

    @Autowired
    private BorrowsRepository borrowsRepository;

    @Autowired
    private UsersRepository usersRepository;

    @Autowired
    private BooksRepository booksRepository;

    /**
     * Affiche la liste des emprunts.
     */
    @GetMapping("/emprunts")
    public String listBorrows(Model model) {
        List<Borrows> borrows = borrowsRepository.findAllByOrderByIdDesc();
        List<Users> users = usersRepository.findAll();
        List<Books> books = booksRepository.findAll();

        model.addAttribute("borrows", borrows);
        model.addAttribute("users", users);
        model.addAttribute("books", books);

        // Ajouter la date d'aujourd'hui
        Date today = new Date();
        model.addAttribute("today", today);
        return "emprunts";
    }

    /**
     * Traite l'ajout d'un nouvel emprunt.
     */
    @PostMapping("/emprunts/add")
    public String addBorrow(@RequestParam("user_id") Integer userId,
                            @RequestParam("book_id") Integer bookId,
                            @RequestParam("dateEmprunt") LocalDate dateEmprunt,
                            @RequestParam("dateRetour") LocalDate dateRetour,
                            RedirectAttributes redirectAttributes) {

        // Vérification que les IDs de l'utilisateur et du livre sont fournis
        if (userId == null || bookId == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Utilisateur ou livre introuvable.");
            return "redirect:/emprunts";
        }

        Optional<Users> userOpt = usersRepository.findById(userId);
        Optional<Books> bookOpt = booksRepository.findById(bookId);

        if (userOpt.isPresent() && bookOpt.isPresent()) {
            Users user = userOpt.get();
            Books book = bookOpt.get();

            // Mise à jour de la disponibilité du livre
            book.setDisponibility(false);
            booksRepository.save(book);

            // Création de l'objet Borrows
            Borrows borrow = new Borrows();
            borrow.setUser(user);
            borrow.setBook(book);
            borrow.setDateEmprunt(dateEmprunt);
            borrow.setDateRetour(dateRetour);
            borrow.setStatut(true);

            borrowsRepository.save(borrow);
            redirectAttributes.addFlashAttribute("successMessage", "Emprunt ajouté avec succès !");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Utilisateur ou livre introuvable.");
        }
        return "redirect:/emprunts";
    }    
    
    /**
     * Traite la modification d'un emprunt existant.
     */
    @PostMapping("/emprunts/change/{id}")
    public String editBorrow(@PathVariable Integer id,
                            // @RequestParam("user_id") Integer userId,
                            // @RequestParam("book_id") Integer bookId,
                            // @RequestParam("dateEmprunt") String dateEmprunt,
                            @RequestParam("dateRetour") String dateRetour,
                            @RequestParam("statut") Boolean statut,
                            RedirectAttributes redirectAttributes) {

        // Vérification que l'emprunt existe
        Optional<Borrows> optionalBorrow = borrowsRepository.findById(id);
        if (!optionalBorrow.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Emprunt introuvable.");
            return "redirect:/emprunts";
        }

        Borrows existingBorrow = optionalBorrow.get();

        // Vérification que l'utilisateur et le livre existent
        Optional<Users> userOpt = usersRepository.findById(existingBorrow.getUser().getId());
        Optional<Books> bookOpt = booksRepository.findById(existingBorrow.getBook().getId());

        if (userOpt.isPresent() && bookOpt.isPresent()) {
            Users user = userOpt.get();
            Books book = bookOpt.get();

            // Mise à jour des informations de l'emprunt
            // existingBorrow.setUser(user);
            // existingBorrow.setBook(book);
            // existingBorrow.setDateEmprunt(existingBorrow.getDateEmprunt());
            existingBorrow.setDateRetour(LocalDate.parse(dateRetour));
            existingBorrow.setStatut(statut);

            // Mise à jour de la disponibilité du livre
            if (statut == false) {
                book.setDisponibility(true);
            } else {
                book.setDisponibility(false);
            }

            // Sauvegarde des modifications
            booksRepository.save(book);
            borrowsRepository.save(existingBorrow);

            redirectAttributes.addFlashAttribute("successMessage", "Emprunt modifié avec succès !");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Utilisateur ou livre introuvable.");
        }

        return "redirect:/emprunts";
    }

    /**
     * Supprime un emprunt existant.
     */
    @GetMapping("/emprunts/delete/{id}")
    public String deleteBorrow(@PathVariable Integer id) {
        Optional<Borrows> optionalBorrow = borrowsRepository.findById(id);
        optionalBorrow.ifPresent(borrowsRepository::delete);
        return "redirect:/emprunts";
    }

}
