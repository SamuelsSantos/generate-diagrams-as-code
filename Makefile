NAME=generate-diagrams-as-code

build:
	@docker image build -t $(NAME) .

tag:
	@docker tag $(NAME) samuelsantos/$(NAME):latest

push: build tag
	@docker push samuelsantos/$(NAME)