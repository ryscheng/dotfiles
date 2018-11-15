#!/bin/bash

docker build -t dev ~/Downloads/code/docker/. && docker run --rm -p 8000:8000 -v `pwd`:/app -it dev
