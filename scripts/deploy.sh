#!/bin/bash
set -e

echo "Iniciando deploy..."

cd ~/realmtech

echo "Atualizando repositório..."
git pull

echo "Deploy infra..."
docker stack deploy -c infra/infra.yaml infra

sleep 5

echo "Deploy app..."
docker stack deploy -c app/app.yaml app

echo "Limpando imagens antigas..."
docker image prune -f

echo "Deploy finalizado!"

