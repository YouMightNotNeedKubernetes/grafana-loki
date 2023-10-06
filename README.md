# Grafana Loki
A high-availability Grafana Loki deployment for Docker Swarm

## Getting Started

You might need to create swarm-scoped overlay network called `dockerswarm_monitoring` for all the stacks to communicate if you haven't already.

```sh
$ docker network create --driver overlay --attachable dockerswarm_monitoring
```

We provided a base configuration file for Grafana Loki. You can find it in the `config` folder.  
Please make a copy as `configs/loki.yaml`, make sure to change the following values:

```yml
common:
  ring:
    kvstore:
      consul:
        host: consul:8500
        acl_token: secret

storage_config:
  aws:
    s3: http://minio:9000
    region: us-east-1
    bucketnames: loki
    access_key_id: access_key_id
    secret_access_key: secret_access_key
    insecure: true
    sse_encryption: false
    s3forcepathstyle: true

ruler:
  alertmanager_url: http://alertmanager:9093
```

And add any additional configuration you need to `configs/loki.yaml`.

## Deployment

To deploy the stack, run the following command:

```sh
$ make deploy
```

## Destroy

To destroy the stack, run the following command:

```sh
$ make destroy
```
