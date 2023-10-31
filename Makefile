docker_stack_name = grafana-loki

compose_files := -c docker-compose.yml
ifneq ("$(wildcard docker-compose.override.yml)","")
	compose_files += -c docker-compose.override.yml
endif

it:
	@echo "make [configs|deploy|destroy]"

.PHONY: configs
configs:
	test -f "configs/loki.yml" || cp configs/loki.default.yml configs/loki.yml

deploy: configs
	docker stack deploy $(compose_files) $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)



LOKI_DASHBOARD_DIR=https://raw.githubusercontent.com/grafana/loki/main/production/loki-mixin-compiled
define get_dashboard
	curl -L -o dashboards/$(1) $(LOKI_DASHBOARD_DIR)/dashboards/$(1)
endef

.PHONY: dashboards
dashboards:
	mkdir -p dashboards
	$(call get_dashboard,loki-chunks.json)
	$(call get_dashboard,loki-deletion.json)
	$(call get_dashboard,loki-logs.json)
	$(call get_dashboard,loki-mixin-recording-rules.json)
	$(call get_dashboard,loki-operational.json)
	$(call get_dashboard,loki-reads-resources.json)
	$(call get_dashboard,loki-reads.json)
	$(call get_dashboard,loki-retention.json)
	$(call get_dashboard,loki-writes-resources.json)
	$(call get_dashboard,loki-writes.json)
