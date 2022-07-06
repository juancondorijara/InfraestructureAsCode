.PHONY: tf-init
tf-init:
	docker-compose -f deploy/docker-compose.yml run --rm terraform init

.PHONY: tf-fmt
tf-fmt:
	docker-compose -f deploy/docker-compose.yml run --rm terraform fmt

.PHONY: tf-validate
tf-validate:
	docker-compose -f deploy/docker-compose.yml run --rm terraform validate

.PHONY: tf-plan
tf-plan:
	docker-compose -f deploy/docker-compose.yml run --rm terraform plan

.PHONY: tf-apply
tf-apply:
	docker-compose -f deploy/docker-compose.yml run --rm terraform apply

.PHONY: tf-destroy
tf-destroy:
	docker-compose -f deploy/docker-compose.yml run --rm terraform destroy

.PHONY: tf-workspace-dev
tf-workspace-dev:
	docker-compose -f deploy/docker-compose.yml run --rm terraform workspace select dev

.PHONY: tf-workspace-staging
tf-workspace-staging:
	docker-compose -f deploy/docker-compose.yml run --rm terraform workspace select staging

.PHONY: tf-workspace-prod
tf-workspace-prod:
	docker-compose -f deploy/docker-compose.yml run --rm terraform workspace select prod

.PHONY: test
test:
	docker-compose run --rm app sh -c "python manage.py wait_for_db && python manage.py test && flake8"
