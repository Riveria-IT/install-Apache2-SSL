#!/bin/bash
set -e

echo "🔧 Apache2 + SSL Setup"

# === Benutzer-Eingaben ===
read -p "🌐 Gib deine Domain ein (z.B. meine-domain.ch): " DOMAIN
read -p "📧 Gib deine E-Mail für Let's Encrypt an: " EMAIL

# === Apache & Certbot installieren ===
echo "📦 System aktualisieren und benötigte Pakete installieren..."
apt update && apt upgrade -y
apt install apache2 certbot python3-certbot-apache -y

# === Webverzeichnis ===
echo "📁 Erstelle Webverzeichnis für $DOMAIN..."
mkdir -p /var/www/$DOMAIN
chown -R www-data:www-data /var/www/$DOMAIN

# === Beispiel-HTML-Datei ===
echo "📄 Erstelle Beispiel-Startseite..."
cat <<EOF > /var/www/$DOMAIN/index.html
<html>
  <head><title>$DOMAIN</title></head>
  <body><h1>SSL aktiviert auf $DOMAIN 🔐</h1></body>
</html>
EOF

# === Apache-Konfiguration ===
echo "🛠️ Apache VirtualHost konfigurieren..."
cat <<EOF > /etc/apache2/sites-available/$DOMAIN.conf
<VirtualHost *:80>
    ServerName $DOMAIN
    DocumentRoot /var/www/$DOMAIN
    <Directory /var/www/$DOMAIN>
        Options -Indexes +FollowSymLinks
        AllowOverride All
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/$DOMAIN-error.log
    CustomLog \${APACHE_LOG_DIR}/$DOMAIN-access.log combined
</VirtualHost>
EOF

# === Apache aktivieren ===
echo "🔗 Apache-Site aktivieren..."
a2ensite $DOMAIN
a2dissite 000-default
systemctl reload apache2

# === SSL-Zertifikat anfordern ===
echo "🔒 Fordere SSL-Zertifikat über Let's Encrypt an..."
certbot --apache -d $DOMAIN --non-interactive --agree-tos -m $EMAIL

# === Abschluss ===
echo ""
echo "✅ Fertig! Deine Website ist erreichbar unter:"
echo "   → http://$DOMAIN"
echo "   → https://$DOMAIN (mit gültigem SSL-Zertifikat)"
