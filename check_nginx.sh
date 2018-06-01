#!/bin/bash

if [ $(ps -C nginx --no-headers | wc -l) -eq 0 ]; then
    exit 1
fi
