deploy:
	docker buildx build --platform linux/arm64 -t base-image -f docker/Dockerfile .
	./push_image.sh
