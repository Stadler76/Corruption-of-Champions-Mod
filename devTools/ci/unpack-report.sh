#! /bin/sh

# create the directory where report will be extracted into
mkdir -p ci-report

# decode and decompress the report
cat $1 | base64 -di | tar xzC ci-report
