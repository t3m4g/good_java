package com.biblio.biblio.controlers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import com.biblio.biblio.models.Users;
import com.biblio.biblio.repositories.UsersRepository;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UsersController {

    @Autowired
    private UsersRepository usersRepository;

    @GetMapping("/utilisateurs")
    public String pageUsers(Model model) {
        List<Users> listedesUsers = usersRepository.findAllByOrderByIdDesc();
        model.addAttribute("utilisateur", listedesUsers);
        return "utilisateurs";
    }

    @PostMapping("/utilisateurs/add")
    public String addUsers(@ModelAttribute("utilisateuradd") Users users) {

        Optional<Users> optionalUser = usersRepository.findByEmail(users.getEmail());

        if (optionalUser.isPresent()) {

        } else {
            usersRepository.save(users);
        }
        return "redirect:/utilisateurs";
    }

    @PostMapping("/utilisateurs/change/{id}")
    public String changeUsers(@PathVariable Integer id, @ModelAttribute("changeutilisateur") Users users) {

        Optional<Users> optionalUser = usersRepository.findById(id);

        if (optionalUser.isPresent()) {
            Users user = optionalUser.get();

            user.setEmail(users.getEmail());
            user.setName(users.getName());
            user.setTelephone(users.getTelephone());

            usersRepository.save(user);
        } else {

        }
        return "redirect:/utilisateurs";
    }

    @GetMapping("/utilisateurs/delete/{id}")
    public String deleteUsers(@PathVariable Integer id) {

        Optional<Users> optionalUser = usersRepository.findById(id);

        if (optionalUser.isPresent()) {
            usersRepository.delete(optionalUser.get());
        } else {

        }
        return "redirect:/utilisateurs";
    }

}
