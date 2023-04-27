FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Path for build: /app/build

FROM nginx 
# the /usr/share/nginx/html is the default path for nginx to serve static files
COPY --from=builder /app/build /usr/share/nginx/html
# no need to specify CMD because nginx image has a default CMD to start nginx