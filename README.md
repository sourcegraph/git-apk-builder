# git-apk-builder

This lets you install git versions into Alpine linux versions.

For example, git@edge into Alpine v3.12 - which currently only has git 2.26 packages.

These scripts build Git in an Alpine v3.12 container in the same way the official Alpine
packaging process does (from the same source, using the same patches and tests.) It then uploads a
tarball of them to a GCP bucket.

To build and upload to our `apktmp` GCP bucket:

```sh
./build.sh
```

They can then be installed into an Alpine v3.12 Docker container (`docker run -it alpine:3.12`) using:

```sh
wget https://storage.googleapis.com/apktmp/git-edge-for-alpine-3-12-0bd5f13f2f.tar.gz
tar -xzf git-edge-for-alpine-3-12-0bd5f13f2f.tar.gz
cd target/main/x86_64/
apk add --allow-untrusted *.apk
cd ../../../
rm -rf target/
```
