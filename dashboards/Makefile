LOKI_DASHBOARD_DIR=https://raw.githubusercontent.com/grafana/loki/main/production/loki-mixin-compiled/dashboards

define get_dashboard
	curl -L -o $(1) $(LOKI_DASHBOARD_DIR)/$(1)
endef

it:
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
