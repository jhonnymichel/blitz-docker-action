#!/bin/bash

./docker-scripts/wait-for-it.sh --timeout=0 postgres:5432 -- yarn start
