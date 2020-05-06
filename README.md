# Infomation

- `ROOT v6.20.04`
- `Python v3.7.6`
- `Jupyter Notebook v6.0.3`
- `Jupyter Lab v1.2.5`

# Warning

- **Do not change the directory name of `notebook`**
  since its relative path from `docker-compose.yml` is so important.

# How to use

Install `Docker`( See https://docs.docker.com/get-docker/ ) and
clone this repository :
```sh

```

## Docker Desktop for Windows/Mac

1. Check if `Docker` is running.
2. Create the container :
   ```sh
   docker-compose up -d
   ```
3. Open http://localhost:8889 in your web browser
   and log in to Jupyter Notebook.
   **The default password is `hep`.**
4. Stop and destroy the container.
   ```sh
   docker-compose down
   ```

## Docker Toolbox

1. Check if `Docker` is running.
2. Create the container :
   ```sh
   docker-compose up -d
   ```
3. Check your virtual machine IP address :
   ```sh
   docker-machine ip default # `default` is your virtual machine name
   > 192.168.23.67 # example
   ```
4. Open http://192.168.23.67:8889 in your web browser
   and log in to Jupyter Notebook.
   **The default password is `hep`.**
5. Stop and destroy the container :
   ```sh
   docker-compose down
   ```
