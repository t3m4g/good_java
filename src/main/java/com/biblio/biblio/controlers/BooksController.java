package com.biblio.biblio.controlers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import com.biblio.biblio.models.Books;
import com.biblio.biblio.repositories.BooksRepository;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class BooksController {

    @Autowired
    private BooksRepository booksRepository;

    @GetMapping("/livres")
    public String pageBooks(Model model) {
        List<Books> listedesBooks = booksRepository.findAllByOrderByIdDesc();
        model.addAttribute("livre", listedesBooks);
        return "livres";
    }

    @PostMapping("/livres/add")
    public String addBooks(@ModelAttribute("livreadd") Books books) {

        // Optional<Books> optionalBook = booksRepository.findByTitle(Books.getTitle());

        // if (optionalBook.isPresent()) {

        // } else {
            booksRepository.save(books);
        // }
        return "redirect:/livres";
    }

    @PostMapping("/livres/change/{id}")
    public String changeBooks(@PathVariable Integer id, @ModelAttribute("changelivre") Books books) {

        Optional<Books> optionalBook = booksRepository.findById(id);

        if (optionalBook.isPresent()) {
            Books book = optionalBook.get();

            book.setDisponibility(books.getDisponibility());
            book.setAnneeDePublication(books.getAnneeDePublication());
            book.setAuthor(books.getAuthor());
            book.setGenre(books.getGenre());
            book.setTitle(books.getTitle());

            booksRepository.save(book);
        } else {

        }
        return "redirect:/livres";
    }

    @GetMapping("/livres/delete/{id}")
    public String deleteBooks(@PathVariable Integer id) {

        Optional<Books> optionalBook = booksRepository.findById(id);

        if (optionalBook.isPresent()) {
            booksRepository.delete(optionalBook.get());
        } else {

        }
        return "redirect:/livres";
    }

}

