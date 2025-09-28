# build stage
FROM node:20-alpine AS build
FROM python:3.6-slim AS py
WORKDIR /app

# Install build deps (no dev tools in final image)
COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npm run build

# runtime stage - use a minimal image, non-root user
FROM gcr.io/distroless/nodejs:20
# If distroless isn't an option for you, use: node:20-alpine (but remove package manager)
WORKDIR /app

# Copy only artifacts needed to run
COPY --from=build /app/package.json /app/package-lock.json /app/
COPY --from=build /app/dist /app/dist

# Create and use a non-root user (distroless images often run as non-root by default)
# If using an image that requires: (example for non-distroless images)
# RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# USER appuser

ENV NODE_ENV=production
EXPOSE 3000

# Avoid embedding secrets — use runtime env or secret stores
CMD ["./dist/server.js"]
