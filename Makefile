PORT=8080
BUCKET=learnjs-$(shell date +%Y%m%d%H%m%S)
URL=http://learnjs-20180504190555.s3-website.us-east-1.amazonaws.com/

all: endpoint.txt

output:
	@echo URL=http://$(shell cat bucket.txt).s3-website-$(shell aws configure get region).amazonaws.com

server:
	cd public; python -m http.server $(PORT)

bucket.txt:
	echo $(BUCKET) > $@

endpoint.txt: bucket.txt
	aws s3 mb s3://$(shell cat bucket.txt)
	aws s3 website --index-document index.html s3://$(shell cat bucket.txt)

deploy: endpoint.txt
	aws s3 sync public/ s3://$(shell cat bucket.txt) --acl public-read

clean:
	-aws s3 rb --force s3://$(shell cat bucket.txt)
	-rm bucket.txt
