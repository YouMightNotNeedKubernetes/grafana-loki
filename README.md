# Grafana Loki
A high-availability Grafana Loki deployment for Docker Swarm

## Getting Started

You might need to create swarm-scoped overlay network called `dockerswarm_monitoring` for all the stacks to communicate if you haven't already.

```sh
$ docker network create --scope=swarm --driver overlay --attachable dockerswarm_monitoring
```

We provided a base configuration file for Grafana Loki. You can find it in the `config` folder.  
Please make a copy as `configs/loki.yml`, make sure to change the following values:

```yml
common:
  # ...
  ring:
    kvstore:
      # ...
      store: consul
      consul:
        # !!! IMPORTANT !!!
        # ! Update this to the IP address of your Consul server
        host: 10.10.201.201:8500
        # acl_token: secret
  storage:
    # !!! IMPORTANT !!!
    # ! Update this to the IP address of your Minio server or S3 endpoint
    s3: 
      endpoint: http://10.10.201.201:9000
      region: us-east-1
      insecure: true
      bucketnames: loki
      access_key_id: minioadmin
      secret_access_key: minioadmin
      sse_encryption: false
      s3forcepathstyle: true
```

And add any additional configuration you need to `configs/loki.yml`.

### Object Storage buckets

You need to create the following buckets in your object storage:
- `loki`

You can change the bucket names in the `configs/loki.yml` file. Look for the `bucketnames` property.

**Example**
```yaml
storage_config:
  aws:
    bucketnames: loki  # Change this to your bucket name
```

## Dashboard

You can find a dashboard for Grafana Loki in the `dashboard` folder.

You might find that you need to make some modifications to the dashboard to make it work with your setup.

**Fix `job` label**:
```sh
Find: job=~\\"\(?\$namespace\)?/(.+?(?:\.\*)?)\\"
Replace: job=~\"$namespace/(loki|$1)\"
```

**Fix `container` label**:
```sh
Find: container=~?\\"(compactor|distributor|index-gateway|ingester|querier|query-frontend|query-scheduler|ruler)\\"
Replace: container=~\"(loki|$1)\"
```
And the following:
```sh
Find: (kube_deployment_created|kube_pod_container_info)
Replace: loki_build_info
```

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
