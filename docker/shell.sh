#!/bin/bash

docker build -t dev ./. && docker run --rm -p 8000:8000 -v `pwd`:/app -it dev
