docker_stack_name = loki

-include .env.example
-include .env.local

it:
	@echo "make [deploy|destroy]"

deploy:
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
