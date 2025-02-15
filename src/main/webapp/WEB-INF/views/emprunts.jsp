<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>BIBLIO | Emprunts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
</head>
<body>
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">Biblio</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" title="menu">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="/">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/livres">Livres</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/emprunts">Emprunts</a>
                    </li>
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
            <h2 class="mb-3 text-left">📚 Gestion des Emprunts</h2>

            <!-- Affichage des messages de notification -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>
            
            <!-- Bouton pour ajouter un emprunt -->
            <div class="d-flex justify-content-end">
                <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalAjouterEmprunt">
                    <i class="bi bi-plus-circle"></i> Ajouter Emprunt
                </button>
            </div>
            
            <!-- Modal d'ajout d'emprunt -->
            <div class="modal fade" id="modalAjouterEmprunt" tabindex="-1" aria-labelledby="modalAjouterEmpruntLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalAjouterEmpruntLabel">Ajouter un nouvel emprunt</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="/emprunts/add" method="post">
                                <!-- Utilisateur -->
                                <div class="mb-3">
                                    <label for="userId" class="form-label">Utilisateur</label>
                                    <select class="form-control" id="userId" name="user_id" required>
                                        <c:forEach items="${users}" var="user">
                                            <option value="${user.id}">${user.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <!-- Livre -->
                                <div class="mb-3">
                                    <label for="bookId" class="form-label">Livre</label>
                                    <select class="form-control" id="bookId" name="book_id" required>
                                        <c:forEach items="${books}" var="book">
                                            <option value="${book.id}">${book.title}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <!-- Date d'emprunt -->
                                <div class="mb-3">
                                    <label for="dateEmprunt" class="form-label">Date d'emprunt</label>
                                    <input type="date" class="form-control" id="dateEmprunt" name="dateEmprunt" required>
                                </div>
                                <!-- Date de retour -->
                                <div class="mb-3">
                                    <label for="dateRetour" class="form-label">Date de retour</label>
                                    <input type="date" class="form-control" id="dateRetour" name="dateRetour" required>
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
            
            <!-- Tableau des emprunts -->
            <div class="row border border-1 p-2 py-3 rounded-2">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col">N°</th>
                            <th scope="col">Date d'emprunt</th>
                            <th scope="col">Date de retour</th>
                            <th scope="col">Statut</th>
                            <th scope="col">Utilisateur</th>
                            <th scope="col">Livre</th>
                            <th scope="col" class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${borrows}" var="borrow" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${borrow.dateEmprunt}</td>
                                <td>${borrow.dateRetour}</td>
                                <td>${borrow.statut}</td>
                                <td>${borrow.user.name}</td>
                                <td>${borrow.book.title}</td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modalModifier${borrow.id}">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#modalSupprimer${borrow.id}">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <!-- Modales pour chaque emprunt -->
                <c:forEach items="${borrows}" var="borrow">
                    <!-- Modale de modification d'emprunt -->
                    <div class="modal fade" id="modalModifier${borrow.id}" tabindex="-1" aria-labelledby="modalModifierLabel${borrow.id}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalModifierLabel${borrow.id}">Modifier l'emprunt</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="/emprunts/change/${borrow.id}" method="post">
                                        <!-- Utilisateur -->
                                        <div class="mb-3">
                                            <label for="userId${borrow.id}" class="form-label">Utilisateur</label>
                                            <select class="form-control" id="userId${borrow.id}" name="user_id" required>
                                                <c:forEach items="${users}" var="user">
                                                    <option value="${user.id}" <c:if test="${user.id == borrow.user.id}">selected</c:if>>${user.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <!-- Livre -->
                                        <div class="mb-3">
                                            <label for="bookId${borrow.id}" class="form-label">Livre</label>
                                            <select class="form-control" id="bookId${borrow.id}" name="book_id" required>
                                                <c:forEach items="${books}" var="book">
                                                    <option value="${book.id}" <c:if test="${book.id == borrow.book.id}">selected</c:if>>${book.title}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <!-- Date d'emprunt -->
                                        <div class="mb-3">
                                            <label for="dateEmprunt${borrow.id}" class="form-label">Date d'emprunt</label>
                                            <input type="date" class="form-control" id="dateEmprunt${borrow.id}" name="dateEmprunt" value="${borrow.dateEmprunt}" required>
                                        </div>
                                        <!-- Date de retour -->
                                        <div class="mb-3">
                                            <label for="dateRetour${borrow.id}" class="form-label">Date de retour</label>
                                            <input type="date" class="form-control" id="dateRetour${borrow.id}" name="dateRetour" value="${borrow.dateRetour}" required>
                                        </div>
                                        <!-- Statut -->
                                        <div class="mb-3">
                                            <label for="statut${borrow.id}" class="form-label">Statut</label>
                                            <select class="form-control" id="statut${borrow.id}" name="statut" required>
                                                <option value="true" <c:if test="${borrow.statut == 'En cours'}">selected</c:if>>En cours</option>
                                                <option value="false" <c:if test="${borrow.statut == 'Retourné'}">selected</c:if>>Retourné</option>
                                            </select>
                                        </div>
                                        <!-- Boutons -->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                            <button type="submit" class="btn btn-primary">Enregistrer</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Modale de confirmation de suppression d'emprunt -->
                    <div class="modal fade" id="modalSupprimer${borrow.id}" tabindex="-1" aria-labelledby="modalSupprimerLabel${borrow.id}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalSupprimerLabel${borrow.id}">Confirmation de suppression</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Êtes-vous sûr de vouloir supprimer l'emprunt du livre 
                                        <strong>${borrow.book.title}</strong> ?
                                    </p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                    <a href="/emprunts/delete/${borrow.id}" class="btn btn-danger">Supprimer</a>
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