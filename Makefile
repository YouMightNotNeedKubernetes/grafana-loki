docker_stack_name = loki

it:
	@echo "make [configs|deploy|destroy]"

.PHONY: configs
configs:
	test -f "configs/loki.yaml" || cp configs/loki.default.yaml configs/loki.yaml

deploy: configs
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
