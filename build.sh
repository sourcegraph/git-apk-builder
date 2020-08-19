docker rm -f git-apk-builder
docker run --detach --name=git-apk-builder -it alpine:3.12 
docker cp build-git.sh git-apk-builder:/build-git.sh
docker exec -it git-apk-builder sh -c 'chmod +x /build-git.sh && /build-git.sh'
docker cp git-apk-builder:/target .

name="git-edge-for-alpine-3-12-$(git rev-parse --short HEAD).tar.gz"
tar cvfz $name target/
gsutil cp $name gs://apktmp/$name
