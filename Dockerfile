# MÁQUINA PARA COMPILAR
FROM node:alpine
WORKDIR '/app'
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

# MÁQUINA PARA PRODUCCIÓN
FROM nginx
EXPOSE 80
# Tenemos que copiar lo compilado en el paso anterior (estará en /app/build)
# De este modo utilizamos una máquina para compilar (node:alpine) y otra para producción (nginx)
COPY --from=0 /app/build /usr/share/nginx/html
# El servidor nginx se inicia él solo (no hace falta poner nada más)