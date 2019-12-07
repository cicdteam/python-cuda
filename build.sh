#!/bin/bash

IMAGE_BASE_NAME="pure/python"

set -e

cat readme_header.md >README_.md

echo -e "## Supported tags\n" >>README_.md

for py in "3.8" "3.7" "3.6"; do
    echo -e "### Python $py\n" >>README_.md
    for cuda in "10.2" "10.1" "10.0" "9.0"; do
        echo -e "#### CUDA ${cuda}\n" >>README_.md
        IMAGE_PREFIX="${IMAGE_BASE_NAME}:${py}"


        echo "Building ${IMAGE_PREFIX}-cuda${cuda}-base"
        docker build \
            --quiet \
            --build-arg PY="${py}" \
            --tag "${IMAGE_PREFIX}-cuda${cuda}-base" \
            "${cuda}/base"
        echo

        echo "Building ${IMAGE_PREFIX}-cuda${cuda}-runtime"
        docker build \
            --quiet \
            --build-arg IMAGE_PREFIX="${IMAGE_PREFIX}" \
            --build-arg CUDA="${cuda}" \
            --tag "${IMAGE_PREFIX}-cuda${cuda}-runtime" \
            "${cuda}/runtime"
        echo

        echo "Building ${IMAGE_PREFIX}-cuda${cuda}-cudnn7-runtime"
        docker build \
            --quiet \
            --build-arg IMAGE_PREFIX="${IMAGE_PREFIX}" \
            --build-arg CUDA="${cuda}" \
            --tag "${IMAGE_PREFIX}-cuda${cuda}-cudnn7-runtime" \
            "${cuda}/runtime/cudnn7"
        echo

        echo "Pushing images to repository"
        docker push "${IMAGE_PREFIX}-cuda${cuda}-base"
        docker push "${IMAGE_PREFIX}-cuda${cuda}-runtime"
        docker push "${IMAGE_PREFIX}-cuda${cuda}-cudnn7-runtime"
        echo

echo "- [\`${IMAGE_PREFIX}-cuda$cuda}-base\` (*${cuda}/base/Dockerfile*)](${cuda}/base/Dockerfile)" >>README_.md
echo "- [\`${IMAGE_PREFIX}-runtime-py${py}\` (*${cuda}/runtime/Dockerfile*)](${cuda}/runtime/Dockerfile)" >>README_.md
echo "- [\`${IMAGE_PREFIX}-cudnn7-runtime-py${py}\` (*${cuda}/runtime/cudnn7/Dockerfile*)](${cuda}/runtime/cudnn7/Dockerfile)" >>README_.md
echo "" >>README_.md

    done
done

mv -f README_.md README.md
