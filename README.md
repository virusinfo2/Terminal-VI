<h1>V 0.00.04</h1>

<h2>Liste des API</h2>

| **Variable** | **Description**                                                                                             | **Exemple**                           | **Utilisation**                                                                                                      |
|--------------|-------------------------------------------------------------------------------------------------------------|---------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| `%log%`      | Contient le chemin vers le fichier journal (log) utilisé pour enregistrer les événements, erreurs ou autres messages. | `systeme/logs/log1145.log`            | Utilisé pour centraliser les messages de log dans un script, facilitant ainsi la gestion des journaux et le diagnostic des problèmes. |
| `%tee%`      | Permet de lire le flux d'entrée et de le rediriger vers plusieurs sorties, notamment vers un fichier et vers la sortie standard. | `tee`                                 | Idéal pour enregistrer la sortie d'une commande tout en la montrant à l'écran en même temps.                       |
| `%7zip%`     | Utilitaire de compression/décompression de fichiers qui prend en charge divers formats comme .zip, .7z, .tar, etc. | `7z.exe`                              | Utilisé pour compresser ou extraire des archives. Très utile pour la gestion de fichiers volumineux ou l'archivage de données. |
| `%curl%`     | Outil de ligne de commande pour transférer des données depuis ou vers un serveur à l'aide de différents protocoles (HTTP, HTTPS, FTP, etc.). | `curl.exe`                            | Utilisé pour télécharger des fichiers, interagir avec des APIs web, ou envoyer des données à un serveur.            |
| `%findstr%`  | Outil de recherche de texte qui permet de rechercher des chaînes de caractères dans les fichiers.        | `findstr.exe`                         | Très utile pour filtrer et rechercher des informations spécifiques dans des fichiers de log ou autres fichiers texte. |
| `%xcopy%`    | Commande de copie avancée qui permet de copier des fichiers et des répertoires, avec des options supplémentaires par rapport à la commande copy. | `xcopy.exe`                           | Utilisé pour copier des fichiers et des dossiers avec des options telles que la copie récursive et la préservation des attributs. |
| `%nano%`     | Éditeur de texte en mode console, généralement utilisé sur Unix/Linux. | `nano` (alternatives sur Windows : Notepad++, Vim) | Utilisé pour éditer des fichiers texte directement depuis la ligne de commande.                                      |
| `%sha256%`   | Outil pour calculer la somme de contrôle SHA-256 d'un fichier, permettant de vérifier l'intégrité des données. | `CertUtil -hashfile` (Windows)         | Utilisé pour vérifier si un fichier a été modifié ou corrompu en comparant la somme de contrôle SHA-256.           |
| `%CRC32%`    | Outil pour calculer le code de redondance cyclique (CRC32) d'un fichier.                                    | `crc32.exe` (peut nécessiter un utilitaire tiers sur Windows) | Utilisé pour vérifier l'intégrité des fichiers en calculant et en comparant les valeurs CRC32.                      |
| `%nircmdc%`  | Outil de ligne de commande pour effectuer diverses tâches système, comme manipuler les fenêtres, ajuster le volume, etc. | `nircmd.exe`                          | Pratique pour automatiser des tâches administratives ou contrôler des aspects de l'interface utilisateur à partir de la ligne de commande. |
| `%wget%`     | Outil de téléchargement de fichiers à partir du web utilisant des protocoles comme HTTP, HTTPS et FTP.     | `wget.exe`                            | Utilisé pour télécharger des fichiers depuis le web ou automatiser le téléchargement de contenu.                    |

<div style="display: flex;">
  <img src="Img/OIG3%20(2).jpg" alt="Texte alternatif" width="400" style="margin-right: 10px;"/>
  <img src="Img/OIG4.jpg" alt="Texte alternatif" width="400"/>
</div>
