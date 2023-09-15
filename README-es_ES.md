<div align="center">
    <p>
      <img src="images/logo.png" alt="Half-life Servidor dedicado para Linux" />
    </p>
    <p>
      <a href="README.md"><img src="images/en_US.png" alt="English Language"/> English</a> — <a href="README-es_ES.md"><img src="images/es_ES.png" alt="Idioma Español"/> Español</a>
    </p>
</div>

# Half-life Servidor dedicado para Linux (Debian 12)

Archivos base obtenidos desde la misma Steam.

## 🔧 Instalación

We have two ways to use this:

- [Sin Docker](#sin-docker)
- [Con Docker (la manera facil)](#con-docker)

### Sin Docker:

para que sea más facil, **clona el repositorio dentro de tu carpeta 'home'**, es decir /home/tuCarpetaHome/ <--- aquí

1. Primero es necesario ejecutar cada línea por separado en la terminal, para instalar algunas cosas del sistema que se necesitan para ejecutar el servidor porque es de 32 bits.

```
sudo apt-get update
sudo apt-get install -y --no-install-recommends ca-certificates
sudo update-ca-certificates
sudo dpkg --add-architecture i386
sudo apt -y update
sudo apt -y install lib32gcc-s1
```

2. ahora se crea un enlace simbólico
   > no son necesarios permisos de root

```
mkdir -v /home/$USER/.steam
ln -s /home/$USER/hlds/server /home/$USER/.steam/sdk32
```

y eso es todo!

Ahora, para correr el server:

```
/home/$USER/hlds/server/hlds_run -game valve -port 27015 +maxplayers 15 +sv_lan 0 +map crossfire -insecure -usercon
```

### Con Docker

> es necesario tener instalado el Docker obviamente :v

- Sólo tenemos que correr el siguiente comando:

```
docker run -d --name hlds\
 -p 26900:26900/udp\
 -p 27020:27020/udp\
 -p 27015:27015/udp\
 -p 27015:27015\
 -e SERVER_NAME="My HL Server"\
 -e START_MAP="crossfire"\
 -e MAXPLAYERS="32"\
 -e RCON_PASSWORD="secret"\
 dapize/hlds:latest
```

#### Detener el servidor:

```
 docker stop hlds
```

#### Iniciar el servidor (que está detenido):

```
 docker start hlds
```

⚡Existen algúnas variables de entorno opcionales, tales como:

```
RESTART_ON_FAIL => 0 or 1
SV_LAN => 0 or 1
SERVER_PASSWORD => cualquierCosa
```

> OJO: Con Docker los archivos están alojados en la ruta: /opt/hlds

## 📚 ¿Necesitas ayuda?

Hazme saber si tienes alguna duda

## 🧾 License

El código y documentación son publicados bajo la licencia [MIT](LICENSE).
