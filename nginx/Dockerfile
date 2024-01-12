# Image Debian comme image de base
FROM debian:bullseye-slim

# Mise à jour des paquets et installation Nginx
RUN apt-get update && apt-get install -y nginx

# Suppression répertoire de configuration Nginx par défaut
RUN rm -rf /etc/nginx

# Copie des fichiers de configuration Nginx personnalisés et de la page HTML

# Port 80 pour les connexions HTTP
EXPOSE 80
EXPOSE 443

# Commande pour démarrer Nginx en mode démon
CMD ["nginx", "-g", "daemon off;"]
