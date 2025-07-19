# Apache2 mit SSL (Let's Encrypt) – Automatisches Setup

Dieses Script installiert automatisch Apache2 auf einem Debian- oder Ubuntu-Server, erstellt eine einfache Beispiel-Webseite und sichert die Domain mit einem kostenlosen Let's Encrypt SSL-Zertifikat.

## ⚙️ Funktionen

- Apache2-Installation
- Einrichtung eines Webverzeichnisses
- Konfiguration eines VirtualHosts
- Automatische SSL-Zertifikatsanforderung via Certbot
- HTTPS-Unterstützung aktiviert

## 🧾 Voraussetzungen

- Eine registrierte Domain (z. B. `meine-domain.ch`)
- Die Domain zeigt per A-Record auf deinen Server (IPv4)
- Port 80 und 443 sind offen
- Root-Zugriff auf deinen Server

## 🚀 Installation

```bash
wget https://raw.githubusercontent.com/Riveria-IT/install-Apache2-SSL/main/apache2-ssl-setup.sh
chmod +x apache2-ssl-setup.sh
./apache2-ssl-setup.sh
