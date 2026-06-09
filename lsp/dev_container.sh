#!/bin/bash

root="$(pwd)"

create_docker_named_volume()
{
    sudo docker volume create --driver local \
    --opt type=none \
    --opt o=bind \
    --opt device=$PWD/.docker-deps/usr/include \
    clang_usr_include_vol
}

start_docker_container_using_volume()
{
    sudo docker run -dit --name clang \
        -v $PWD:$PWD \
        -v clang_usr_include_vol:/usr/include \
        -w $PWD \
        clang sleep infinity
}

# --path-mappings is evaluated left->right so matching child directories needs to be done
# first so that those "rules" take precedent. Eg $root=$root also matches $root/.docker-deps/...
# so there would be no copy if this rule was placed first.
# Placing $root/.docker-deps first means that this rule matches the specific case first
# then we match on the generic case of $root=$root
sudo docker exec -i clang clangd \
    --path-mappings="$root/.docker-deps/usr/include=/usr/include,$root=$root"
