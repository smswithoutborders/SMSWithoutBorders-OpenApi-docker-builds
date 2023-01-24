REPOS=repos

DEV-FRONT-END=dev-front-end
DEV-BACK-END=dev-back-end
OPEN-API=open-api
RABBITMQ=rabbitmq

make: clone

deps:
	@mkdir -p ${REPOS}

clone: deps
	@git clone https://github.com/smswithoutborders/SMSWithoutBorders-Dev-FE.git ${REPOS}/${DEV-FRONT-END} & \
	git clone https://github.com/smswithoutborders/SMSWithoutBorders-Dev-BE.git ${REPOS}/${DEV-BACK-END} & \
	git clone https://github.com/smswithoutborders/SMSWithoutBorders-OpenAPI.git ${REPOS}/${OPEN-API} & \
	git clone https://github.com/smswithoutborders/SMSWithoutBorders-Product-deps-RabbitMQ.git ${REPOS}/${RABBITMQ}

staging: clone
	@git -C ${REPOS}/${DEV-FRONT-END} checkout staging
	@git -C ${REPOS}/${DEV-BACK-END} checkout staging
	@git -C ${REPOS}/${OPEN-API} checkout staging
	@git -C ${REPOS}/${RABBITMQ} checkout staging

update:
	@git -C ${REPOS}/${DEV-FRONT-END} pull -r origin staging
	@git -C ${REPOS}/${DEV-BACK-END} pull -r origin staging
	@git -C ${REPOS}/${OPEN-API} pull origin staging
	@git -C ${REPOS}/${RABBITMQ} pull origin staging

fuckit:
	docker rm -vf $(docker ps -aq)
	docker rmi -f $(docker images -aq)
	docker system prune -a --volumes
