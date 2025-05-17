# 1. Use an official Node image as the base
FROM node:20-alpine AS builder

# 2. Set working directory
WORKDIR /app

# 3. Copy package files and install dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# 4. Copy the rest of the source code
COPY . .

# 5. Build the app
RUN yarn build

# -----------------------------

# 6. Use a lightweight web server to serve the built app
FROM nginx:alpine AS production

# 7. Copy the built files from the builder
COPY --from=builder /app/dist /usr/share/nginx/html

# 8. Copy a custom NGINX config (optional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# 9. Expose port 80
EXPOSE 80

# 10. Start NGINX
CMD ["nginx", "-g", "daemon off;"]
