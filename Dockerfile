FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Tenemos que compiar lo compilado en el paso anterior (estará en /app/build)
# Así usamos una máquina para compilar (node:alpine) y otra para producción (nginx)
COPY --from=builder /app/build /usr/share/nginx/html
# El servidor nginx se inicia él solo (no hace falta poner nada más)