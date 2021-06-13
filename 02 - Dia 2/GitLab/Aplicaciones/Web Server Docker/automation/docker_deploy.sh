#!/bin/bash
docker run -d --name web-server --restart=always -p 80:80 web-server
set +x