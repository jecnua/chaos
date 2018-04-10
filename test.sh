#!/usr/bin/env bash

docker build . -t jecnua:chaos
dgoss run -it jecnua:chaos
