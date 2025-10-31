FROM node:20-alpine AS base

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Copy source
COPY . .

# Install LangChain + Chroma
RUN npm install langchain @langchain/community chromadb

# Build Next.js
RUN npm run build

EXPOSE 3000