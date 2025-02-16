<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>BIBLIO | Utilisateur</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <!-- Bootstrap Icons -->
        <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
        rel="stylesheet"
        />
  </head>
  <body>
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container">
        <a class="navbar-brand fw-bold" href="#">Biblio</a>
        <button
          title="menu"
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link" href="/">Dashboard</a>
            </li>
            <li class="nav-item"><a class="nav-link" href="/livres">Livres</a></li>
            <li class="nav-item"><a class="nav-link" href="/emprunts">Emprunts</a></li>
            <li class="nav-item">
              <a class="nav-link active" href="/utilisateurs">Utilisateurs</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Contenu principal -->
    <div class="container mt-4" style="min-height: calc(100vh - 177px)">
        <div class="container mt-4">
                    <h2 class="mb-3 text-left">📚 Gestion des Utilisateurs</h2>

                    <!-- Conteneur pour aligner à droite -->
                    <div class="d-flex justify-content-end">
                        <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalAjouterLivre">
                            <i class="bi bi-plus-circle"></i> Ajouter Utilisateur
                        </button>
                    </div>


                    <!-- Modal d'ajout de utilisateur -->
                    <div class="modal fade" id="modalAjouterLivre" tabindex="-1" aria-labelledby="modalAjouterLivreLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalAjouterLivreLabel">Ajouter un nouveau Utilisateur</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="/utilisateurs/add" var="utilisateuradd" method="post">
                                        <!-- Nom -->
                                        <div class="mb-3">
                                            <label for="nom" class="form-label">Nom Complet</label>
                                            <input type="text" class="form-control" id="nom" name="name" required>
                                        </div>

                                        <!-- Email -->
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="email" class="form-control" id="email" name="email" required>
                                        </div>

                                        <!-- Téléphone -->
                                        <div class="mb-3">
                                            <label for="telephone" class="form-label">Téléphone</label>
                                            <input type="number" class="form-control" id="telephone" name="telephone" required>
                                        </div>
                                        <!-- Boutons -->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                            <button type="submit" class="btn btn-primary">Ajouter</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>


                
                    <!-- Tableau des utilisateurs -->
                    <div class="row border border-1 p-2 py-3 rounded-2">
                            <!-- code pour l'affichage d'un utilisateur -->
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th scope="col">N°</th>
                                        <th scope="col">Nom</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Téléphone</th>
                                        <th scope="col" class="text-center">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${utilisateur}" var="utilisateur" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${utilisateur.name}</td>
                                        <td>${utilisateur.email}</td>
                                        <td>${utilisateur.telephone}</td>
                                        <td class="text-center">
                                            <!-- Bouton Modifier -->
                                            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modalModifier${utilisateur.id}">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            
                                            <!-- Bouton Supprimer -->
                                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#modalSupprimer${utilisateur.id}">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                            
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        <c:forEach items="${utilisateur}" var="utilisateur">
                            <!-- Modale de modification de l'utilisateur -->
                            <div class="modal fade" id="modalModifier${utilisateur.id}" tabindex="-1" aria-labelledby="modalModifierLabel${utilisateur.id}" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="modalModifierLabel${utilisateur.id}">Modifier l'Utilisateur</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="/utilisateurs/change/${utilisateur.id}" var="changeutilisateur" method="post">
                                                <div class="mb-3">
                                                    <label for="nom${utilisateur.id}" class="form-label">Nom Complet</label>
                                                    <input type="text" class="form-control" id="nom${utilisateur.id}" name="name" value="${utilisateur.name}" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="email${utilisateur.id}" class="form-label">Email</label>
                                                    <input type="email" class="form-control" id="email${utilisateur.id}" name="email" value="${utilisateur.email}" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="telephone${utilisateur.id}" class="form-label">Téléphone</label>
                                                    <input type="number" class="form-control" id="telephone${utilisateur.id}" name="telephone" value="${utilisateur.telephone}" required>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                    <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- modal de confirmation de suppression de utilisateur -->
                            <div class="modal fade" id="modalSupprimer${utilisateur.id}" tabindex="-1" aria-labelledby="modalSupprimerLabel${utilisateur.id}" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="modalSupprimerLabel${utilisateur.id}">Confirmation de suppression</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Êtes-vous sûr de vouloir supprimer l'utilisateur <strong>${utilisateur.name} </strong> ?</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                            <a href="/utilisateurs/delete/${utilisateur.id}" class="btn btn-danger">Supprimer</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- fin du code pour l'affichage des utilisateurs-->
                        </c:forEach>
                    </div>
                </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-4">
      <p>&copy; 2025 Biblio. Tous droits réservés.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
