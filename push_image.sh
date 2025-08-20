#!/bin/sh -x

while getopts "e:a:s:" opt; do
    case "$opt" in
        e) env=${OPTARG};;
        a) aws_account_id=${OPTARG};;
        s) service=${OPTARG};;
    esac
done

aws ecr get-login-password --region us-west-2 --profile zero | docker login --username AWS --password-stdin 528757787051.dkr.ecr.us-west-2.amazonaws.com

docker tag base-image 528757787051.dkr.ecr.us-west-2.amazonaws.com/prod-base-image:go-latest
docker tag base-image 528757787051.dkr.ecr.us-west-2.amazonaws.com/prod-base-image:go-$(git rev-parse --short HEAD)
docker push 528757787051.dkr.ecr.us-west-2.amazonaws.com/prod-base-image:go-$(git rev-parse --short HEAD)
docker push 528757787051.dkr.ecr.us-west-2.amazonaws.com/prod-base-image:go-latest
