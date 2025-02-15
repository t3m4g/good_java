<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>BIBLIO | Livres</title>
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
            <li class="nav-item"><a class="nav-link active" href="/livres">Livres</a></li>
            <li class="nav-item"><a class="nav-link" href="/emprunts">Emprunts</a></li>
            <li class="nav-item">
              <a class="nav-link" href="/utilisateurs">Utilisateurs</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Contenu principal -->
    <div class="container mt-4" style="min-height: calc(100vh - 177px)">
        <div class="container mt-4">
            <h2 class="mb-3 text-left">📚 Gestion des Livres</h2>

            <!-- Conteneur pour aligner à droite -->
            <div class="d-flex justify-content-end">
                <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalAjouterLivre">
                    <i class="bi bi-plus-circle"></i> Ajouter Livre
                </button>
            </div>

            <!-- Modal d'ajout de livre -->
            <div class="modal fade" id="modalAjouterLivre" tabindex="-1" aria-labelledby="modalAjouterLivreLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalAjouterLivreLabel">Ajouter un nouveau livre</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="/livres/add" modelAttribute="livreadd" method="post">
                                <!-- Titre -->
                                <div class="mb-3">
                                    <label for="titre" class="form-label">Titre du livre</label>
                                    <input type="text" class="form-control" id="title" name="title" required>
                                </div>
                                <!-- Auteur -->
                                <div class="mb-3">
                                    <label for="auteur" class="form-label">Auteur du livre</label>
                                    <input type="text" class="form-control" id="author" name="author" required>
                                </div>
                                <!-- Genre -->
                                <div class="mb-3">
                                    <label for="genre" class="form-label">Genre du livre</label>
                                    <input type="text" class="form-control" id="genre" name="genre" required>
                                </div>
                                <!-- Année de parution -->
                                <div class="mb-3">
                                    <label for="anneeParution" class="form-label">Année de parution</label>
                                    <input type="number" class="form-control" id="anneeDePublication" name="anneeDePublication" required>
                                </div>
                                <!-- Disponibilité -->
                                <div class="mb-3">
                                    <label for="disponibilite" class="form-label">Disponibilité</label>
                                    <select class="form-control" id="disponibility" name="disponibility" required>
                                        <option value="true">Disponible</option>
                                        <option value="false">Indisponible</option>
                                    </select>
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

            <!-- Tableau des livres -->
            <div class="row border border-1 p-2 py-3 rounded-2">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col">N°</th>
                            <th scope="col">Titre</th>
                            <th scope="col">Auteur</th>
                            <th scope="col">Genre</th>
                            <th scope="col">Année de parution</th>
                            <th scope="col">Disponibilité</th>
                            <th scope="col" class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${livre}" var="livre" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${livre.title}</td>
                            <td>${livre.author}</td>
                            <td>${livre.genre}</td>
                            <td>${livre.anneeDePublication}</td>
                            <td>${livre.disponibility ? 'Disponible' : 'Indisponible'}</td>
                            <td class="text-center">
                                <!-- Bouton Modifier -->
                                <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modalModifier${livre.id}">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <!-- Bouton Supprimer -->
                                <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#modalSupprimer${livre.id}">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <c:forEach items="${livre}" var="livre">
                    <!-- Modale de modification de livre -->
                    <div class="modal fade" id="modalModifier${livre.id}" tabindex="-1" aria-labelledby="modalModifierLabel${livre.id}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalModifierLabel${livre.id}">Modifier le livre</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="/livres/change/${livre.id}" modelAttribute="changelivre" method="post">
                                        <div class="mb-3">
                                            <label for="titre${livre.id}" class="form-label">Titre</label>
                                            <input type="text" class="form-control" id="titre${livre.id}" name="title" value="${livre.title}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="auteur${livre.id}" class="form-label">Auteur</label>
                                            <input type="text" class="form-control" id="auteur${livre.id}" name="author" value="${livre.author}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="genre${livre.id}" class="form-label">Genre</label>
                                            <input type="text" class="form-control" id="genre${livre.id}" name="genre" value="${livre.genre}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="anneePublication${livre.id}" class="form-label">Année de publication</label>
                                            <input type="number" class="form-control" id="anneePublication${livre.id}" name="anneeDePublication" value="${livre.anneeDePublication}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="disponibilite${livre.id}" class="form-label">Disponibilité</label>
                                            <select class="form-control" id="disponibilite${livre.id}" name="disponibility" required>
                                                <option value="true" ${livre.disponibility ? 'selected' : ''}>Disponible</option>
                                                <option value="false" ${!livre.disponibility ? 'selected' : ''}>Indisponible</option>
                                            </select>
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

                    <!-- Modale de confirmation de suppression de livre -->
                    <div class="modal fade" id="modalSupprimer${livre.id}" tabindex="-1" aria-labelledby="modalSupprimerLabel${livre.id}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalSupprimerLabel${livre.id}">Confirmation de suppression</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <p>Êtes-vous sûr de vouloir supprimer le livre <strong>${livre.title}</strong> ?</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                    <a href="/livres/delete/${livre.id}" class="btn btn-danger">Supprimer</a>
                                </div>
                            </div>
                        </div>
                    </div>
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