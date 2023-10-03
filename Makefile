docker_stack_name = loki

it:
	@echo "make [deploy|destroy]"

deploy:
	test -f "configs/loki.yaml" || cp configs/loki.base.yaml configs/loki.yaml
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
