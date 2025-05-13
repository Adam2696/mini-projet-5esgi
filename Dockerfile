# Étape 1: Choisir l'image de base
FROM python:3.6-alpine

# Étape 2: Définir le répertoire de travail
WORKDIR /opt

# Étape 3: Copier les fichiers de l'application dans le conteneur
COPY . /opt/

# Étape 4: Installer les dépendances nécessaires (Flask)
RUN pip install --no-cache-dir -r requirements.txt

# Étape 5: Définir les variables d'environnement pour les URL
ENV ODOO_URL=http://odoo:8069
ENV PGADMIN_URL=http://pgadmin:80

# Étape 6: Exposer le port 8080 pour l'application
EXPOSE 8080

# Étape 7: Lancer l'application Flask avec python
ENTRYPOINT ["python", "app.py"]
